From: jeeja.kp@intel.com
Subject: [PATCH 2/2] ASoC: hdac_hdmi: don't update the iterator
	in pcm list remove
Date: Wed,  1 Mar 2017 22:41:24 +0530
Message-ID: <1488388284-11227-2-git-send-email-jeeja.kp@intel.com>
References: <1488388284-11227-1-git-send-email-jeeja.kp@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id 7499A266991
 for <alsa-devel@alsa-project.org>; Wed,  1 Mar 2017 17:59:37 +0100 (CET)
In-Reply-To: <1488388284-11227-1-git-send-email-jeeja.kp@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, patches.audio@intel.com, broonie@kernel.org, liam.r.girdwood@intel.com, Jeeja KP <jeeja.kp@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Jeeja KP <jeeja.kp@intel.com>

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
---
 sound/soc/codecs/hdac_hdmi.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/hdac_hdmi.c b/sound/soc/codecs/hdac_hdmi.c
index bb40569..fd272a4 100644
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
2.5.0
