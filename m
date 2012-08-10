From: "Lin, Mengdong" <mengdong.lin@intel.com>
Subject: [PATCH] ALSA : hda - bug fix on return value check
 when getting supported power states of a codec
Date: Fri, 10 Aug 2012 09:15:51 +0000
Message-ID: <F46914AEC2663F4A9BB62374E5EEF8F816FDAD@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 20DFB2664AC
 for <alsa-devel@alsa-project.org>; Fri, 10 Aug 2012 10:46:10 +0200 (CEST)
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "tiwai@suse.de" <tiwai@suse.de>
Cc: "Wang, Xingchao" <xingchao.wang@intel.com>
List-Id: alsa-devel@alsa-project.org

The return value of snd_hda_param_read() is -1 for an error, otherwise it's the supported power states of a codec.

The supported power states is a 32-bit value. Bit 31 will be set to 1 if the codec supports EPSS, thus making "sup" negative. And the bit 28:5 is reserved as "0".
So a negative value other than -1 shall be further checked.

Please refer to High-Definition spec 7.3.4.12 "Supported Power States", thanks!


Signed-off-by: Mengdong Lin <mengdong.lin@intel.com>
---
sound/pci/hda/hda_codec.c |    2 +-
1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index 88a9c20..629131a 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -3497,7 +3497,7 @@ static bool snd_hda_codec_get_supported_ps(struct hda_codec *codec, hda_nid_t fg
{
       int sup = snd_hda_param_read(codec, fg, AC_PAR_POWER_STATE);
-        if (sup < 0)
+       if (sup == -1)
                return false;
       if (sup & power_state)
                return true;
--
1.7.9.5
