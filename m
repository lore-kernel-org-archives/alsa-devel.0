From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH alsa-lib v2 0/6] pcm: hw: optimization for
	v2.0.14 of PCM protocol/interface
Date: Fri, 30 Jun 2017 20:37:23 +0900
Message-ID: <20170630113729.13656-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy002.phy.lolipop.jp (smtp-proxy002.phy.lolipop.jp
 [157.7.104.43]) by alsa0.perex.cz (Postfix) with ESMTP id F39CD2674A2
 for <alsa-devel@alsa-project.org>; Fri, 30 Jun 2017 13:37:33 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

This patchset is a revised version of my previous one:

[PATCH alsa-lib 00/12] pcm: hw: optimization for v2.0.14 of PCM protocol/interface  
http://mailman.alsa-project.org/pipermail/alsa-devel/2017-June/122392.html 

Changes:
 - add a helper function, 'query_status_and_control_data()' to update appl_ptr
   in user space.
 - rename 'query_state()' to 'query_status_data()'
 - reduce two patches.
 - aggregate some patches for querying control data.

I did quick mesurement by execute aplay on x86 machine with.

1. With Intel HDA driver with usual configuration.
```
poll([{fd=4, events=POLLOUT|POLLERR|POLLNVAL}], 1, -1) = 1 ([{fd=4, revents=POLLOUT}])
ioctl(4, SNDRV_PCM_IOCTL_HWSYNC, 0)     = 0
read(3, "a\23IH\205\177z\257\276]\346\237\313\220L\5\337V\363\351\216\17\346s\22\245-yb\312\37D"..., 16384) = 16384
ioctl(4, SNDRV_PCM_IOCTL_HWSYNC, 0)     = 0
poll([{fd=4, events=POLLOUT|POLLERR|POLLNVAL}], 1, -1) = 1 ([{fd=4, revents=POLLOUT}])
```

2. With Intel HDA driver with 'sync_ptr_ioctl' option to hw PCM plugin.
```
poll([{fd=4, events=POLLOUT|POLLERR|POLLNVAL}], 1, -1) = 1 ([{fd=4, revents=POLLOUT}])
ioctl(4, SNDRV_PCM_IOCTL_SYNC_PTR, 0x55fe03539f80) = 0
ioctl(4, SNDRV_PCM_IOCTL_SYNC_PTR, 0x55fe03539f80) = 0
ioctl(4, SNDRV_PCM_IOCTL_SYNC_PTR, 0x55fe03539f80) = 0
ioctl(4, SNDRV_PCM_IOCTL_SYNC_PTR, 0x55fe03539f80) = 0
read(3, "Rz\vB\v|A\275\356`\201)\335i3\r}\21Q^\30\324'\r'\375l\235&\3330\2"..., 16384) = 16384
ioctl(4, SNDRV_PCM_IOCTL_SYNC_PTR, 0x55fe03539f80) = 0
ioctl(4, SNDRV_PCM_IOCTL_SYNC_PTR, 0x55fe03539f80) = 0
ioctl(4, SNDRV_PCM_IOCTL_SYNC_PTR, 0x55fe03539f80) = 0
poll([{fd=4, events=POLLOUT|POLLERR|POLLNVAL}], 1, -1) = 1 ([{fd=4, revents=POLLOUT}])
```

3. With Fireworks driver with a patch for snd-firewire-lib to add
   SNDRV_PCM_INFO_SYNC_APPLPTR  support[1].
```
poll([{fd=4, events=POLLOUT|POLLERR|POLLNVAL}], 1, -1) = 1 ([{fd=4, revents=POLLOUT}])
ioctl(4, SNDRV_PCM_IOCTL_HWSYNC, 0)     = 0
ioctl(4, SNDRV_PCM_IOCTL_SYNC_PTR, 0x55b647ec9c00) = 0
read(3, "|\n*\336\322\252*&\377\312\372&\276\333.\207\21\343\362\3\5\363\201\266\3421lZ;\\\22*"..., 24576) = 24576
ioctl(4, SNDRV_PCM_IOCTL_HWSYNC, 0)     = 0
poll([{fd=4, events=POLLOUT|POLLERR|POLLNVAL}], 1, -1) = 1 ([{fd=4, revents=POLLOUT}])
```

We can see this optimization reduces some ioctl calls in case 3. This is
due to status data mapping.

[1] Below.
diff --git a/sound/firewire/amdtp-stream.c b/sound/firewire/amdtp-stream.c
index f8c2765..04fb3df 100644
--- a/sound/firewire/amdtp-stream.c
+++ b/sound/firewire/amdtp-stream.c
@@ -160,7 +160,8 @@ int amdtp_stream_add_pcm_hw_constraints(struct amdtp_stream *s,
                   SNDRV_PCM_INFO_INTERLEAVED |
                   SNDRV_PCM_INFO_JOINT_DUPLEX |
                   SNDRV_PCM_INFO_MMAP |
-                  SNDRV_PCM_INFO_MMAP_VALID;
+                  SNDRV_PCM_INFO_MMAP_VALID |
+                  SNDRV_PCM_INFO_SYNC_APPLPTR;
 
        /* SNDRV_PCM_INFO_BATCH */
        hw->periods_min = 2;

Takashi Sakamoto (6):
  pcm: hw: add a helper function to query status/control data
  pcm: hw: add a helper function just to query status data
  pcm: hw: add a helper function to request hwsync without side-effects
  pcm: hw: add a helper function to issue appl_ptr without side-effects
  pcm: hw: add a helper function to issue avail_min without side-effects
  pcm: hw: remove superfluous code to call of SNDRV_PCM_IOCTL_SYNC_PTR
    in snd_pcm_hw_forward()

 src/pcm/pcm_hw.c | 116 +++++++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 86 insertions(+), 30 deletions(-)

-- 
2.11.0
