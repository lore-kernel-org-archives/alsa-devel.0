From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: switch to new PCM API for 1.0 release
Date: Sat, 8 Nov 2003 20:32:55 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.53.0311082030280.3073@pnote.perex-int.cz>
References: <Pine.LNX.4.53.0311051141250.1187@F137.suse.de>
 <20031108163922.GA6647@tuba.home> <Pine.LNX.4.53.0311081950460.3073@pnote.perex-int.cz>
 <20031108191436.GA6864@tuba.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from gate2.perex.cz (UNKNOWN@194.149.109.108.adsl.nextra.cz [194.149.109.108])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id UAA03623
	for <alsa-devel@alsa-project.org>; Sat, 8 Nov 2003 20:33:00 +0100
In-Reply-To: <20031108191436.GA6864@tuba.home>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Martin Langer <martin-langer@gmx.de>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Sat, 8 Nov 2003, Martin Langer wrote:

> On Sat, Nov 08, 2003 at 08:04:43PM +0100, Jaroslav Kysela wrote:
> > >
> > > aplay/arecord doesn't work at the moment:
> > >
> > > Playing WAVE '/tmp/test.wav' : Signed 16 bit Little Endian, Rate 44100 Hz,
> > > Stereo
> > > aplay: set_params:874: Unable to install hw params:
> > > ACCESS:  RW_INTERLEAVED
> >
> > Could you post details? Please, send me output from:
>
> sure.
>
> > nm /usr/bin/aplay | grep rate
>
> tuba:/usr/local/src/alsa-cvs/alsa-utils/aplay# nm /usr/bin/aplay | grep rate
>          U snd_pcm_hw_params_set_rate_near@@ALSA_0.9
>
> > nm /usr/lib/libasound.so.2 | grep set_rate
>
> tuba:/usr/local/src/alsa-cvs/alsa-utils/aplay# nm
> /usr/lib/libasound.so.2 | grep set_rate
> 0003c980 t __old_snd_pcm_hw_params_set_rate_first
> 0003cbe8 t __old_snd_pcm_hw_params_set_rate_last
> 0003c718 t __old_snd_pcm_hw_params_set_rate_near
> 00038dac T __snd_pcm_hw_params_set_rate_first
> 00038ddc T __snd_pcm_hw_params_set_rate_last
> 00038d7c T __snd_pcm_hw_params_set_rate_near
> 00038cb8 T snd_pcm_hw_params_set_rate
> 0003c980 T snd_pcm_hw_params_set_rate_first@@ALSA_0.9
> 00038dac T snd_pcm_hw_params_set_rate_first@ALSA_0.9.0rc4
> 0003cbe8 T snd_pcm_hw_params_set_rate_last@@ALSA_0.9
> 00038ddc T snd_pcm_hw_params_set_rate_last@ALSA_0.9.0rc4
> 00038d18 T snd_pcm_hw_params_set_rate_max
> 00038ce8 T snd_pcm_hw_params_set_rate_min
> 00038d48 T snd_pcm_hw_params_set_rate_minmax
> 0003c718 T snd_pcm_hw_params_set_rate_near@@ALSA_0.9
> 00038d7c T snd_pcm_hw_params_set_rate_near@ALSA_0.9.0rc4

I'm a bit confused now. It appears that you have old libraries and aplay
(this combination should work, of course). New code should type:

perex@pnote:~/alsa/alsa-lib> nm /usr/bin/aplay | grep rate
         U snd_pcm_hw_params_set_rate_near@@ALSA_0.9.0rc4

perex@pnote:~/alsa/alsa-lib> nm /usr/lib/libasound.so.2 | grep set_rate_near
0003f590 t __old_snd_pcm_hw_params_set_rate_near
0003b680 T __snd_pcm_hw_params_set_rate_near
0003b680 T snd_pcm_hw_params_set_rate_near@@ALSA_0.9.0rc4
0003f590 T snd_pcm_hw_params_set_rate_near@ALSA_0.9


						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs


-------------------------------------------------------
This SF.Net email sponsored by: ApacheCon 2003,
16-19 November in Las Vegas. Learn firsthand the latest
developments in Apache, PHP, Perl, XML, Java, MySQL,
WebDAV, and more! http://www.apachecon.com/
