From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: ALSA vs OSS: Some questions
Date: Mon, 7 Apr 2003 17:23:43 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0304071710240.32290-100000@pnote.perex-int.cz>
References: <20030407145029.GA19610@fliwatut.scifi>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20030407145029.GA19610@fliwatut.scifi>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Frank Barknecht <fbar@footils.org>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Mon, 7 Apr 2003, Frank Barknecht wrote:

> Hallo,
> 
> I'm working on a Linux Audio article, where I also do provide a short
> comparison of ALSA vs. OSS. For this, because I'm in no way a hardware
> developer, I have some questions to make sure, I understand things
> correctly. Would someone with deeper insight in the OSS/ALSA internals
> help me and tell me, if the following assumptions are correct?
> 
> I read, that OSS was hard to extent, for example to write drivers for
> modern hardware. Why is this so? 
> 
> Is it, because OSS ties its model of programming too close to the
> hardware?

The OSS's API was designed to support mainly cards which were available
mainly in middle of 90'. They supported mono and stereo interleaved data
in rates up to 48kHz with maximum sample width 16-bit.

> Paul Davis said in its LAD keynot, that in the past we only had OSS
> and only had 16-bit interleaved stereo. From reading the OSS-developer
> docs, it seemed to me, that OSS does support more formats than 16-bit
> interl. stereo. So what can ALSA do in the format department, that OSS
> couldn't do?

OSS can handle more formats, of course. But, the main difference between
ALSA and OSS is that OSS doesn't handle non-interleaved sample buffers at
all in the mmap mode. We can even handle some "complex" mmap modes like 4
stereo streams running together etc...

Interleaved buffers:

<offset0>ABABABAB

Non-interleaved buffers:

<offset0>AAAAA
<offset1>BBBBB

Complex (4 stereo streams etc.):

<offset0>ABABABAB
<offset1>CDCDCDCD
<offset2>EFEFEFEF
<offset3>GHGHGHGH

> Can the ICE1712 chip server as an example for these difficulties? The
> ICE chip doesn't support CD-quality music (44.1 samplerate, 16-bit,
> stereo) in hardware, if I'm right? What format does it support?

No, the ICE1712 chip supports rates from 32kHz to 96kHz including 44.1kHz.
The difference is that this chip (pro-part) supports only 32-bit little 
endian signed samples (in 24-bit resolution). So we need to convert 8-bit 
and 16-bit samples to this resolution (or from this resolution).

The better example is the RME9652 or HDSP drivers: They supports up to 26 
channels but only in the non-interleaved mode and 32-bit samples (same 
as ICE1712 - 24-bit resolution).

> And how does ALSA help in getting this supported compared to OSS (which
> hasn't support for the ICE-cards)

OSS does all conversions inside the kernel code. It's not much flexible
and also it's more sensitive for code errors.

We handle everything in the user space (alsa-lib). Our library does all 
necessary conversions and sample copying. Users can describe which 
conversions are wanted in the configuration files for this library. OSS 
does everything automatically.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs



-------------------------------------------------------
This SF.net email is sponsored by: ValueWeb: 
Dedicated Hosting for just $79/mo with 500 GB of bandwidth! 
No other company gives more support or power for your dedicated server
http://click.atdmt.com/AFF/go/sdnxxaff00300020aff/direct/01/
