From: Johannes Oertel <johannes.oertel@uni-due.de>
Subject: AudioFire4 quirk
Date: Wed, 29 Jul 2015 19:29:23 +0200
Message-ID: <55B90D73.4000602@uni-due.de>
Reply-To: johannes.oertel@uni-due.de
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout.uni-duisburg-essen.de (mailout.uni-duisburg-essen.de
 [132.252.185.20])
 by alsa0.perex.cz (Postfix) with ESMTP id F07332605C2
 for <alsa-devel@alsa-project.org>; Wed, 29 Jul 2015 19:29:32 +0200 (CEST)
Received: from [192.168.0.10] (ip-109-90-217-202.hsi11.unitymediagroup.de
 [109.90.217.202]) (authenticated bits=0)
 by mailout.uni-duisburg-essen.de (8.13.1/8.13.1) with ESMTP id t6THTO8l029993
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT)
 for <alsa-devel@alsa-project.org>; Wed, 29 Jul 2015 19:29:32 +0200
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

when I try to use the snd-fireworks driver with my AudioFire4 (see the 
output of /proc/asound/cardX/firewire/firmware below) on my machine 
(kernel 4.1), it doesn't work. I am experiencing exactly the same 
problems as Harry with his AudioFire2 [1]; dmesg was reporting 
discontinuities.

A few days ago, I saw Takashi Sakamoto's most recent patch for making 
the AudioFire2 work in this case [2]. I adapted his patch (see below) to 
apply to my situation with the AudioFire4 and now it is working 
flawlessly! However, according to the README in Takashi's GitHub 
repository [3], he is testing the driver with an AudioFire4 as well, so 
I asked him why I need this patch and he does not. He told me he is 
using firmware version 5.5 while I'm on 5.7.3. He said he is going to 
test his device with different firmware versions soon and write a patch, 
if needed.

Finally, he asked me to post this whole issue to this list as well and 
that's what I have just done. :)

Best regards,
Johannes


[1] 
http://mailman.alsa-project.org/pipermail/alsa-devel/2014-August/080379.html
[2] 
http://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/commit/?id=9c6893e0be38b6ca9a56a854226e51dee0a16a5a
[3] https://github.com/takaswie/snd-firewire-improve

/proc/asound/cardX/firewire/firmware:
guid_hi: 0x148604
guid_lo: 0x5BA8D7BF
type: 0xAF4
version: 0x0
vendor_name: Echo Digital Audio
model_name: AudioFire4
dsp_version: 0x0
arm_version: 0x5070300
fpga_version: 0x3000200
flags: 0xE1
max_sample_rate: 0x17700
min_sample_rate: 0x7D00
supported_clock: 0x9
phys out: 0x6
phys in: 0x6
phys in grps: 0x2
phys in grp[0]: type 0x0, count 0x4
phys in grp[1]: type 0x1, count 0x2
phys out grps: 0x2
phys out grps[0]: type 0x0, count 0x4
phys out grps[1]: type 0x1, count 0x2
amdtp rx pcm channels 1x: 0x6
amdtp tx pcm channels 1x: 0x6
amdtp rx pcm channels 2x: 0x6
amdtp tx pcm channels 2x: 0x6
amdtp rx pcm channels 4x: 0x6
amdtp tx pcm channels 4x: 0x6
midi out ports: 0x1
midi in ports: 0x1
mixer playback channels: 0x6
mixer capture channels: 0x6

The patch:
---
  sound/firewire/fireworks/fireworks.c        | 2 ++
  sound/firewire/fireworks/fireworks.h        | 1 +
  sound/firewire/fireworks/fireworks_stream.c | 4 ++--
  3 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/sound/firewire/fireworks/fireworks.c 
b/sound/firewire/fireworks/fireworks.c
index c670db4..544bdbf 100644
--- a/sound/firewire/fireworks/fireworks.c
+++ b/sound/firewire/fireworks/fireworks.c
@@ -250,6 +250,8 @@ efw_probe(struct fw_unit *unit,
  		goto error;
  	if (entry->model_id == MODEL_ECHO_AUDIOFIRE_2)
  		efw->is_af2 = true;
+	if (entry->model_id == MODEL_ECHO_AUDIOFIRE_4)
+		efw->is_af4 = true;
  	if (entry->model_id == MODEL_ECHO_AUDIOFIRE_9)
  		efw->is_af9 = true;

diff --git a/sound/firewire/fireworks/fireworks.h 
b/sound/firewire/fireworks/fireworks.h
index 9493122..9a7dcbb 100644
--- a/sound/firewire/fireworks/fireworks.h
+++ b/sound/firewire/fireworks/fireworks.h
@@ -74,6 +74,7 @@ struct snd_efw {

  	/* for quirks */
  	bool is_af2;
+	bool is_af4;
  	bool is_af9;
  	u32 firmware_version;

diff --git a/sound/firewire/fireworks/fireworks_stream.c 
b/sound/firewire/fireworks/fireworks_stream.c
index a0762dd..182b96f 100644
--- a/sound/firewire/fireworks/fireworks_stream.c
+++ b/sound/firewire/fireworks/fireworks_stream.c
@@ -172,8 +172,8 @@ int snd_efw_stream_init_duplex(struct snd_efw *efw)
  	efw->tx_stream.flags |= CIP_DBC_IS_END_EVENT;
  	/* Fireworks reset dbc at bus reset. */
  	efw->tx_stream.flags |= CIP_SKIP_DBC_ZERO_CHECK;
-	/* AudioFire2 starts packets with non-zero dbc. */
-	if (efw->is_af2)
+	/* AudioFire2 and AudioFire4 start packets with non-zero dbc. */
+	if (efw->is_af2 || efw->is_af4)
  		efw->tx_stream.flags |= CIP_SKIP_INIT_DBC_CHECK;
  	/* AudioFire9 always reports wrong dbs. */
  	if (efw->is_af9)
-- 
2.4.6
