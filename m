From: Konstantin Stepaniuk <s.k.v@mail.ru>
Subject: Re: exit() -> _exit() in pcm_direct.c
Date: Wed, 30 Jul 2003 23:21:52 +0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3F281AD0.5090402@mail.ru>
References: <Pine.LNX.4.44.0307301918500.9821-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.44.0307301918500.9821-100000@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Jaroslav Kysela wrote:

>On Wed, 30 Jul 2003, Konstantin Stepaniuk wrote:
>
>  
>
>>Hello.
>>
>>My program call snd_pcm_open() with "plug:dmix" in thread.
>>Function snd_pcm_direct_server_create() hangs on waitpid() if exit() is used, 
>>and server_job process keeps alive after program exit.
>>This trivial patch chages exit() to _exit() in file pcm_direct.c. In this case 
>>all works ok for me.
>>    
>>
>
>I'm sorry, but I still don't see a reason (I'd like to know, why the 
>process hangs). Could you explain the behaviour or send me a simple test 
>code to debug this thing?
>
>						Jaroslav
>
>-----
>Jaroslav Kysela <perex@suse.cz>
>Linux Kernel Sound Maintainer
>ALSA Project, SuSE Labs
>  
>
Here's a test:
/* dmix.c */
#define ALSA_PCM_NEW_HW_PARAMS_API
#define ALSA_PCM_NEW_SW_PARAMS_API
#include <alsa/asoundlib.h>
#include <pthread.h>
#include <stdio.h>

void *thread_routine( void *param )
{
  snd_pcm_t *pcm;
  int err;

  err = snd_pcm_open( &pcm, "plug:dmix",
    SND_PCM_STREAM_PLAYBACK, SND_PCM_NONBLOCK );

  if( err < 0 )
  {
    fprintf( stderr, "%s\n", snd_strerror(err) );
    return NULL;
  }

  printf( "alsa opened\n" );

  snd_pcm_close( pcm );
  return NULL;
}

int main( void )
{
  pthread_t thread;
  int i;

  if( pthread_create( &thread, 0, thread_routine, NULL ) )
  {
    fprintf( stderr, "pthread_create failure\n" );
    return -1;
  }
   
  pthread_join( thread, NULL );
  return 0;
}
/*--------------------*/

This program crashes without any error message and doesn't print "alsa 
opened".

sound card: intel8x0
alsa version: cvs snapshot 2003-07-30
kernel version: 2.4.21 (Debian)
glibc: 2.3.1

This works ok with cmipci card. Maybe problem with intel8x0?

P.S. Add please '\n' in aplay version string :)




-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
