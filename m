From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Pops at start of song
Date: Thu, 20 Nov 2003 12:30:13 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0311201227410.2668@pnote.perex-int.cz>
References: <NDBBLGIKBJENLAMOLFHGCEKEDNAB.mknecht@controlnet.com>
 <3FBC0855.5010406@pianodisc.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <3FBC0855.5010406@pianodisc.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Steve deRosier <derosier@pianodisc.com>
Cc: Mark Knecht <mknecht@controlnet.com>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Wed, 19 Nov 2003, Steve deRosier wrote:

> Mark,
> 
> I don't know if it's the same effect or not.  We're working on an 
> "embedded" Linux device.  It has a full Linux kernel and basically is a 
> hand-built distribution of stock Linux stuff, but is very stripped down 
> and some of our apps are custom.  As we're not using OSS in any way 
> (neither apps nor the Alsa OSS emulation layer) so I can't speak to that.
> 
> One of our engrs here seems to think it's a hardware issue also, and the 
> only way to get our apps to deal with it is to on the stop command push 
> values into the pcm buffer that ramp down to 0 and then fill a full 
> buffer-size number of samples of 0 into the buffer before closeing it. 

I think that you can attenuate the volumes in a few ms to reduce the big
speaker (volume) move, but yes, doing the slow attenuation is the right 
thing when hardware doesn't have the click compensation itself.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
