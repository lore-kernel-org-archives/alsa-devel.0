From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: Re: SPDIF and alsa, does it works for all cards/receivers?
Date: Mon, 28 Jul 2003 13:33:43 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3F251827.2030604@superbug.demon.co.uk>
References: <20030728115725.GB21471@magma.unil.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20030728115725.GB21471@magma.unil.ch>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Gregoire Favre <greg@magma.unil.ch>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Gregoire Favre wrote:
> Hello list ;-)
> 
> I have a "stupid" 5.1 system from Hercules which don't work perfectly in
> the sense, that when I connect it to a SBlive with a coaxial connexion
> it works (I can hear lots of noise, but my cable is very bad), my
> receiver goes in Dolby Digital mode with Dolby Digital signal and go
> back to Stereo mode without Dolby Digital signal: fine with SBlive.
> 
> Unfortunately, my motherboard has an integrated intel8x0 with optical
> SPDIF, and I can't by any way play any Dolby Digital signal with it, I
> can only hardly plays with the http://bitstreamout.sourceforge.net/
> which forward the signal from DVB and sent it to the soundcard SPDIF,
> then my receiver turns in Dolby Digital on Dolby Digital signal, and
> stay in this mode even after the end of the Dolby Digital signal... and
> then refuse to play anything at all???
> 
> And even worse: I have a Digital 7.1 card, with it I cannot put my
> receiver in 5.1 at all???
> 
> I just copy an expert, Dr. Werner Fink, as he spoke in the
> vdr@linuxtv.org mailing list about a problem with AC3overDVB:
> 
> "As long as the hardware on the DVB cards are not able to put
> the 16bit none audio PCM data stream into a 32bit none audio
> S/P-DIF transport stream all receivers which uses the bit flags
> of the S/P-DIF transport stream for identifying none audio
> loose.  All S/P-DIF data get from the DVB card to not have the
> none audio bit set.  AFAIK this is a hardware bug (or better
> this is the information I've got from TT) ..."
> 
> Is there such "limitation" with either my integrated intel8x0 or with
> the cs46xx card or???
> 
> Or is it only ALSA limitation (for example, with the Digifire 7.1 it
> works under windows...)?
> 
> 	Grégoire
> __________________________________________________________________
> http://www-ima.unil.ch/greg ICQ:16624071 mailto:greg@magma.unil.ch
> 
> 

You are correct, SPDIF and alsa does NOT work with all cards and all 
receivers.
Points to note: -
1) Does the receiver require "non-audio" bit to be set? Some do, some 
don't. My receiver does need it.
2) Does the sound card set the "non-audio" bit correctly when outputting 
AC3 data. The SB Live does this correctly.
3) Does the sound card output data un-modified from the PC to the SPDIF 
socket. The SB Live does interpolation on the PCM samples from the PC, 
so that the samples comming out of the SPDIF are different from the PCM 
samples from the PC. This therefore corrupts the AC3 frame (crc checks 
are done on it by the receiver) and no sound is output. (Normal stereo 
sound works because the ear cannot tell the difference between 
interpolated samples and the original samples). The alsa programmers 
have done a special work around for the SB Live problem, using something 
called the TRAM, in order to bypass the interpolators and get perfect 
AC3 output.
4) Sample rates. Some audio cards can only work at 48Khz, or only at 
44.1Khz, so outputting an AC3 signal from a DVD requires 48Khz, but 
outputting a AC3 signal from a CD requires 44.1khz. So, depending on 
where the media file with AC3 in it came from, it may or may not play.

It seems that SPDIF AC3 output is about the last feature that the alsa 
developers add when a new card is supported with alsa.
As intel8x0 is used on so many different motherboards, alsa cannot hope 
to support them all. The important issue with intel8x0 is the type of 
ac97 chip used. If you run alsamixer, in the top left corner, it will 
have "Chip: ....". Which chip does you motherboard have.
All motherboards use different chips, and it is the programming of that 
chip that is required in order to set the "non-audio" bits.
Summary: -
Your problems are most likely to be (2) and (4).

Cheers
James



-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
