From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: [Alsa-user] Changes on VXpocket drivers
Date: Tue, 18 Feb 2003 17:50:47 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0302181747530.1636-100000@pnote.perex-int.cz>
References: <s5hk7fxh7qc.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hk7fxh7qc.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Tue, 18 Feb 2003, Takashi Iwai wrote:

> Hi,
> 
> I've changed the boot-behavior of VX-pocket drivers on the CVS.
> In the new version, the firmwares are not in the driver source but in
> the external directory to be transferred by an external program.
> 
> If you update the cvs version, please do the following:
> 
> - build vxloader utility in alsa-tools cvs.
>   install it.  the firmwares will be installed in either
>   /usr/share/vxloader or /usr/local/share/vxloader
> 
> - rebuild the alsa-driver modules.  install them.
> 
> - add an entry to /etc/modules.conf
> 
> 	post-install snd-vxpocket vxloader
> 
> or
> 	post-install snd-vxp440 vxloader
> 
> 
> The new driver, snd-vx222, will need the similar configuration.
> 
> 
> If you encounter any problems after update, please let me know!

Nice, also it would be nice to create an universal firmware loader and 
extract the firmware from other drivers (cs46xx, HDSP etc...).

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
