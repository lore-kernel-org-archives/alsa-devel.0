From: kbuild test robot <fengguang.wu@intel.com>
Subject: [RFC PATCH sound] ALSA: firewire-lib:
 process_rx_data_blocks() can be static
Date: Tue, 29 Sep 2015 22:46:10 +0800
Message-ID: <20150929144610.GA72209@roam>
References: <201509292248.kwkRZFqi%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id D0A56265705
 for <alsa-devel@alsa-project.org>; Tue, 29 Sep 2015 16:47:22 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <201509292248.kwkRZFqi%fengguang.wu@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, kbuild-all@01.org
List-Id: alsa-devel@alsa-project.org


Signed-off-by: Fengguang Wu <fengguang.wu@intel.com>
---
 amdtp-am824.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/firewire/amdtp-am824.c b/sound/firewire/amdtp-am824.c
index fe4b83f..bebddc6 100644
--- a/sound/firewire/amdtp-am824.c
+++ b/sound/firewire/amdtp-am824.c
@@ -399,8 +399,8 @@ static void read_midi_messages(struct amdtp_stream *s,
 	}
 }
 
-unsigned int process_rx_data_blocks(struct amdtp_stream *s, __be32 *buffer,
-				    unsigned int data_blocks, unsigned int *syt)
+static unsigned int process_rx_data_blocks(struct amdtp_stream *s, __be32 *buffer,
+					   unsigned int data_blocks, unsigned int *syt)
 {
 	struct amdtp_am824 *p = s->protocol;
 	struct snd_pcm_substream *pcm = ACCESS_ONCE(s->pcm);
@@ -420,8 +420,8 @@ unsigned int process_rx_data_blocks(struct amdtp_stream *s, __be32 *buffer,
 	return pcm_frames;
 }
 
-unsigned int process_tx_data_blocks(struct amdtp_stream *s, __be32 *buffer,
-				    unsigned int data_blocks, unsigned int *syt)
+static unsigned int process_tx_data_blocks(struct amdtp_stream *s, __be32 *buffer,
+					   unsigned int data_blocks, unsigned int *syt)
 {
 	struct amdtp_am824 *p = s->protocol;
 	struct snd_pcm_substream *pcm = ACCESS_ONCE(s->pcm);
