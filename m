From: Martin Langer <martin-langer@gmx.de>
Subject: Re: switch to new PCM API for 1.0 release
Date: Sat, 8 Nov 2003 21:43:31 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20031108204331.GB6864@tuba.home>
References: <Pine.LNX.4.53.0311051141250.1187@F137.suse.de> <20031108163922.GA6647@tuba.home> <Pine.LNX.4.53.0311081950460.3073@pnote.perex-int.cz> <20031108191436.GA6864@tuba.home> <Pine.LNX.4.53.0311082030280.3073@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.gmx.net (pop.gmx.de [213.165.64.20])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with SMTP id VAA04702
	for <alsa-devel@alsa-project.org>; Sat, 8 Nov 2003 21:42:56 +0100
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0311082030280.3073@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Sat, Nov 08, 2003 at 08:32:55PM +0100, Jaroslav Kysela wrote:
> On Sat, 8 Nov 2003, Martin Langer wrote:
> 
> > On Sat, Nov 08, 2003 at 08:04:43PM +0100, Jaroslav Kysela wrote:
> > > >
> > > > aplay/arecord doesn't work at the moment:
> > > >
> > > > Playing WAVE '/tmp/test.wav' : Signed 16 bit Little Endian, Rate 44100 Hz,
> > > > Stereo
> > > > aplay: set_params:874: Unable to install hw params:
> > > > ACCESS:  RW_INTERLEAVED
> > >
> > > Could you post details? Please, send me output from:
> >
> > sure.
> >
> > > nm /usr/bin/aplay | grep rate
> >
> > tuba:/usr/local/src/alsa-cvs/alsa-utils/aplay# nm /usr/bin/aplay | grep rate
> >          U snd_pcm_hw_params_set_rate_near@@ALSA_0.9
> >
> > > nm /usr/lib/libasound.so.2 | grep set_rate
> >
> > tuba:/usr/local/src/alsa-cvs/alsa-utils/aplay# nm
> > /usr/lib/libasound.so.2 | grep set_rate
> > 0003c980 t __old_snd_pcm_hw_params_set_rate_first
> > 0003cbe8 t __old_snd_pcm_hw_params_set_rate_last
> > 0003c718 t __old_snd_pcm_hw_params_set_rate_near
> > 00038dac T __snd_pcm_hw_params_set_rate_first
> > 00038ddc T __snd_pcm_hw_params_set_rate_last
> > 00038d7c T __snd_pcm_hw_params_set_rate_near
> > 00038cb8 T snd_pcm_hw_params_set_rate
> > 0003c980 T snd_pcm_hw_params_set_rate_first@@ALSA_0.9
> > 00038dac T snd_pcm_hw_params_set_rate_first@ALSA_0.9.0rc4
> > 0003cbe8 T snd_pcm_hw_params_set_rate_last@@ALSA_0.9
> > 00038ddc T snd_pcm_hw_params_set_rate_last@ALSA_0.9.0rc4
> > 00038d18 T snd_pcm_hw_params_set_rate_max
> > 00038ce8 T snd_pcm_hw_params_set_rate_min
> > 00038d48 T snd_pcm_hw_params_set_rate_minmax
> > 0003c718 T snd_pcm_hw_params_set_rate_near@@ALSA_0.9
> > 00038d7c T snd_pcm_hw_params_set_rate_near@ALSA_0.9.0rc4
> 
> I'm a bit confused now. It appears that you have old libraries and aplay
> (this combination should work, of course). New code should type:
> 
> perex@pnote:~/alsa/alsa-lib> nm /usr/bin/aplay | grep rate
>          U snd_pcm_hw_params_set_rate_near@@ALSA_0.9.0rc4
> 
> perex@pnote:~/alsa/alsa-lib> nm /usr/lib/libasound.so.2 | grep set_rate_near
> 0003f590 t __old_snd_pcm_hw_params_set_rate_near
> 0003b680 T __snd_pcm_hw_params_set_rate_near
> 0003b680 T snd_pcm_hw_params_set_rate_near@@ALSA_0.9.0rc4
> 0003f590 T snd_pcm_hw_params_set_rate_near@ALSA_0.9
> 

I was using latest CVS. But building alsa-lib failed in the last time, but
I've ignored it the whole time. All other alsa-* (including utils) were built
successfully. That's the situation of: new aplay and old lib.


This is the bug in "alsa-lib/src/conf/cards/Makefile.am":
Make uses the directory name "SI7018" two times which fails.

/bin/sh ../../../mkinstalldirs /usr/share/alsa/cards/SI7018
 /usr/bin/install -c -m 644 ./SI7018/sndoc-mixer.alisp
/usr/share/alsa/cards/SI7018/SI7018/sndoc-mixer.alisp
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
/usr/bin/install: cannot create regular file
/usr/share/alsa/cards/SI7018/SI7018/sndoc-mixer.alisp': No such file or
directory
 /usr/bin/install -c -m 644 ./SI7018/sndop-mixer.alisp
/usr/share/alsa/cards/SI7018/SI7018/sndop-mixer.alisp
/usr/bin/install: cannot create regular file
/usr/share/alsa/cards/SI7018/SI7018/sndop-mixer.alisp': No such file or
directory
make[5]: *** [install-SI7018DATA] Error 1


After fixing that bug, alsa-lib was installed with success and aplay runs
fine now! And it was a new aplay binary all the time! Sorry.

Thanks.
martin


-------------------------------------------------------
This SF.Net email sponsored by: ApacheCon 2003,
16-19 November in Las Vegas. Learn firsthand the latest
developments in Apache, PHP, Perl, XML, Java, MySQL,
WebDAV, and more! http://www.apachecon.com/
