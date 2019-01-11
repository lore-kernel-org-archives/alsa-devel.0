From: Sameer Pujar <spujar@nvidia.com>
Subject: [PATCH v2 1/5] ALSA: hda: add verbs for stripe control
Date: Fri, 11 Jan 2019 22:52:04 +0530
Message-ID: <1547227328-32558-2-git-send-email-spujar@nvidia.com>
References: <1547227328-32558-1-git-send-email-spujar@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hqemgate16.nvidia.com (hqemgate16.nvidia.com [216.228.121.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 93BA5266914
 for <alsa-devel@alsa-project.org>; Fri, 11 Jan 2019 18:22:31 +0100 (CET)
In-Reply-To: <1547227328-32558-1-git-send-email-spujar@nvidia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: perex@perex.cz, tiwai@suse.com, broonie@kernel.org
Cc: alsa-devel@alsa-project.org, Sameer Pujar <spujar@nvidia.com>
List-Id: alsa-devel@alsa-project.org

Controllers can support multiple Serial Data Out(SDO) lines, for
extended outbound bandwidth, to pump data to all codecs on the link.
Codecs can sample data present on SDO.

Add verbs AC_VERB_GET_STRIPE_CONTROL and AC_VERB_SET_STRIPE_CONTROL
These can be used to program usage of SDO lines for codec.

Signed-off-by: Sameer Pujar <spujar@nvidia.com>
Reviewed-by: Mohan Kumar D <mkumard@nvidia.com>
Reviewed-by: Ravindra Lokhande <rlokhande@nvidia.com>
---
 include/sound/hda_verbs.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/sound/hda_verbs.h b/include/sound/hda_verbs.h
index 2a8573a..e36b775 100644
--- a/include/sound/hda_verbs.h
+++ b/include/sound/hda_verbs.h
@@ -66,6 +66,7 @@ enum {
 #define AC_VERB_GET_CONFIG_DEFAULT		0x0f1c
 /* f20: AFG/MFG */
 #define AC_VERB_GET_SUBSYSTEM_ID		0x0f20
+#define AC_VERB_GET_STRIPE_CONTROL		0x0f24
 #define AC_VERB_GET_CVT_CHAN_COUNT		0x0f2d
 #define AC_VERB_GET_HDMI_DIP_SIZE		0x0f2e
 #define AC_VERB_GET_HDMI_ELDD			0x0f2f
@@ -110,6 +111,7 @@ enum {
 #define AC_VERB_SET_CONFIG_DEFAULT_BYTES_3	0x71f
 #define AC_VERB_SET_EAPD				0x788
 #define AC_VERB_SET_CODEC_RESET			0x7ff
+#define AC_VERB_SET_STRIPE_CONTROL		0x724
 #define AC_VERB_SET_CVT_CHAN_COUNT		0x72d
 #define AC_VERB_SET_HDMI_DIP_INDEX		0x730
 #define AC_VERB_SET_HDMI_DIP_DATA		0x731
-- 
2.7.4


-----------------------------------------------------------------------------------
This email message is for the sole use of the intended recipient(s) and may contain
confidential information.  Any unauthorized review, use, disclosure or distribution
is prohibited.  If you are not the intended recipient, please contact the sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------------------
