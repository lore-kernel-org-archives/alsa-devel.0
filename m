From: "Ronny V. Vindenes" <s864@lstud.ii.uib.no>
Subject: Re: SPDIF and cs46xx ?
Date: Wed, 12 Mar 2003 12:08:45 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0303121151420.1592-100000@snylter.ii.uib.no>
References: <20030311233503.GF10785@ulima.unil.ch>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20030311233503.GF10785@ulima.unil.ch>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Gregoire Favre <greg@ulima.unil.ch>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Wed, 12 Mar 2003, Gregoire Favre wrote:

> On Tue, Mar 11, 2003 at 05:54:59PM +0100, Takashi Iwai wrote:
> 
> > 44.1kHz ac3 ?  then it likely doesn't work because ac3dec assumes
> > 48k only.
> 
> OK :-(
> So I made another ac3 files recording Pro-7 and using ds.jar:
> ./ac3dec -6 -R /video2/esa1.ac3
> 2.0 Mode 48.0 KHz 448 kbps Complete Main Audio Service
> Using PCM device 'iec958:AES0=0x0,AES1=0x82,AES2=0x0,AES3=0x2'
> 
> And I can hear in only in stereo... maybe the -6 option is not the right
> one?
> 
> So I take a DVD with which I am really sure have 5.1, with ds.jar I
> demux it and with -R I can hear, but only stereo and with the other
> option I can't???

The -R option tells ac3dec to decode the stream to a stereo pcm stream, 
you want to use -C or -P and not include -4/-6

> 
> > the spdif device is hw:0,2.
> > i guess ther is an option in mplayer to specify the pcm name for
> > ALSA.  use "spdif" there instead of "hw:0,2".
> 
> Well:
> 
> mplayer -vo null -ao alsa9:spdif -abs 1 -channels 2 gives me:
> 
> Cache fill:  0.00% (0 bytes)    MPEG-PS file format detected.
> VIDEO:  MPEG2  720x576  (aspect 3)  25.00 fps  8750.0 kbps (1093.8
> kbyte/s)
> ==========================================================================
> Opening audio decoder: [liba52] AC3 decoding with liba52
                         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

I think you need to pass -ac hwac3 to mplayer to enable ac3 pass-thru

> Using SSE optimized IMDCT transform
> AC3: 5.1 (3f+2r+lfe)  48000 Hz  448.0 kbit/s
> Using MMX optimized resampler
> AUDIO: 48000 Hz, 2 ch, 16 bit (0x10), ratio: 56000->192000 (448.0 kbit)
> Selected audio codec: [a52] afm:liba52 (AC3-liba52)
> ==========================================================================
> ==========================================================================
> Opening video decoder: [mpegpes] MPEG 1/2 Video passthrough
> VDec: vo config request - 720 x 576 (preferred csp: Mpeg PES)
> VDec: using Mpeg PES as output csp (no 0)
> Movie-Aspect is 1.78:1 - prescaling to correct movie aspect.
> VO: [null] 720x576 => 1024x576 Mpeg PES  [fs]
> Selected video codec: [mpegpes] vfm:mpegpes (Mpeg PES output (.mpg or
> Dxr3/DVB card))
> ==========================================================================
> Checking audio filter chain for 48000Hz/2ch/16bit ->
> 48000Hz/2ch/16bit...
> AF_pre: af format: 2 bps, 2 ch, 48000 hz, little endian signed int 
> AF_pre: 48000Hz 2ch Signed 16-bit (Little-Endian)
> alsa-init: testing and bugreports are welcome.
> alsa-init: requested format: 48000 Hz, 2 channels, Signed 16-bit
> (Little-Endian)
> alsa-init: soundcard set to spdif
> alsa9: 48000 Hz/2 channels/4 bpf/32768 bytes buffer/Signed 16 bit Little
> Endian
> AO: [alsa9] 48000Hz 2ch Signed 16-bit (Little-Endian) (2 bps)
> Building audio filter chain for 48000Hz/2ch/16bit ->
> 48000Hz/2ch/16bit...
> 
> And I could hear great stereo sound just before, but
> mplayer -vo null -ao alsa9:spdif -abs 1 -channels 6 gives me:
> 

I haven't tested the latest cs46xx driver but in rc7 something was wrong 
with the way it initalized spdif, that prevented my amplififer (denon 
avr1802) from recognising ac3 streams if input was set to spdif before 
playing a file. Starting a dvd in xine and after a couple of seconds 
turning the amplifier input to spdif would usually work fine.

-- 
Ronny V. Vindenes <sublett@dc-s.com>



-------------------------------------------------------
This SF.net email is sponsored by:Crypto Challenge is now open! 
Get cracking and register here for some mind boggling fun and 
the chance of winning an Apple iPod:
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0031en
