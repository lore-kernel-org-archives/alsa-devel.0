From: andersvi@extern.uio.no
Subject: Re: vxpocket 440 with alsa, problems with vxloader
Date: Sat, 15 Jan 2005 00:36:03 +0100
Message-ID: <m3ekgn60t8.fsf@notam02.uio.no>
References: <copr7koutib.fsf@olivier.localdomain>
	<s5hu0pk6wlq.wl@alsa2.suse.de> <copllawumfe.fsf@olivier.localdomain>
	<s5hllaw6pc6.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hllaw6pc6.wl@alsa2.suse.de> (Takashi Iwai's message of "Fri,
 14 Jan 2005 15:46:17 +0100")
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-user@lists.sourceforge.net, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>>>>> "TI" == Takashi Iwai <tiwai@suse.de> writes:

    TI> Does your kernel support hotplug firmware loader (CONFIG_FW_LOADER)?
    TI> And is hotplug working?

    TI> Check whether /proc/asound/devices whether you have a "[1-0] hardware
    TI> dependent device".  If you have it, the hotplug firmware loader isn't
    TI> enabled.  Use vxloader, run "vxloader -c1".

Theres no such line there now.  It was earlier today though... Hmmm

Sticking in the card now leaves the following trail in
/var/log/messages:

Jan 15 00:25:34 localhost kernel: cs: memory probe 0xa0000000-0xa0ffffff: clean.
Jan 15 00:25:34 localhost cardmgr[2616]: socket 0: Digigram VX-POCKET440
Jan 15 00:25:35 localhost kernel: snd-vxp440: RequestIO: Resource in use
Jan 15 00:25:35 localhost cardmgr[2616]: get dev info on socket 0 failed: No such device

and "/sbin/lsmod | grep vx" shows a list of snd_vxp440 and
friends.

However, theres no trace inside /proc/asound/cards or any
/proc/asound/card1/ directory, and i cant find the card anywhere
else.

$ amixer -c 1
amixer: Mixer attach hw:1 error: No such device

    TI> With the attached patch, you can check whether the firmware is loaded
    TI> or not via the proc file.

Which proc file are you suggesting here?



-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
