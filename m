From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: Re: Bug in ALSA Yamaha YMF-754 SPDIF support
Date: Thu, 03 Jul 2003 02:18:50 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3F03847A.4060809@superbug.demon.co.uk>
References: <1055292332.28246.282.camel@maze.mythral.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
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
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Ray Heasman wrote:
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
> 
> Hope someone finds this useful,
> Ray
> 
> 

Have you tried using xine? (xine.sf.net) to play a DVD?
It accesses the SPDIF slightly differently, and could make all the 
difference.

I don't think that any AC3 decoder cares about the "Valid" bit being set 
or not. What they DO care about is the CRC checks on the AC3 data.
Some sound cards use iterpolators on any PCM data, and any modification 
of the AC3 data will render the AC3 failing the CRC checks.
When playing PCM, one cannot tell if the sound is being interpolated or not.
If one plays PCM sound ok, but fails AC3, it normally points to one of 
two things: -
1) Non-audio bit not being set.
2) non perfect passing of data from cpu to spdif.
    a) Due to interpolators.
    b) Due to over/underruns.

Cheers
James



-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100006ave/direct;at.asp_061203_01/01
