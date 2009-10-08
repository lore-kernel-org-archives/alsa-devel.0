From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [alsa-cvslog] alsa-kernel: Official ALSA project
 GIT repository for Linux 2.6 branch, master now at v2.6.31-rc8-407-gfc9e4a3
Date: Thu, 08 Oct 2009 13:19:07 +0200
Message-ID: <4ACDCAAB.2060609@ladisch.de>
References: <20091006063609.B06E110381F@alsa0.perex.cz>	<s5hab05role.wl%tiwai@suse.de>	<4ACAF4AC.3000608@ladisch.de>
	<s5h4oqdrlys.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 02A69103934
	for <alsa-devel@alsa-project.org>;
	Thu,  8 Oct 2009 13:19:11 +0200 (CEST)
In-Reply-To: <s5h4oqdrlys.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, Honza Maly <jmal8295@artax.karlin.mff.cuni.cz>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

jmal8295 wrote:
> And I _will_ be regarding it as regression if I lose possibility to
> change volume of the four streams independently.

Okay, as long as there is no application to handle PCM-interface
controls, the DXS controls should not be hidden this way.

Anyway, the volume level regression can be solved by any renaming, so
let's do just that.  Takashi, please pick the patch below instead.

==========

sound: via82xx: rename DXS volume controls

Only some insiders know what the "VIA DXS" controls actually control, so
change them to a more descriptive name.

Commit b452e08e73c0e3dbb0be82130217be4b7084299e in 2.6.30 broke the
restoring of these volumes by "alsactl restore" that most distributions
use; the renaming in this patch cures that regression by preventing
alsactl from applying the old, wrong volume levels to the new controls.
http://bugzilla.kernel.org/show_bug.cgi?id=14151
http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=532613

Signed-off-by: Clemens Ladisch <clemens@ladisch.de>
Cc: <stable@kernel.org>

--- a/sound/pci/via82xx.c
+++ b/sound/pci/via82xx.c
@@ -1705,7 +1705,7 @@
 };
 
 static struct snd_kcontrol_new snd_via8233_dxs_volume_control __devinitdata = {
-	.name = "VIA DXS Playback Volume",
+	.name = "PCM Stream Playback Volume",
 	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 	.access = (SNDRV_CTL_ELEM_ACCESS_READWRITE |
 		   SNDRV_CTL_ELEM_ACCESS_TLV_READ),
