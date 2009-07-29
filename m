From: Wu Fengguang <fengguang.wu@intel.com>
Subject: [PATCH v2] hda: fix out-of-bound hdmi_eld.sad[] write
Date: Wed, 29 Jul 2009 19:31:14 +0800
Message-ID: <20090729113114.GA8367@localhost>
References: <4A702387.8090908@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
	by alsa0.perex.cz (Postfix) with ESMTP id CCF27103889
	for <alsa-devel@alsa-project.org>;
	Wed, 29 Jul 2009 13:31:24 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4A702387.8090908@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Roel Kluin <roel.kluin@gmail.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, Andrew Morton <akpm@linux-foundation.org>
List-Id: alsa-devel@alsa-project.org

On Wed, Jul 29, 2009 at 12:25:11PM +0200, Roel Kluin wrote:
> e->sad[] is declared with size ELD_MAX_SAD (16), but the guard allows
> the range 0-31

Good catch, thank you, Roel!

Minor fix: '>=' should be used in this line:

> +			if (n < 0 || n > ELD_MAX_SAD)

So I'd suggest this updated patch.

Thanks,
Fengguang
---
hda: fix out-of-bound hdmi_eld.sad[] write

From: Roel Kluin <roel.kluin@gmail.com>

e->sad[] is declared with size ELD_MAX_SAD=16, but the guard
allows range 0-31.

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
Signed-off-by: Wu Fengguang <fengguang.wu@intel.com>
---
 sound/pci/hda/hda_eld.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- sound-2.6.orig/sound/pci/hda/hda_eld.c
+++ sound-2.6/sound/pci/hda/hda_eld.c
@@ -508,7 +508,7 @@ static void hdmi_write_eld_info(struct s
 	char name[64];
 	char *sname;
 	long long val;
-	int n;
+	unsigned int n;
 
 	while (!snd_info_get_line(buffer, line, sizeof(line))) {
 		if (sscanf(line, "%s %llx", name, &val) != 2)
@@ -539,7 +539,7 @@ static void hdmi_write_eld_info(struct s
 				sname++;
 				n = 10 * n + name[4] - '0';
 			}
-			if (n < 0 || n > 31) /* double the CEA limit */
+			if (n >= ELD_MAX_SAD)
 				continue;
 			if (!strcmp(sname, "_coding_type"))
 				e->sad[n].format = val;
