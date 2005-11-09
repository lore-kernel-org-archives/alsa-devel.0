From: Corvus Corax <corvus-ml@cybertrench.com>
Subject: Re: lo10K1 not working on x86_64 ?
Date: Wed, 9 Nov 2005 02:04:51 +0100
Message-ID: <20051109020451.1cc1eb72@VikingPC.home>
References: <20051102212009.6121d6c3@VikingPC.home>
	<20051103120117.GA27985@skinner.hem.za.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20051103120117.GA27985@skinner.hem.za.org>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Mikael Magnusson <mikaelmagnusson@glocalnet.net>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Am Thu, 3 Nov 2005 13:01:17 +0100
schrieb Mikael Magnusson <mikaelmagnusson@glocalnet.net>:

> On Wed, Nov 02, 2005 at 09:20:09PM +0100, Corvus Corax wrote:
> > 
> > Hi
> > 
> > It seems like lo10k1 is not working correctly on x86_64
> > 
> > the emu10k1 driver itself works ok, but loading anything (for example
> > with emu_init) results either in
> > 
> > - no change at all
> > - sound in front left speaker distorted
> > - no sound
> > 
> > just running emu_init results in distorted sound
> > 
> > i tried qlo10k1 and loaded several patches manually or unloaded them from
the
> > default provided emu_init. all that changes are different heavy distortions
> > 
> > (distortion = sounds like extreme clipping doe to over amilification)
> > 
> > is the 64bit address stuff causing this, or could as10k1 eventually produce
> > incorrect DSP machine code? (compiled DSP assembler code on x86_64 seems
> > to have differed from code previously assembled on x86, but Im not sure if
the
> > sources were 100% identical)
> 
> Which version of alsa-driver and alsa-tools are you trying. You will
> need at least version 1.0.10rc1, since it contains bug fixes to ld10k1
> that are related to 64bit systems.
> 
> /Mikael
> 

I think I had it running with 1.0.10rc1 on both driver and tools, but Im not
completely sure about alsa-driver anymore.

I have now tested again with both at 1.0.10rc2, everything compiled 64bit.

init_live still creates a setup with heavily distorted output, but when cleaning
the DSP setup with qlo10k1 and setting up a single master volume control slider
and routing from PCM to different speakers, I have been able to change their
volume successfully afterwards - so most of the backend seems to be working.

Maybe specific patches have problems, or the init_live scrip doesnt fit my card,
I'll give it some further tests, trying to find a working routing with adequate
mixer controls. Thanks for answer :-)

regards

Corvus


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
