From: Clemens Ladisch <clemens@ladisch.de>
Subject: [PATCH] [19/29] ALSA: dice: make amdtp_rates[] const
Date: Mon, 21 Oct 2013 21:31:42 +0200
Message-ID: <5265811E.5050609@ladisch.de>
References: <52657E3B.7040205@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux1394-devel-bounces@lists.sourceforge.net>
In-Reply-To: <52657E3B.7040205@ladisch.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux1394-devel>
List-Post: <mailto:linux1394-devel@lists.sourceforge.net>
List-Help: <mailto:linux1394-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux1394-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, linux1394-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Clemens Ladisch <clemens@ladisch.de>
---
 sound/firewire/amdtp.c |    2 +-
 sound/firewire/amdtp.h |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/firewire/amdtp.c b/sound/firewire/amdtp.c
index a09c3b3..5540f70 100644
--- a/sound/firewire/amdtp.c
+++ b/sound/firewire/amdtp.c
@@ -65,7 +65,7 @@ void amdtp_out_stream_destroy(struct amdtp_out_stream *s)
 }
 EXPORT_SYMBOL(amdtp_out_stream_destroy);

-unsigned int amdtp_syt_intervals[CIP_SFC_COUNT] = {
+const unsigned int amdtp_syt_intervals[CIP_SFC_COUNT] = {
 	[CIP_SFC_32000]  =  8,
 	[CIP_SFC_44100]  =  8,
 	[CIP_SFC_48000]  =  8,
diff --git a/sound/firewire/amdtp.h b/sound/firewire/amdtp.h
index f3d03dd..839ebf8 100644
--- a/sound/firewire/amdtp.h
+++ b/sound/firewire/amdtp.h
@@ -103,7 +103,7 @@ void amdtp_out_stream_pcm_prepare(struct amdtp_out_stream *s);
 unsigned long amdtp_out_stream_pcm_pointer(struct amdtp_out_stream *s);
 void amdtp_out_stream_pcm_abort(struct amdtp_out_stream *s);

-extern unsigned int amdtp_syt_intervals[CIP_SFC_COUNT];
+extern const unsigned int amdtp_syt_intervals[CIP_SFC_COUNT];

 static inline bool amdtp_out_stream_running(struct amdtp_out_stream *s)
 {

------------------------------------------------------------------------------
October Webinars: Code for Performance
Free Intel webinars can help you accelerate application performance.
Explore tips for MPI, OpenMP, advanced profiling, and more. Get the most from 
the latest Intel processors and coprocessors. See abstracts and register >
http://pubads.g.doubleclick.net/gampad/clk?id=60135991&iu=/4140/ostg.clktrk
