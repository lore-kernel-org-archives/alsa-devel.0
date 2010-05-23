From: Andrea Gelmini <andrea.gelmini@gelma.net>
Subject: [PATCH 091/199] Documentation/sound/alsa/serial-u16550.txt: Checkpatch cleanup
Date: Sun, 23 May 2010 21:56:39 +0200
Message-ID: <1274644605-25181-43-git-send-email-andrea.gelmini@gelma.net>
References: <1274644605-25181-1-git-send-email-andrea.gelmini@gelma.net>
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1274644605-25181-1-git-send-email-andrea.gelmini@gelma.net>
Sender: linux-doc-owner@vger.kernel.org
To: andrea.gelmini@gelma.net
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Randy Dunlap <rdunlap@xenotime.net>, alsa-devel@alsa-project.org, linux-doc@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Documentation/sound/alsa/serial-u16550.txt:72: ERROR: trailing whitespace
Documentation/sound/alsa/serial-u16550.txt:77: ERROR: trailing whitespace

Signed-off-by: Andrea Gelmini <andrea.gelmini@gelma.net>
---
 Documentation/sound/alsa/serial-u16550.txt |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/sound/alsa/serial-u16550.txt b/Documentation/sound/alsa/serial-u16550.txt
index c191955..6ad3e66 100644
--- a/Documentation/sound/alsa/serial-u16550.txt
+++ b/Documentation/sound/alsa/serial-u16550.txt
@@ -69,12 +69,12 @@ Usage example for M/B mode:
 
 The MS-124W hardware's M/A mode is currently not supported. This mode allows
 the MIDI Outs to act independently at double the aggregate throughput of M/B,
-but does not allow sending the same byte simultaneously to multiple MIDI Outs. 
+but does not allow sending the same byte simultaneously to multiple MIDI Outs.
 The M/A protocol requires the driver to twiddle the modem control lines under
 timing constraints, so it would be a bit more complicated to implement than
 the other modes.
 
-Midiator models other than MS-124W and MS-124T are currently not supported. 
+Midiator models other than MS-124W and MS-124T are currently not supported.
 Note that the suffix letter is significant; the MS-124 and MS-124B are not
 compatible, nor are the other known models MS-101, MS-101B, MS-103, and MS-114.
 I do have documentation (tim.mann@compaq.com) that partially covers these models,
-- 
1.7.1.251.gf80a2

