From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: hdac_hdmi: don't update the iterator in
	pcm list remove" to the asoc tree
Date: Mon, 06 Mar 2017 11:46:26 +0100
Message-ID: <E1ckq9q-0002PY-3H@finisterre>
References: <1488388284-11227-2-git-send-email-jeeja.kp@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 6BD6B266D9F
 for <alsa-devel@alsa-project.org>; Mon,  6 Mar 2017 11:46:44 +0100 (CET)
In-Reply-To: <1488388284-11227-2-git-send-email-jeeja.kp@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jeeja KP <jeeja.kp@intel.com>
Cc: alsa-devel@alsa-project.org, liam.r.girdwood@intel.com, Vinod Koul <vinod.koul@intel.com>, patches.audio@intel.com, Julia Lawall <Julia.Lawall@lip6.fr>, broonie@kernel.org, tiwai@suse.de, Dan Carpenter <dan.carpenter@oracle.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: hdac_hdmi: don't update the iterator in pcm list remove

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 2fe42dd0f13812d38daaf05bcb1fd996afd0e87a Mon Sep 17 00:00:00 2001
From: Jeeja KP <jeeja.kp@intel.com>
Date: Wed, 1 Mar 2017 22:41:24 +0530
Subject: [PATCH] ASoC: hdac_hdmi: don't update the iterator in pcm list remove

Fix not to update the iterator element, instead use list_del to remove
entry from the list.

This fixes the following coccinelle and static checker warning:
sound/soc/codecs/hdac_hdmi.c:1884:2-21:iterator with update on line
1885
sound/soc/codecs/hdac_hdmi.c:2011 hdac_hdmi_dev_remove()
	error: potential NULL dereference 'port'.

Fixes: e0e5d3e5a53b('ASoC: hdac_hdmi: Add support for multiple ports to a PCM')
Reported-by: Julia Lawall <Julia.Lawall@lip6.fr>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Acked-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/hdac_hdmi.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/hdac_hdmi.c b/sound/soc/codecs/hdac_hdmi.c
index bb405698e102..fd272a40485b 100644
--- a/sound/soc/codecs/hdac_hdmi.c
+++ b/sound/soc/codecs/hdac_hdmi.c
@@ -1997,7 +1997,7 @@ static int hdac_hdmi_dev_remove(struct hdac_ext_device *edev)
 	struct hdac_hdmi_pin *pin, *pin_next;
 	struct hdac_hdmi_cvt *cvt, *cvt_next;
 	struct hdac_hdmi_pcm *pcm, *pcm_next;
-	struct hdac_hdmi_port *port;
+	struct hdac_hdmi_port *port, *port_next;
 	int i;
 
 	snd_soc_unregister_codec(&edev->hdac.dev);
@@ -2007,8 +2007,9 @@ static int hdac_hdmi_dev_remove(struct hdac_ext_device *edev)
 		if (list_empty(&pcm->port_list))
 			continue;
 
-		list_for_each_entry(port, &pcm->port_list, head)
-			port = NULL;
+		list_for_each_entry_safe(port, port_next,
+					&pcm->port_list, head)
+			list_del(&port->head);
 
 		list_del(&pcm->head);
 		kfree(pcm);
-- 
2.11.0
