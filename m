From: Konstantin Stepaniuk <s.k.v@mail.ru>
Subject: reopen with "plug:dmix" failure
Date: Tue, 15 Jul 2003 14:09:21 +0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200307151409.21657.s.k.v@mail.ru>
Reply-To: s.k.v@mail.ru
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Dear Jaroslav Kysela.

I wrote some example which illustrates problem described in previous message. 
Also I want you to make some fixes in your library which can avoid this 
problem. First of all I discommented lines 325-326 in file pcm_direct.c 
(because even after application stopped server still process and device 
/dev/snd/pcmC0D0p locked). After that I added one line, which unlink 
temporary file /tmp/alsa-dmix*.

//----------- example ------------------------------
#include <alsa/asoundlib.h>
#include <pthread.h>
#include <stdio.h>
#include <unistd.h>

void *thread_routine( void *param ) {
  snd_pcm_t *pcm;
  int err;

  printf( "%d: start\n", getpid() );

  err = snd_pcm_open( &pcm,
		      "plug:dmix",
		      SND_PCM_STREAM_PLAYBACK,
		      SND_PCM_NONBLOCK );

  if( err < 0 ) {
    fprintf( stderr, "%s\n", snd_strerror(err) );
    return NULL;
  }

  snd_pcm_close( pcm );

  printf( "%d: finish\n", getpid() );
  return NULL;
}

int main( void ) {
  pthread_t thread;
  int i =0;

  printf( "main pid: %d\n", getpid() );

  for( i=0; i<2; ++i ) {
    if( pthread_create( &thread, 0, thread_routine, NULL ) ) {
      fprintf( stderr, "pthread_create failure\n" );
      exit( -1 );
    }
    pthread_join( thread, 0 );
  }

  return 0;
}

//----------- patch ------------------------------

--- pcm_direct.c.orig	2003-07-15 13:48:56.000000000 +0400
+++ pcm_direct.c	2003-07-15 13:50:37.000000000 +0400
@@ -322,13 +322,14 @@
 int snd_pcm_direct_server_discard(snd_pcm_direct_t *dmix)
 {
 	if (dmix->server) {
-		//kill(dmix->server_pid, SIGTERM);
-		//waitpid(dmix->server_pid, NULL, 0);
+		kill(dmix->server_pid, SIGTERM);
+		waitpid(dmix->server_pid, NULL, 0);
 		dmix->server_pid = (pid_t)-1;
 	}
 	if (dmix->server_fd > 0) {
 		close(dmix->server_fd);
 		dmix->server_fd = -1;
+    unlink( dmix->shmptr->socket_name );
 	}
 	dmix->server = 0;
 	return 0;

-- 
Cheers, Konstantin Stepaniuk



-------------------------------------------------------
This SF.Net email sponsored by: Parasoft
Error proof Web apps, automate testing & more.
Download & eval WebKing and get a free book.
www.parasoft.com/bulletproofapps1
