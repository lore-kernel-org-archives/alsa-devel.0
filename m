From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Way to save DSP resources on the emu10k1
Date: Thu, 9 Oct 2003 17:26:00 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.53.0310091722070.1357@pnote.perex-int.cz>
References: <3F857BF2.40106@superbug.demon.co.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <3F857BF2.40106@superbug.demon.co.uk>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: James Courtier-Dutton <James@superbug.demon.co.uk>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Thu, 9 Oct 2003, James Courtier-Dutton wrote:

> Hi,
>
> I have thought of a possible way to save DSP resources on the SB
> Live/Audigy etc.
>
> Instead of having DSP code actually in the emu10k1 source code, have it
> in small user land files on disk.
> When the snd-emu10k1 modules is first loaded, it will contain no DSP
> code. When alsa-lib detects an emu10k1 DSP, it would scan the user land
> files, and then present the mixer api/user with a list of switches, to
> enable or disable a feature, then, only the features the user actually
> wants and needs would be loaded into the DSP, and thus save on DSP
> resources.
>
> This would also allow for special extra user designed modules, in much
> the same way that emu-dspmgr works on the oss driver.
>
> Then the user could have an almost unlimited amount of DSP modules to
> choose from, and only be limited by how many modules can be loaded at
> the same time.
>
> I am sure thise sort of feature would also me useful on other sound
> cards that have DSPs on them.

You have a chance. The build-in default DSP code uses standard routines
available also over ioctls so it not a problem to remove old DSP code and
replace it with something more useful. And yes, we can easy move the
default DSP code from the kernel space to the user space.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
SourceForge.net hosts over 70,000 Open Source Projects.
See the people who have HELPED US provide better services:
Click here: http://sourceforge.net/supporters.php
