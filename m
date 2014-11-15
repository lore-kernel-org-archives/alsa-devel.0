From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH] add Steinberg UR44 USB Audio
	Interface	support to quirks-table
Date: Sat, 15 Nov 2014 14:00:34 +0100
Message-ID: <54674E72.4070607@ladisch.de>
References: <1394388767-23658-1-git-send-email-cyrus@bobobeach.com>	<531DAB14.5080201@ladisch.de>	<76F78615-8762-4A6C-B601-97380805F450@bobobeach.com>	<531DDD04.5050902@ladisch.de>	<0EFBCC9F-93CA-4368-9530-B9049B3743FB@bobobeach.com>	<531EC9CC.4060203@ladisch.de>	<88C9DBF9-92A3-4885-87C5-A9966C326D0F@bobobeach.com>	<545895AD.7020004@ladisch.de>
 <545A697C.5070800@bobobeach.com> <545A93E3.7020906@ladisch.de>
 <545B0B54.5080609@bobobeach.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id DF2732605B6
 for <alsa-devel@alsa-project.org>; Sat, 15 Nov 2014 14:00:49 +0100 (CET)
In-Reply-To: <545B0B54.5080609@bobobeach.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Cyrus Harmon <cyrus@bobobeach.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

(Sorry for the delay.)

Cyrus Harmon wrote:
> [    2.978159] snd-usb-audio 3-3.2:1.1: probe step 2
> [    2.978334] snd-usb-audio 3-3.2:1.1: probe failed

Still mysterious.  Please try with this patch instead.


Regards,
Clemens


--- a/sound/core/pcm.c
+++ b/sound/core/pcm.c
@@ -1086,6 +1086,7 @@ static int snd_pcm_dev_register(struct snd_device *device)
 	mutex_lock(&register_mutex);
 	err = snd_pcm_add(pcm);
 	if (err) {
+		printk(KERN_ERR "snd_pcm_add(%d) failed\n", pcm->device);
 		mutex_unlock(&register_mutex);
 		return err;
 	}
@@ -1115,6 +1116,7 @@ static int snd_pcm_dev_register(struct snd_device *device)
 						  &snd_pcm_f_ops[cidx],
 						  pcm, str, dev);
 		if (err < 0) {
+			dev_err(dev, "snd_register_device_for_dev failed: %d\n", err);
 			list_del(&pcm->list);
 			mutex_unlock(&register_mutex);
 			return err;
