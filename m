From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Subject: Re: [PATCH TINYCOMPRESS 14/14 v2] cplay:
	support	auto-configuration of fragment size and count
Date: Fri, 22 Feb 2013 16:11:25 +0000
Message-ID: <20130222161125.GN21174@opensource.wolfsonmicro.com>
References: <20130210002340.GN31139@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 55F1D265DDF
 for <alsa-devel@alsa-project.org>; Fri, 22 Feb 2013 17:11:27 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20130210002340.GN31139@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: vinod.koul@intel.com
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Default the fragment size and count to zero to take advantage
of the auto-configuration support that was added to tinycompress.
If user doesn't override these by specifying -f and -b values
on the command line, they will be passed to tinycompress as zero
and tinycompress will query the driver for size and count.

---
 cplay.c |   14 ++++++++++----
 1 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/cplay.c b/cplay.c
index 3af6d13..60995a4 100644
--- a/cplay.c
+++ b/cplay.c
@@ -152,9 +152,9 @@ static int print_time(struct compress *compress)
 int main(int argc, char **argv)
 {
 	char *file;
-	unsigned long buffer_size = 100*1024;
+	unsigned long buffer_size = 0;
 	int c;
-	unsigned int card = 0, device = 0, frag = 4;
+	unsigned int card = 0, device = 0, frag = 0;
 
 
 	if (argc < 2)
@@ -276,8 +276,14 @@ void play_samples(char *name, unsigned int card, unsigned int device,
 	codec.level = 0;
 	codec.ch_mode = 0;
 	codec.format = 0;
-	config.fragment_size = buffer_size/frag;
-	config.fragments = frag;
+	if ((buffer_size != 0) && (frag != 0)) {
+		config.fragment_size = buffer_size/frag;
+		config.fragments = frag;
+	} else {
+		/* use driver defaults */
+		config.fragment_size = 0;
+		config.fragments = 0;
+	}
 	config.codec = &codec;
 
 	compress = compress_open(card, device, COMPRESS_IN, &config);
-- 
1.7.2.5
