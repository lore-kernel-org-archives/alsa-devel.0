From: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Subject: [PATCH 1/8] ALSA: hpdsm - RME AES(32): Fix missing
	channel mappings
Date: Wed, 23 Feb 2011 11:43:08 +0100
Message-ID: <1298457795-28114-2-git-send-email-adi@drcomp.erfurt.thur.de>
References: <1298457795-28114-1-git-send-email-adi@drcomp.erfurt.thur.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1298457795-28114-1-git-send-email-adi@drcomp.erfurt.thur.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: Adrian Knoth <adi@drcomp.erfurt.thur.de>, alsa-devel@alsa-project.org, Florian Faber <faber@faberman.de>, Fredrik Lingvall <fredrik.lingvall@gmail.com>
List-Id: alsa-devel@alsa-project.org

On RME AES and AES(32), none of the required information
(max_channels_in, max_channels_out, channel mappings, port names) was
set, leading to the BUG below.

This patch adds the missing bits, thus fixing the bug.

125.058768] ------------[ cut here ]------------
[  125.058773] WARNING: at sound/pci/rme9652/hdspm.c:5389
snd_hdspm_ioctl+0x10c/0x1d8 [snd_hdspm]()
[  125.058775] Hardware name: PRIMERGY RX100 S6
[  125.058777] BUG? (info->channel >= hdspm->max_channels_out)
[  125.058778] Modules linked in: ipmi_watchdog ipmi_poweroff ipmi_si
ipmi_devintf ipmi_msghandler snd_hdspm power_meter e1000e snd_rawmidi
i2c_i801
[  125.058787] Pid: 3652, comm: audacity Tainted: G        W
2.6.36-gentoo-r5 #5
[  125.058788] Call Trace:
[  125.058792]  [<ffffffff8103db3a>] warn_slowpath_common+0x80/0x98
[  125.058796]  [<ffffffff8103dbe6>] warn_slowpath_fmt+0x41/0x43
[  125.058800]  [<ffffffffa006761a>] snd_hdspm_ioctl+0x10c/0x1d8
[snd_hdspm]
[  125.058803]  [<ffffffff813fd626>] snd_pcm_channel_info+0x73/0x7c
[  125.058806]  [<ffffffff814001e9>] snd_pcm_common_ioctl1+0x326/0xb01
[  125.058809]  [<ffffffff810c604c>] ? __do_fault+0x361/0x3a6
[  125.058812]  [<ffffffff81400e23>] snd_pcm_playback_ioctl1+0x20a/0x227
[  125.058815]  [<ffffffff811e599c>] ? file_has_perm+0x90/0x9e
[  125.058818]  [<ffffffff81400e6a>] snd_pcm_playback_ioctl+0x2a/0x2e
[  125.058821]  [<ffffffff810f2c69>] do_vfs_ioctl+0x404/0x453
[  125.058824]  [<ffffffff810f2d09>] sys_ioctl+0x51/0x74
[  125.058827]  [<ffffffff81002aab>] system_call_fastpath+0x16/0x1b
[  125.058830] ---[ end trace 5bddb08e5d4cbeb1 ]---

Signed-off-by: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Signed-off-by: Florian Faber <faber@faberman.de>
Signed-off-by: Fredrik Lingvall <fredrik.lingvall@gmail.com>

diff --git a/sound/pci/rme9652/hdspm.c b/sound/pci/rme9652/hdspm.c
index 6de88b0..9258897 100644
--- a/sound/pci/rme9652/hdspm.c
+++ b/sound/pci/rme9652/hdspm.c
@@ -667,6 +667,12 @@ static char *texts_ports_aio_out_qs[] = {
 	"Phone.L", "Phone.R"
 };
 
+static char *texts_ports_aes32[] = {
+	"AES.1", "AES.2", "AES.3", "AES.4", "AES.5", "AES.6", "AES.7",
+	"AES.8", "AES.9.", "AES.10", "AES.11", "AES.12", "AES.13", "AES.14",
+	"AES.15", "AES.16"
+};
+
 /* These tables map the ALSA channels 1..N to the channels that we
    need to use in order to find the relevant channel buffer. RME
    refers to this kind of mapping as between "the ADAT channel and
@@ -816,6 +822,17 @@ static char channel_map_aio_out_qs[HDSPM_MAX_CHANNELS] = {
 	-1, -1, -1, -1, -1, -1, -1, -1
 };
 
+static char channel_map_aes32[HDSPM_MAX_CHANNELS] = {
+	0, 1, 2, 3, 4, 5, 6, 7,
+	8, 9, 10, 11, 12, 13, 14, 15,
+	-1, -1, -1, -1, -1, -1, -1, -1,
+	-1, -1, -1, -1, -1, -1, -1, -1,
+	-1, -1, -1, -1, -1, -1, -1, -1,
+	-1, -1, -1, -1, -1, -1, -1, -1,
+	-1, -1, -1, -1, -1, -1, -1, -1,
+	-1, -1, -1, -1, -1, -1, -1, -1
+};
+
 struct hdspm_midi {
 	struct hdspm *hdspm;
 	int id;
@@ -6396,6 +6413,29 @@ static int __devinit snd_hdspm_create(struct snd_card *card,
 
 	switch (hdspm->io_type) {
 	case AES32:
+		hdspm->ss_in_channels = hdspm->ss_out_channels = 16;
+		hdspm->ds_in_channels = hdspm->ds_out_channels = 16;
+		hdspm->qs_in_channels = hdspm->qs_out_channels = 16;
+
+		hdspm->channel_map_in_ss = hdspm->channel_map_out_ss =
+			channel_map_aes32;
+		hdspm->channel_map_in_ds = hdspm->channel_map_out_ds =
+			channel_map_aes32;
+		hdspm->channel_map_in_qs = hdspm->channel_map_out_qs =
+			channel_map_aes32;
+		hdspm->port_names_in_ss = hdspm->port_names_out_ss =
+			texts_ports_aes32;
+		hdspm->port_names_in_ds = hdspm->port_names_out_ds =
+			texts_ports_aes32;
+		hdspm->port_names_in_qs = hdspm->port_names_out_qs =
+			texts_ports_aes32;
+
+		hdspm->max_channels_out = hdspm->max_channels_in = 16;
+		hdspm->port_names_in = hdspm->port_names_out =
+			texts_ports_aes32;
+		hdspm->channel_map_in = hdspm->channel_map_out =
+			channel_map_aes32;
+
 		break;
 
 	case MADI:
-- 
1.7.2.3
