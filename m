From: Andy Wingo <wingo@pobox.com>
Subject: bug in snd_pcm_hw_params_test_*() functions?
Date: Mon, 8 Jul 2002 10:14:10 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020708101410.E554@cebreiro.nc.rr.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=_cebreiro-3097-1026137650-0001-2"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_cebreiro-3097-1026137650-0001-2
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Forwarded from Joshua Haberman.
--=_cebreiro-3097-1026137650-0001-2
Content-Type: message/rfc822
Content-Disposition: inline

Delivered-To: wingo@ambient.2y.net
Return-Path: <joshua@haberman.com>
Received: from cali-3.pobox.com (cali-3.pobox.com [::ffff:64.71.166.116])
  by jesus with esmtp; Mon, 08 Jul 2002 01:10:17 -0400
Received: from barney.reverberate.org (barney.reverberate.org [207.207.127.56])
	by cali-3.pobox.com (Postfix) with ESMTP id E05C03E634
	for <wingo@pobox.com>; Mon,  8 Jul 2002 01:10:53 -0400 (EDT)
Received: from joshua by barney.reverberate.org with local (Exim 3.33 #1 (Debian))
	id 17RQuS-0000Ue-00
	for <wingo@pobox.com>; Sun, 07 Jul 2002 22:18:04 -0700
Date: Sun, 7 Jul 2002 22:18:04 -0700
From: Joshua Haberman <joshua@haberman.com>
To: wingo@pobox.com
Subject: bug in snd_pcm_hw_params_test_*() functions?
Message-ID: <20020708051804.GA1529@reverberate.org>
References: <E17Ql0d-0003FX-00@barney.reverberate.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
In-Reply-To: <E17Ql0d-0003FX-00@barney.reverberate.org>
User-Agent: Mutt/1.3.28i

Andy,

Let me know if you see anything I've missed that invalidates what I
wrote...

--------------------------------------------

I believe I have discovered a bug in either the behavior or the
documentation of the snd_pcm_hw_params_test_format() function.  It is
documented to return 1 if the format is available, 0 otherwise.  However,
I have discovered that it actually returns 0 if the format is available,
< 0 otherwise (ie. identical to snd_pcm_hw_params_set_format).

This test program seems to confirm my hypothesis.

---

#include <alsa/asoundlib.h>

#define NOFAIL == 0 || (assert(0), 1)

int main(int argc, char *argv[])
{
    snd_pcm_t *pcm;
    snd_pcm_hw_params_t *hw_params;
    snd_output_t *debug;

    snd_output_stdio_attach( &debug, stdout, 0 ) NOFAIL;
    snd_pcm_hw_params_malloc( &hw_params ) NOFAIL;

    snd_pcm_open( &pcm, argv[1], SND_PCM_STREAM_PLAYBACK, 0 ) NOFAIL;

    snd_pcm_hw_params_any( pcm, hw_params ) NOFAIL;
    snd_pcm_hw_params_dump( hw_params, debug );

    /* according to the documentation, this function returns 1 if the
     * format is available, 0 otherwise.  However, the function
     * seems to return 0 if the format is available, < 0 otherwise. */
#define TEST_FORMAT(format) \
    if( snd_pcm_hw_params_test_format( pcm, hw_params, format ) < 0 ) \
        printf( "- " #format "\n" ); \
    else \
        printf( "+ " #format "\n" );

    /* test several formats against the output of the previous dump */
    TEST_FORMAT(SND_PCM_FORMAT_FLOAT)
    TEST_FORMAT(SND_PCM_FORMAT_S16)
    TEST_FORMAT(SND_PCM_FORMAT_S24)
    TEST_FORMAT(SND_PCM_FORMAT_S32)
    TEST_FORMAT(SND_PCM_FORMAT_S8)
    TEST_FORMAT(SND_PCM_FORMAT_U8)

    return 0;
}

$  ./test_format hw:0
ACCESS:  MMAP_INTERLEAVED RW_INTERLEAVED
FORMAT:  U8 S16_LE
[...]
- SND_PCM_FORMAT_FLOAT
+ SND_PCM_FORMAT_S16
- SND_PCM_FORMAT_S24
- SND_PCM_FORMAT_S32
- SND_PCM_FORMAT_S8
+ SND_PCM_FORMAT_U8

$  ./test_format plughw:0
ACCESS:  MMAP_INTERLEAVED MMAP_NONINTERLEAVED MMAP_COMPLEX RW_INTERLEAVED RW_NONINTERLEAVED
FORMAT:  S8 U8 S16_LE S16_BE U16_LE U16_BE S24_LE S24_BE U24_LE U24_BE S32_LE S32_BE U32_LE U32_BE FLOAT_LE FLOAT_BE FLOAT64_LE FLOAT64_BE MU_LAW A_LAW IMA_ADPCM
[...]
+ SND_PCM_FORMAT_FLOAT
+ SND_PCM_FORMAT_S16
+ SND_PCM_FORMAT_S24
+ SND_PCM_FORMAT_S32
+ SND_PCM_FORMAT_S8

I believe this could affect all the snd_pcm_hw_params_test_*() functions,
since they seem to all use the same internal interface.

Josh

-- 
Joshua Haberman  <joshua@haberman.com>


--=_cebreiro-3097-1026137650-0001-2--


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Oh, it's good to be a geek.
http://thinkgeek.com/sf
