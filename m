From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Repost about fm801 tea575x_tuner in 2.6 kernels
Date: Tue, 15 Feb 2005 11:16:39 +0100 (CET)
Message-ID: <Pine.LNX.4.58.0502151115120.1756@pnote.perex-int.cz>
References: <4211C5E9.5010708@list.ru>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
In-Reply-To: <4211C5E9.5010708@list.ru>
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

> Hello all!
> 
> When I trying to do
> 
> #modprobe snd_fm801 tea575x_tuner=1
> 
> I see this thing in my syslog:
> 
> kernel: videodev: "TEA5757 radio" has no release callback. Please fix 
> your driver for proper sysfs
> support, see http://lwn.net/Articles/36850/
> 
> As far as I understand, this module is not compatible with linux-2.6 
> kernels, so, how to fix this problem?

Nope. This message is only warning and completely harmless. The driver
should work. This patch will remove the warning:

Index: tea575x-tuner.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/i2c/other/tea575x-tuner.c,v
retrieving revision 1.3
diff -u -r1.3 tea575x-tuner.c
--- tea575x-tuner.c	3 Aug 2004 19:03:02 -0000	1.3
+++ tea575x-tuner.c	15 Feb 2005 10:20:58 -0000
@@ -168,6 +168,10 @@
 	}
 }
 
+static void snd_tea575x_release(struct video_device *vfd)
+{
+}
+
 /*
  * initialize all the tea575x chips
  */
@@ -186,6 +190,7 @@
 	strcpy(tea->vd.name, tea->tea5759 ? "TEA5759 radio" : "TEA5757 radio");
 	tea->vd.type = VID_TYPE_TUNER;
 	tea->vd.hardware = VID_HARDWARE_RTRACK;	/* FIXME: assign new number */
+	tea->vd.release = snd_tea575x_release;
 	video_set_drvdata(&tea->vd, tea);
 	tea->vd.fops = &tea->fops;
 	tea->fops.owner = tea->card->module;

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
