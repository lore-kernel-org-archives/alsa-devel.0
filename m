From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Bug in ALSA OSS mixer emulation. Volume++ does not
 work.
Date: Wed, 3 Dec 2003 09:27:14 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0312030924420.12963@pnote.perex-int.cz>
References: <3FCD5830.2000702@superbug.demon.co.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <3FCD5830.2000702@superbug.demon.co.uk>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: James Courtier-Dutton <James@superbug.demon.co.uk>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Wed, 3 Dec 2003, James Courtier-Dutton wrote:

> Hi,
> 
>   The alsa keeps state of all mixer levels in alsa's internal format 
> which has min,max info. So, for example if alsa has 0-31 levels, 
> converting that to the OSS 0-100 range is easy with a simple 
> calculation, but if an OSS app just does Volume++, the change will be 
> lost in the conversion from OSS to ALSA to actually set the state. So, 
> to work the way it should, OSS will have to cache all mixer state in OSS 
> format, thus requiring 2 state tables.
> 
> E.g.
> OSS Volume(0-100)   ALSA Volume(0-31)
> OSS = ALSA * 100/31;
> 
> 0		    0
> 1                   0
> 2                   0
> 3                   1
> 4                   1
> etc.
> 
> So, if OSS Volume is 2, and the OSS application does Volume++, the OSS 
> volume will be set to 3. but if OSS Volume is 3, and the OSS application 
> does Volume++, the OSS volume will stay at 3!

I don't undestand. Actually we have volumes in OSS format (in the kernel's 
mixer emulation), because some applications simply does not work for 
reason as you described (++ or -- applied). Note that these values are 
valid per application (so the resolution is reverted to ALSA's when 
another application changes volume too much). I don't see any other way to 
do it.

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
