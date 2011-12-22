From: linux@audioscience.com
Subject: [PATCH 20/21] Use valid channel count in format
	enumeration.
Date: Thu, 22 Dec 2011 13:38:50 +1300
Message-ID: <1324514331-22570-21-git-send-email-linux@audioscience.com>
References: <1324514331-22570-1-git-send-email-linux@audioscience.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp4.clear.net.nz (smtp4.clear.net.nz [203.97.37.64])
	by alsa0.perex.cz (Postfix) with ESMTP id AF004103C0B
	for <alsa-devel@alsa-project.org>; Thu, 22 Dec 2011 01:40:21 +0100 (CET)
Received: from localhost.localdomain
	(121-72-250-62.cable.telstraclear.net [121.72.250.62])
	by smtp4.clear.net.nz (CLEAR Net Mail)
	with ESMTP id <0LWK00D3EXTHNQ40@smtp4.clear.net.nz> for
	alsa-devel@alsa-project.org; Thu, 22 Dec 2011 13:39:33 +1300 (NZDT)
In-reply-to: <1324514331-22570-1-git-send-email-linux@audioscience.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de
Cc: Eliot Blennerhassett <eblennerhassett@audioscience.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: Eliot Blennerhassett <eblennerhassett@audioscience.com>

Since introduction of mono and low latency modes, fixed channel count of 2
is not always valid.  Use reported max_channels instead.

Signed-off-by: Eliot Blennerhassett <eblennerhassett@audioscience.com>
---
 sound/pci/asihpi/asihpi.c |   20 ++++++++------------
 1 files changed, 8 insertions(+), 12 deletions(-)

diff --git a/sound/pci/asihpi/asihpi.c b/sound/pci/asihpi/asihpi.c
index ab7bc94..4aa8336 100644
--- a/sound/pci/asihpi/asihpi.c
+++ b/sound/pci/asihpi/asihpi.c
@@ -961,14 +961,12 @@ static void snd_card_asihpi_playback_format(struct snd_card_asihpi *asihpi,
 
 	for (format = HPI_FORMAT_PCM8_UNSIGNED;
 	     format <= HPI_FORMAT_PCM24_SIGNED; format++) {
-		err = hpi_format_create(&hpi_format,
-					2, format, sample_rate, 128000, 0);
+		err = hpi_format_create(&hpi_format, asihpi->out_max_chans,
+					format, sample_rate, 128000, 0);
 		if (!err)
-			err = hpi_outstream_query_format(h_stream,
-							&hpi_format);
+			err = hpi_outstream_query_format(h_stream, &hpi_format);
 		if (!err && (hpi_to_alsa_formats[format] != -1))
-			pcmhw->formats |=
-				(1ULL << hpi_to_alsa_formats[format]);
+			pcmhw->formats |= (1ULL << hpi_to_alsa_formats[format]);
 	}
 }
 
@@ -1141,14 +1139,12 @@ static void snd_card_asihpi_capture_format(struct snd_card_asihpi *asihpi,
 	for (format = HPI_FORMAT_PCM8_UNSIGNED;
 		format <= HPI_FORMAT_PCM24_SIGNED; format++) {
 
-		err = hpi_format_create(&hpi_format, 2, format,
-				sample_rate, 128000, 0);
+		err = hpi_format_create(&hpi_format, asihpi->in_max_chans,
+					format, sample_rate, 128000, 0);
 		if (!err)
-			err = hpi_instream_query_format(h_stream,
-					    &hpi_format);
+			err = hpi_instream_query_format(h_stream, &hpi_format);
 		if (!err)
-			pcmhw->formats |=
-				(1ULL << hpi_to_alsa_formats[format]);
+			pcmhw->formats |= (1ULL << hpi_to_alsa_formats[format]);
 	}
 }
 
-- 
1.7.0.4
