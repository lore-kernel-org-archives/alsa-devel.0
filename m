From: Marek Belisko <marek.belisko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v2 1/3] ASoC: spdif_transceiver: Change driver filename to
 spdif_transmitter.c.
Date: Thu, 25 Apr 2013 15:13:12 +0200
Message-ID: <1366895594-19596-2-git-send-email-marek.belisko@streamunlimited.com>
References: <1366895594-19596-1-git-send-email-marek.belisko@streamunlimited.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <1366895594-19596-1-git-send-email-marek.belisko-6oiIBCxl0MMjD8S081q9vkEOCMrvLtNR@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tiwai-l3A5Bk7waGM@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Marek Belisko <marek.belisko-6oiIBCxl0MMjD8S081q9vkEOCMrvLtNR@public.gmane.org>, perex-/Fr2/VpizcU@public.gmane.org
List-Id: alsa-devel@alsa-project.org

Transceiver usually means receiver + transmitter. This codec can do only
transmit. Update driver accordingly.

Signed-off-by: Marek Belisko <marek.belisko-6oiIBCxl0MMjD8S081q9vkEOCMrvLtNR@public.gmane.org>
---
 sound/soc/codecs/Makefile                          |    2 +-
 .../{spdif_transciever.c => spdif_transmitter.c}   |    0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename sound/soc/codecs/{spdif_transciever.c => spdif_transmitter.c} (100%)

diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index 8cf5951..4252c35 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -51,7 +51,7 @@ snd-soc-alc5632-objs := alc5632.o
 snd-soc-sigmadsp-objs := sigmadsp.o
 snd-soc-si476x-objs := si476x.o
 snd-soc-sn95031-objs := sn95031.o
-snd-soc-spdif-tx-objs := spdif_transciever.o
+snd-soc-spdif-tx-objs := spdif_transmitter.o
 snd-soc-spdif-rx-objs := spdif_receiver.o
 snd-soc-ssm2602-objs := ssm2602.o
 snd-soc-sta32x-objs := sta32x.o
diff --git a/sound/soc/codecs/spdif_transciever.c b/sound/soc/codecs/spdif_transmitter.c
similarity index 100%
rename from sound/soc/codecs/spdif_transciever.c
rename to sound/soc/codecs/spdif_transmitter.c
-- 
1.7.9.5
