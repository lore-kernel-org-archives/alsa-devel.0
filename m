From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Bug in ALSA Yamaha YMF-754 SPDIF support
Date: Wed, 11 Jun 2003 11:34:29 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0306111125050.8723-100000@pnote.perex-int.cz>
References: <1055292332.28246.282.camel@maze.mythral.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1055292332.28246.282.camel@maze.mythral.org>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Ray Heasman <nurf@spamcop.net>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On 10 Jun 2003, Ray Heasman wrote:

> Hi,
> 
> The ALSA YMF-754 SPDIF support is incomplete in a way that ensures that
> AC-3 streams can not be decoded by standards compliant receivers. Very
> forgiving receivers will render the AC-3, but they are being kind.
> According to the standard, they should mute.
> 
> FYI, I am using 0.9.4 versions of everything.
> 
> Here is the problem:
> 
> Broadly speaking, a SPDIF stream has two places to carry control
> information: in the Channel Status Block, and within each sample word (a
> 32-bit word).
> 
> For our purposes, we only care about the "Valid" bit in each sample
> word, and the "Valid/Non-Audio" bit in the Channel Status Block.
> 
> For ordinary PCM data, each block must be marked as valid audio data, as
> must each sample.
> 
> For IEC61937 data (such as AC-3 or DTS), each block must be marked as
> "Invalid" (ie. Non-Audio) data, AND each and every single sample word
> must be marked as "Invalid" data too.
> 
> The problem is that ALSA allows you to override the Channel Status Block
> "Invalid" bit, but then marks each sample word as being valid. Compliant
> receivers ignore all "Valid"-marked samples in a IEC61937 stream.
> Similarly, they ignore all "Invalid"-marked samples in a PCM stream.
> 
> Here are the tests I ran to prove this.
> 
> First I ripped a few minutes of AC-3 data off a DVD, and put it in
> gits.ac3.
> 
> 1) First, check the ripped stream:
> 
> Expect: Expect to hear 2 channel mixed down audio.
> 
> maze foo # ac3dec gits.ac3
> 5.1 Mode 48.0 KHz 384 kbps Complete Main Audio Service
> Using PCM device 'default'
> 
> Result:
> 
> Normal (mixed down 2-channel) audio is heard. The stream is proven good.
> The stream is playing through a Sony AVR, using the SPDIF port, so we
> know the SPDIF port is working too, at least in 48KHz PCM mode.
> 
> 2) Next, attempt to play the ripped stream as a raw SPDIF stream.
> 
> Expect: Expect to hear 5.1 sound in all its glory.
> 
> maze foo # ac3dec -C gits.ac3
> Using PCM device 'plug:iec958:{AES0 0x2 AES1 0x82 AES2 0x0 AES3 0x2}'
> AC3 Stream 48.0 KHz 384 kbps
> 
> Result: <deathly hush>
> 
> Ok. The AVR is not happy. It indicates the presence of a stream, but
> refuses to recognise it. The stream is neither PCM nor anything else,
> according to the AVR.
> 
> 3) Play the stream again, but override the Channel Status Valid bit,
> telling the receiver that it is being sent PCM data.
> 
> Expect: Expect to hear nothing, as each sample should be marked
> "Invalid". Output should mute.
> 
> maze foo # ac3dec -C gits.ac3 -D'plug:iec958:{AES0 0x00 AES1 0x82 AES2
> 0x0 AES3 0x2}'Using PCM device 'plug:iec958:{AES0 0x00 AES1 0x82 AES2
> 0x0 AES3 0x2}'
> AC3 Stream 48.0 KHz 384 kbps
> 
> Result: <A loud continuous clicking is heard - I am hearing the
> compressed data rendered as if it were PCM. The receiver reports a 48kHz
> PCM signal>
> 
> This shows the problem: If I tell the AVR the Channel is valid, but each
> sample is set to "Invalid", it will ignore the invalid samples. It plays
> the samples, thus the samples are being marked as valid.
> 
> CONCLUSION:
> 
> Sample words in IEC61937 streams are being marked "Valid". This is
> wrong.
> 
> --
> 
> I started looking through the code for the YMF drivers, but I am
> horribly lost. Is this easy to fix?

No. The YMF754 datasheet does not contain information how to handle the 
validity bit in subframes. Also, the a_52.pdf (AC3 standard description - 
can be downloaded from www.dolby.com or at ALSA FTP site) says that the 
interpretation of this bit is optional:

=============
4.3 Validity flag

The validity flag in time slot 28 may be used to indicate individual
16-bit words of data which are thought to be in error.  If the data source
believes a particular 16-bit word contained in a sub-frame contains an
error, the validity bit may be set to 1 . Otherwise this bit shall be set
to a 0 which indicates valid data. The use of this bit by receivers is
optional.
==============

I am not sure if ymfpci driver is not broken for raw S/PDIF now, but last 
time I tried the code, it worked well with Sony receiver.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs




-------------------------------------------------------
This SF.net email is sponsored by:  Etnus, makers of TotalView, The best
thread debugger on the planet. Designed with thread debugging features
you've never dreamed of, try TotalView 6 free at www.etnus.com.
