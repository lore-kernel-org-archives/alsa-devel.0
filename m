From: Steve Leung <sjleung@shaw.ca>
Subject: dmix deadlock w/ multithreading?
Date: Thu, 19 Jun 2003 22:11:28 -0600 (MDT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.56.0306192200010.3921@amelia.homelinux.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
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


I'm having some trouble using dmix with a multithreaded program that
has to close and reopen the sound device.  Closing and opening happens
in different threads.

I'm using alsa-lib 0.9.4 and I've got dmix set up to be the default
device.  That is, my .asoundrc looks like this:

pcm.!default {
        type plug
        slave.pcm "dmix"
}

The short program at the end of this message opens and closes the
sound device in one thread, and then tries to do the same in another
thread.  It consistently deadlocks when the second thread tries to
open the sound device.

If I comment out my .asoundrc, the program works fine without hanging.
I also notice that if another program is busy playing through dmix
when this program starts, then the hang will not occur.  Other
programs such as aplay are able to use dmix without trouble.

Is this expected behaviour?  I notice that after I close the device
the first time (and the program is still running), I can run 'fuser
/dev/snd/pcmC0D0p' and it reports that the device is still being used
by my test program.

I'm using alsa-driver 0.9.4 (kernel 2.4.21) on cmipci hardware.  I've
had reports that this code does not hang with the ymfpci driver.
Kernel OSS pcm/mixer emulation is enabled.  More info available upon
request.

Thanks for any help.

Steve


/* CODE BEGINS HERE */
#include <alsa/asoundlib.h>
#include <alsa/pcm.h>
#include <pthread.h>
#include <stdio.h>

void* threadFunc( void* unused )
  {
  int err;
  snd_pcm_t *alsa_pcm = NULL;

  printf( "%d opening\n", pthread_self() );
  err = snd_pcm_open(&alsa_pcm, "default", SND_PCM_STREAM_PLAYBACK, 0);
  printf( "%d opened %d\n", pthread_self(), err );

  printf( "%d closing\n", pthread_self() );
  err = snd_pcm_close(alsa_pcm);
  printf( "%d closed %d\n", pthread_self(), err );

  return NULL;
  }

int main(void)
  {
  pthread_t firstThread;
  pthread_create( &firstThread, NULL, threadFunc, NULL );
  pthread_join( firstThread, NULL );

  /* Commenting out this sleep seems to eliminate the deadlock most
   * of the time */
  sleep( 1 );

  pthread_t secondThread;
  pthread_create( &secondThread, NULL, threadFunc, NULL );
  pthread_join( secondThread, NULL );

  getc( stdin );
  return 0;
  }


-------------------------------------------------------
This SF.Net email is sponsored by: INetU
Attention Web Developers & Consultants: Become An INetU Hosting Partner.
Refer Dedicated Servers. We Manage Them. You Get 10% Monthly Commission!
INetU Dedicated Managed Hosting http://www.inetu.net/partner/index.php
