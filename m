From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: hw_params and approximate values
Date: Fri, 22 Aug 2003 15:11:08 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0308221506090.26512-100000@pnote.perex-int.cz>
References: <oprt9l1hv6q1sf88@mail.broadpark.no>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <oprt9l1hv6q1sf88@mail.broadpark.no>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Arve Knudsen <aknuds-1@broadpark.no>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Thu, 21 Aug 2003, Arve Knudsen wrote:

> Hi
> 
> I'm not sure if I quite understand the alsa-lib docs regarding the 
> snd_pcm_hw_params API; in addition to an approximate integer value, one 
> might specify a direction. Is the direction parameter a way to instruct 
> ALSA to look for a floating point value in either direction? If that's the 
> case, couldn't this be handled with floats directly?

The direction means:

0 = use exactly equal number
-1 = use the most close previous number
1 = use the most close next number

You may also get most close value using the *_near() function. In this 
case, the direction selection is left on the library or driver code.

Regarding floats, we cannot use floats in a simple way in kernel so it's 
better to avoid this requirement.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs



-------------------------------------------------------
This SF.net email is sponsored by: VM Ware
With VMware you can run multiple operating systems on a single machine.
WITHOUT REBOOTING! Mix Linux / Windows / Novell virtual machines
at the same time. Free trial click here:http://www.vmware.com/wl/offer/358/0
