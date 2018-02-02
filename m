From: <kaichieh.chuang@mediatek.com>
Subject: [PATCH] ASoC: dapm: fix debugfs read using
	path->connected
Date: Fri, 2 Feb 2018 15:03:35 +0800
Message-ID: <1517555015-19080-1-git-send-email-kaichieh.chuang@mediatek.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6504481781458582052=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 by alsa0.perex.cz (Postfix) with ESMTP id 4968B266F64
 for <alsa-devel@alsa-project.org>; Fri,  2 Feb 2018 08:03:42 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, chipeng.chang@mediatek.com, garlic.tseng@mediatek.com, srv_wsdupstream@mediatek.com, shane.chien@mediatek.com, linux-mediatek@lists.infradead.org, kaichieh.chuang@mediatek.com
List-Id: alsa-devel@alsa-project.org

--===============6504481781458582052==
Content-Type: multipart/related;
	boundary="__=_Part_Boundary_001_1224092056.1181097657"

--__=_Part_Boundary_001_1224092056.1181097657
MIME-Version: 1.0
Content-Type: text/plain

From: KaiChieh Chuang <kaichieh.chuang@mediatek.com>

This fix a bug in dapm_widget_power_read_file(),
where it may sent opposite order of source/sink widget
into the p->connected().

for example,
static int connected_check(source, sink);
{"w_sink", NULL, "w_source", connected_check}

the dapm_widget_power_read_file() will query p->connected()
in following case
        p->conneted("w_source", "w_sink")
        p->conneted("w_sink", "w_source")
we should avoid the last case, since it's the wrong order (source/sink)
as declared in snd_soc_dapm_route.

Signed-off-by: KaiChieh Chuang <kaichieh.chuang@mediatek.com>
---
 sound/soc/soc-dapm.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index a10b21c..ee6d9d9a 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -2026,7 +2026,7 @@ static ssize_t dapm_widget_power_read_file(struct file *fi
le,
        snd_soc_dapm_for_each_direction(dir) {
                rdir = SND_SOC_DAPM_DIR_REVERSE(dir);
                snd_soc_dapm_widget_for_each_path(w, dir, p) {
-                       if (p->connected && !p->connected(w, p->node[rdir]))
+                       if (p->connected && !p->connected(p->source, p->sink))
                                continue;

                        if (!p->connect)
--
1.7.9.5


************* Email Confidentiality Notice ********************
The information contained in this e-mail message (including any
attachments) may be confidential, proprietary, privileged, or otherwise
exempt from disclosure under applicable laws. It is intended to be
conveyed only to the designated recipient(s). Any use, dissemination,
distribution, printing, retaining or copying of this e-mail (including its
attachments) by unintended recipient(s) is strictly prohibited and may
be unlawful. If you are not an intended recipient of this e-mail, or believe
that you have received this e-mail in error, please notify the sender
immediately (by replying to this e-mail), delete any and all copies of
this e-mail (including any attachments) from your system, and do not
disclose the content of this e-mail to any other person. Thank you!

--__=_Part_Boundary_001_1224092056.1181097657--


--===============6504481781458582052==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6504481781458582052==--
