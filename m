From: Mikael Magnusson <mikaelmagnusson@glocalnet.net>
Subject: Re: lo10K1 not working on x86_64 ?
Date: Thu, 3 Nov 2005 13:01:17 +0100
Message-ID: <20051103120117.GA27985@skinner.hem.za.org>
References: <20051102212009.6121d6c3@VikingPC.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <20051102212009.6121d6c3@VikingPC.home>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Wed, Nov 02, 2005 at 09:20:09PM +0100, Corvus Corax wrote:
> 
> Hi
> 
> It seems like lo10k1 is not working correctly on x86_64
> 
> the emu10k1 driver itself works ok, but loading anything (for example
> with emu_init) results either in
> 
> - no change at all
> - sound in front left speaker distorted
> - no sound
> 
> just running emu_init results in distorted sound
> 
> i tried qlo10k1 and loaded several patches manually or unloaded them from the
> default provided emu_init. all that changes are different heavy distortions
> 
> (distortion = sounds like extreme clipping doe to over amilification)
> 
> is the 64bit address stuff causing this, or could as10k1 eventually produce
> incorrect DSP machine code? (compiled DSP assembler code on x86_64 seems
> to have differed from code previously assembled on x86, but Im not sure if the
> sources were 100% identical)

Which version of alsa-driver and alsa-tools are you trying. You will
need at least version 1.0.10rc1, since it contains bug fixes to ld10k1
that are related to 64bit systems.

/Mikael



-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
