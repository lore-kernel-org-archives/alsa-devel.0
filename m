From: "thewade" <pdman@aproximation.org>
Subject: Re: hdsploader causes Ooops in kernel 2.6.8.1 and AMD64
Date: Mon, 13 Sep 2004 09:25:12 -0600
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200409131525.i8DFPCsY024093@sanctuary.aproximation.org>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

> On Fri, 2004-09-10 at 21:51, thewade wrote:
> > Hello,
> > 
> > Im trying to solve my own problem, which is getting the hammerfall to 
> > work on my AMD64 laptop running Fedora Core 3 test 1 and the standard 
> > kernel 2.6.8.1.
> > 
> > On boot I get Found hammerfall dsp: no multiface or digiface
> connected: 
> > waiting for firmware even when the multiface is connected.
> 
> Are you sure Linux sees the hammerfall (1394 support enabld, etc)?  What
> does dmesg say about it?
> 
> The Oops is certainly a bug and should be fixed.
> 
> Lee

So I was looking at the hdsploader.c code and I dont know enough about coding on linux to track down the error very far, but the error has to happen somewhere in the following three functions as the last bit of output I get is:
printf(\"Upload firmware for card %s\\n\", card_name);
Then I get killed on my xterm and Oops in my syslog.

So the error has to be in one of these:
-snd_hwdep_open(&hw, card_name, SND_HWDEP_OPEN_DUPLEX)
-snd_hwdep_ioctl(hw, SNDRV_HDSP_IOCTL_GET_VERSION, &version)
-read_bin_file(code, DATAPATH \"/multiface_firmware.bin\")

I bet its one of the first two. Is there any way that the hw variable is the problem? Is the error in the hw variable, or is it in one of the alsa headers?

Thanks for the help,
-thewade


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM. 
Deadline: Sept. 13. Go here: http://sf.net/ppc_contest.php
