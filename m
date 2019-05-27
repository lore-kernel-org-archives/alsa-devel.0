From: libin.yang@intel.com
Subject: [RFC PATCH 1/4] ASoC: hdac_hdmi: amixer kctl setting
	should not impact on jack status
Date: Mon, 27 May 2019 17:07:24 +0800
Message-ID: <1558948047-18930-2-git-send-email-libin.yang@intel.com>
References: <1558948047-18930-1-git-send-email-libin.yang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id DACA4F80730
 for <alsa-devel@alsa-project.org>; Mon, 27 May 2019 11:27:35 +0200 (CEST)
In-Reply-To: <1558948047-18930-1-git-send-email-libin.yang@intel.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, libin.yang@intel.com, broonie@kernel.org, pierre-louis.bossart@linux.intel.com
List-Id: alsa-devel@alsa-project.org

From: Libin Yang <libin.yang@intel.com>

Amixer kctl setting should not impact on the jack connection status.
In hdac_hdmi_present_sense(), it will call hdac_hdmi_jack_report() to
report the monitor connection status. This means the jack status represents
the HDMI monitor connection status.

However, in the original code, hdac_hdmi_set_pin_port_mux() will also
call hdac_hdmi_jack_report() when "pinx-porty Mux" setting is changed. This
means the kctl setting will also impact on the jack status regardless of
the monitor connection. This will introduce some troubles. For example,
assuming the original amixer setting is:
"pin5-port0 Mux" is set "cvt 2"
"pin5-port1 Mux" is set "cvt 2"
HDMI uses pin5 and HDMI is connected to the machine.
After booting the system, setting "pin5-port1 Mux" to "NONE" will
trigger hdac_hdmi_set_pin_port_mux() calling hdac_hdmi_jack_report(false)
In this situation, user space will get the wrong status.

This patch removes calling hdac_hdmi_jack_report() in
hdac_hdmi_set_pin_port_mux(). This makes jack status always represents
the monitor connection status.

Signed-off-by: Libin Yang <libin.yang@intel.com>
---
 sound/soc/codecs/hdac_hdmi.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/hdac_hdmi.c b/sound/soc/codecs/hdac_hdmi.c
index 660e058..5a9e7f9 100644
--- a/sound/soc/codecs/hdac_hdmi.c
+++ b/sound/soc/codecs/hdac_hdmi.c
@@ -855,7 +855,6 @@ static int hdac_hdmi_pin_mux_widget_event(struct snd_soc_dapm_widget *w,
 static int hdac_hdmi_set_pin_port_mux(struct snd_kcontrol *kcontrol,
 		struct snd_ctl_elem_value *ucontrol)
 {
-	int ret;
 	struct hdac_hdmi_port *p, *p_next;
 	struct soc_enum *e = (struct soc_enum *)kcontrol->private_value;
 	struct snd_soc_dapm_widget *w = snd_soc_dapm_kcontrol_widget(kcontrol);
@@ -865,6 +864,7 @@ static int hdac_hdmi_set_pin_port_mux(struct snd_kcontrol *kcontrol,
 	struct hdac_hdmi_priv *hdmi = hdev_to_hdmi_priv(hdev);
 	struct hdac_hdmi_pcm *pcm = NULL;
 	const char *cvt_name =  e->texts[ucontrol->value.enumerated.item[0]];
+	int ret;
 
 	ret = snd_soc_dapm_put_enum_double(kcontrol, ucontrol);
 	if (ret < 0)
@@ -880,10 +880,8 @@ static int hdac_hdmi_set_pin_port_mux(struct snd_kcontrol *kcontrol,
 
 		list_for_each_entry_safe(p, p_next, &pcm->port_list, head) {
 			if (p == port && p->id == port->id &&
-					p->pin == port->pin) {
-				hdac_hdmi_jack_report(pcm, port, false);
+			    p->pin == port->pin)
 				list_del(&p->head);
-			}
 		}
 	}
 
@@ -895,7 +893,6 @@ static int hdac_hdmi_set_pin_port_mux(struct snd_kcontrol *kcontrol,
 		if (!strcmp(cvt_name, pcm->cvt->name)) {
 			list_add_tail(&port->head, &pcm->port_list);
 			if (port->eld.monitor_present && port->eld.eld_valid) {
-				hdac_hdmi_jack_report(pcm, port, true);
 				mutex_unlock(&hdmi->pin_mutex);
 				return ret;
 			}
-- 
2.7.4
