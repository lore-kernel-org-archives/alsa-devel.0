From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: Re: module_init fails with OEM SoundBlaster Live!
Date: Mon, 03 Nov 2003 16:28:07 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3FA68217.7080407@superbug.demon.co.uk>
References: <20031102114634.GA13679@gondolin.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20031102114634.GA13679@gondolin.homeip.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Peter Chapman <x6pe9syq02@sneakemail.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Peter Chapman wrote:
> I have an SBLive! which came with a Dell Dimension PC. The snd-emu10k1
> 
> with lspci -n:
> 03:03.0 Class 0401: 1102:0002 (rev 07)
>         Subsystem: 1102:8022
> etc....
> 
> could a failure to add the spdif control be made non-fatal perhaps?
> 
> Thanks,
> Pete Chapman
> 
> 
The 0x1102:0x0002 is a standard emu10k1 chip, and not the cut down version.

If it was a 0x1102:0x0006, it would be the really strange dell one, so 
this one is just a bit strange!

We could use the emu->serial or Subsystem Vendor ID to use to identify 
this card, and create a special case for it.

Cheers
James






-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?   SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
