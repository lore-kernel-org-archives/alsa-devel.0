From: Wu Fengguang <wfg@linux.intel.com>
Subject: Re: [PATCH] snd-core: enlarge snd_card.components for
	up to 4	codecs
Date: Tue, 7 Oct 2008 16:34:29 +0800
Message-ID: <1223368470.894420.10038@de>
References: <1223362567.716898.9499@de> <s5htzboomf0.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <s5htzboomf0.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, patch@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Oct 07, 2008 at 10:10:43AM +0200, Takashi Iwai wrote:
> At Tue, 7 Oct 2008 14:56:06 +0800,
> Wu Fengguang wrote:
> > 
> > Enlarge snd_card.components[80] to 128 bytes, with space for 4 codecs.
> > The previous size 80 cannot support HP 2230s which has 3 codecs.
> > 
> > Signed-off-by: Wu Fengguang <wfg@linux.intel.com>
> 
> Thanks for the patch.  Unfortunately, this can't be applied as is.
> struct snd_ctl_card_info is exported and used as the ioctl parameter,
> thus you cannot change the size.
> 
> One possible fix is to merge reserved[48] into components[80]
> so that the struct size is kept as is.
> But still we have to be very careful to such a change, and need to
> investigate all possible places to refer it.

OK.

FYI, this is the debug patch and kernel message(lookout the first line) on HP 2230s:

diff --git a/sound/core/init.c b/sound/core/init.c
index 8af467d..704d7e8 100644
--- a/sound/core/init.c
+++ b/sound/core/init.c
@@ -706,6 +706,8 @@ int snd_component_add(struct snd_card *card, const char *component)
 			return 1;
 	}
 	if (strlen(card->components) + 1 + len + 1 > sizeof(card->components)) {
+		snd_printk(KERN_ERR "components = %s + %s\n",
+				card->components, component);
 		snd_BUG();
 		return -ENOMEM;
 	}


[   12.590150] ALSA sound/core/init.c:710: components = HDA:11d4194a,103c3037,00100400 HDA:11c11040,103c1378,00100200 + HDA:80862802,80860101,00100000
[   12.590163] ------------[ cut here ]------------
[   12.590166] WARNING: at sound/core/init.c:711 snd_component_add+0xfa/0x110 [snd]()
[   12.590168] BUG?
[   12.590170] Modules linked in: snd_hda_intel(+) snd_seq_dummy snd_seq_oss snd_seq_midi_event snd_seq snd_seq_device snd_pcm_oss snd_mixer_oss iwlagn snd_pcm snd_timer iwlcore snd_page_alloc snd_hwdep rfkill snd pcspkr led_class sky2 wmi soundcore uhci_hcd ohci_hcd ehci_hcd
[   12.590197] Pid: 2410, comm: modprobe Not tainted 2.6.27-rc7 #4
[   12.590200] 
[   12.590200] Call Trace:
[   12.590209]  [<ffffffff81045d47>] warn_slowpath+0xb7/0xf0
[   12.590213]  [<ffffffff8106c000>] ? static_obj+0x80/0x90
[   12.590217]  [<ffffffff8106e29d>] ? trace_hardirqs_on+0xd/0x10
[   12.590220]  [<ffffffff8106c065>] ? lockdep_init_map+0x55/0x5c0
[   12.590225]  [<ffffffff811e37a9>] ? __next_cpu+0x19/0x30
[   12.590234]  [<ffffffffa003cbb5>] ? snd_verbose_printk+0x85/0xe0 [snd]
[   12.590238]  [<ffffffff811eb4d8>] ? sprintf+0x68/0x70
[   12.590242]  [<ffffffff810607c4>] ? __mutex_init+0x54/0x70
[   12.590247]  [<ffffffffa004ede8>] ? snd_hwdep_new+0xc8/0x150 [snd_hwdep]
[   12.590255]  [<ffffffffa0036eea>] snd_component_add+0xfa/0x110 [snd]
[   12.590273]  [<ffffffffa01056ce>] snd_hda_codec_new+0x45d/0x68e [snd_hda_intel]
[   12.590290]  [<ffffffffa01046bc>] azx_probe+0x4dc/0xdb0 [snd_hda_intel]
[   12.590306]  [<ffffffffa00e1490>] ? azx_send_cmd+0x0/0x170 [snd_hda_intel]
[   12.590321]  [<ffffffffa00e1600>] ? azx_get_response+0x0/0x2a0 [snd_hda_intel]
[   12.590336]  [<ffffffffa00e1080>] ? azx_power_notify+0x0/0x80 [snd_hda_intel]
[   12.590341]  [<ffffffff81201048>] pci_device_probe+0xd8/0x130
[   12.590346]  [<ffffffff8112e75e>] ? sysfs_create_link+0xe/0x10
[   12.590351]  [<ffffffff812c1fe2>] driver_probe_device+0xa2/0x1e0
[   12.590355]  [<ffffffff812c21ab>] __driver_attach+0x8b/0x90
[   12.590358]  [<ffffffff812c2120>] ? __driver_attach+0x0/0x90
[   12.590361]  [<ffffffff812c177b>] bus_for_each_dev+0x6b/0xa0
[   12.590365]  [<ffffffff812c1e2c>] driver_attach+0x1c/0x20
[   12.590368]  [<ffffffff812c0f98>] bus_add_driver+0x208/0x280
[   12.590372]  [<ffffffff812c2393>] driver_register+0x73/0x170
[   12.590376]  [<ffffffff8120131d>] __pci_register_driver+0x7d/0xd0
[   12.590388]  [<ffffffffa016d000>] ? alsa_card_azx_init+0x0/0x20 [snd_hda_intel]
[   12.590400]  [<ffffffffa016d01e>] alsa_card_azx_init+0x1e/0x20 [snd_hda_intel]
[   12.590404]  [<ffffffff81009040>] _stext+0x40/0x1a0
[   12.590407]  [<ffffffff8106e239>] ? trace_hardirqs_on_caller+0x129/0x180
[   12.590413]  [<ffffffff8107bf1f>] sys_init_module+0xaf/0x1e0
[   12.590416]  [<ffffffff8100c60a>] system_call_fastpath+0x16/0x1b
[   12.590418] 
[   12.590421] ---[ end trace 5ac18ecbb660a8b0 ]---

Cheers,
Fengguang
