From: zhejiang <zhe.jiang@intel.com>
Subject: Re: patch for Dell 1210 which using stac9221 codec
Date: Thu, 01 Nov 2007 10:14:55 +0800
Message-ID: <1193883295.5345.11.camel@localhost.localdomain>
References: <1192675756.3701.30.camel@localhost.localdomain>
	<s5hve94zd3a.wl%tiwai@suse.de>
	<1192773763.4306.31.camel@localhost.localdomain>
	<s5hejfrekan.wl%tiwai@suse.de>
	<1192779729.4628.5.camel@localhost.localdomain>
	<s5hk5pjzefs.wl%tiwai@suse.de>
	<1193033299.26715.34.camel@localhost.localdomain>
	<s5hr6jmryaf.wl%tiwai@suse.de>
	<1193298282.3459.18.camel@localhost.localdomain>
	<s5hmyu7blzv.wl%tiwai@suse.de>
	<1193735155.4414.7.camel@localhost.localdomain>
	<s5hir4opv2p.wl%tiwai@suse.de>
	<1193820584.3274.16.camel@localhost.localdomain>
	<s5hve8noey5.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by alsa0.perex.cz (Postfix) with ESMTP id 3446A24458
	for <alsa-devel@alsa-project.org>; Thu,  1 Nov 2007 03:18:12 +0100 (CET)
In-Reply-To: <s5hve8noey5.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, 2007-10-31 at 09:39 +0100, Takashi Iwai wrote:

> > So,we should patch the patch_sigmatel.c like that?
> 
> Yes, that's what I meant (almost same change I did in my local tree :)
> I'm going to split this to two pieces, the change of m82 pin config
> and the hack for multi-HP outs (also my last change to autocfg
> parser).
> 
> Anyway, could you give your sign-off?  Then I'll apply the patches to
> the HG tree for better testing.

Okay. Thanks

One minor issue:
The mic pin is always in the hp_outs and have the unsolicited response
ability.

If someone just plug the mic jack,the speaker will be muted.

How about this patch?
1.We may only return true in get_pin_presence() when it works as HP.
2.Trigger a unsol_event in stac92xx_io_switch_put();

Thanks!

diff -Nur a/alsa-driver-hg20071031/alsa-kernel/pci/hda/patch_sigmatel.c
b/alsa-driver-hg20071031/alsa-kernel/pci/hda/patch_sigmatel.c
--- a/alsa-driver-hg20071031/alsa-kernel/pci/hda/patch_sigmatel.c
2007-10-23 08:00:10.000000000 +0800
+++ b/alsa-driver-hg20071031/alsa-kernel/pci/hda/patch_sigmatel.c
2007-11-01 09:59:12.000000000 +0800
@@ -1552,6 +1552,9 @@
 			pinctl |= stac92xx_get_vref(codec, nid);
 		stac92xx_auto_set_pinctl(codec, nid, pinctl);
 	}
+
+	codec->patch_ops.unsol_event(codec, STAC_HP_EVENT << 26);
+
         return 1;
 }
 
@@ -2409,8 +2412,14 @@
 	if (!nid)
 		return 0;
 	if (snd_hda_codec_read(codec, nid, 0, AC_VERB_GET_PIN_SENSE, 0x00)
-	    & (1 << 31))
-		return 1;
+	    & (1 << 31)) {
+		if (snd_hda_codec_read(codec, nid,
+			0, AC_VERB_GET_PIN_WIDGET_CONTROL, 0x00) & AC_PINCTL_IN_EN)
+			return 0;
+		else
+			return 1;
+	}
+		
 	return 0;
 }
 


> 
> Thanks,
> 
> Takashi
> 
