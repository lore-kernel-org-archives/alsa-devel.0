From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Repost about fm801 tea575x_tuner in 2.6 kernels
Date: Tue, 15 Feb 2005 18:20:49 +0100 (CET)
Message-ID: <Pine.LNX.4.58.0502151819500.1756@pnote.perex-int.cz>
References: <4211C5E9.5010708@list.ru> <Pine.LNX.4.58.0502151115120.1756@pnote.perex-int.cz>
 <421209B6.3090103@list.ru>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
In-Reply-To: <421209B6.3090103@list.ru>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Kovalyev Sergey <randoman@list.ru>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Tue, 15 Feb 2005, Kovalyev Sergey wrote:

> >Nope. This message is only warning and completely harmless. The driver
> >should work. This patch will remove the warning:
> >
> >  
> >
> Hm...
> Under 2.4.x kernels I used this command:
> modprobe snd_fm801 tea575x_tuner=2
> Now, under 2.6, it says that "2" is invalid valut into syslog:
> kernel: snd_fm801: `2' invalid for parameter `tea575x_tuner'
> So, I trying to use
> modprobe snd_fm801 tea575x_tuner=1.
> Seems that all ok, even fm says that all ok,

The radio chip cannot be detected. Here is the patch which will fix
the module parameter (and use tea575x_tuner=2 as for 2.4):

Index: fm801.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/fm801.c,v
retrieving revision 1.55
diff -u -r1.55 fm801.c
--- fm801.c	27 Dec 2004 13:29:27 -0000	1.55
+++ fm801.c	15 Feb 2005 17:25:41 -0000
@@ -64,7 +64,7 @@
 MODULE_PARM_DESC(id, "ID string for the FM801 soundcard.");
 module_param_array(enable, bool, NULL, 0444);
 MODULE_PARM_DESC(enable, "Enable FM801 soundcard.");
-module_param_array(tea575x_tuner, bool, NULL, 0444);
+module_param_array(tea575x_tuner, int, NULL, 0444);
 MODULE_PARM_DESC(tea575x_tuner, "Enable TEA575x tuner.");
 
 /*

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
