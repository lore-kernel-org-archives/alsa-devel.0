From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Query devices in a non-blocking fashion
Date: Sun, 7 Dec 2003 19:40:23 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0312071936320.20863@pnote.perex-int.cz>
References: <oprztlvdeyq1sf88@mail.broadpark.no>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <oprztlvdeyq1sf88@mail.broadpark.no>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Arve Knudsen <aknuds-1@broadpark.no>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Sun, 7 Dec 2003, Arve Knudsen wrote:

> I'd like to be able to query the capabilities (number of channels, buffer 
> size etc.) of ALSA devices in the system, even if they should be in use by 
> some other process. The only current way to probe device capabilities is 
> to open a pcm, and use snd_pcm_hw_params, correct? At least this is my 
> current approach, but I'd like to query the devices without first 
> acquiring exclusive access. If there is currently no way around acquiring 
> a device for querying, maybe this requirement could be loosened in a 
> future version of ALSA?

Nope. You ask for runtime information. This information can change due 
various hardware contraints so we cannot give you an useful information 
without blocking the device.

Anyway, auto-probing for devices is a bad idea. Let user to choose the
device (hw:X,Y or plughw:X,Y or some "abstract" name in a dialog box)
yourself. The hw:X,Y numbers can be determined using the control API in a
non-blocking way.

I think that we should provide the list of devices with a description via 
some interface in alsa-lib.

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
