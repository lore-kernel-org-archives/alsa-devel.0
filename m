From: Konstantin Stepaniuk <s.k.v@mail.ru>
Subject: Memory leak in the dmix plugin?
Date: Fri, 29 Aug 2003 19:15:12 +0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200308291915.12389.s.k.v@mail.ru>
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

Hi,

I've found a problem with the dmix plugin. This simple test demonstrates the bug.

//--------------------
#define ALSA_PCM_NEW_HW_PARAMS_API
#define ALSA_PCM_NEW_SW_PARAMS_API
#include <alsa/asoundlib.h>
#include <stdio.h>
#include <stdlib.h>

#define ALSA_ERROR(e) if( (e) < 0 ) { fprintf( stderr, "%s\n", snd_strerror((e)) ); exit(-1); }

int main( void )
{
  for( ;; )
  {
    snd_pcm_t           *pcm;
    snd_pcm_hw_params_t *hwparams;
    int                  err;

    err = snd_pcm_open( &pcm, "plug:dmix", SND_PCM_STREAM_PLAYBACK, SND_PCM_NONBLOCK );
    ALSA_ERROR(err);

    snd_config_update_free_global();

    err = snd_pcm_hw_params_malloc( &hwparams );
    ALSA_ERROR(err);

    err = snd_pcm_hw_params_any( pcm, hwparams );
    ALSA_ERROR(err);

    err = snd_pcm_hw_params( pcm, hwparams );
    ALSA_ERROR(err);

    snd_pcm_hw_params_free( hwparams );
    snd_pcm_close( pcm );
  }

  return 0;
}
//--------------------

This program causes error:
ALSA lib pcm_mmap.c:362:(snd_pcm_mmap) shmget failed: No space left on device
No space left on device

alsa-lib and drivers from cvs.

Konstantin Stepaniuk



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
