From: Gert Robben <lkml@gert.robben.nu>
Subject: Re: [alsa-devel] PROBLEM: snd-au8830: dead after software suspend
Date: Mon, 06 Aug 2007 18:15:27 +0200
Message-ID: <46B7491F.2020105@gert.robben.nu>
References: <46B3A4F5.2000708@gert.robben.nu>	<46B3C44D.7020801@gert.robben.nu>	<46B3CDA0.90804@gert.robben.nu> <s5h7io8er3n.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1762444AbXHFQPk@vger.kernel.org>
In-Reply-To: <s5h7io8er3n.wl%tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, mjander@embedded.cl
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> The below is an untested fix.  Give it a try.
With the patch, things seem to be much better (but I'm no expert).

The things remaining seem to be:
- sound can't be heard
- MPlayer gives an error, instead of doing nothing.

I've enabled debugging, and did the following, without and with the patch:
boot, mplayer start+pause, suspend, resume, mplayer unpause+exit+start+exit,
rmmod.

Below is an edited diff of the dmesges (printk's begin with a "k"),
without and with the patch, with my comments added. I hope this is 
enough info. If you need the full dmesges, let me know.

Anyway, thanks for you work :)

Gert Robben

--- without patch
+++ with patch
  initial boot:
  k ACPI: PCI Interrupt 0000:00:11.0[A] -> GSI 19 (level, low) -> IRQ 19
  k Vortex: init.... <3>ALSA sound/core/control.c:331: control 3:0:0:Play
  k back PCM advanced processing:0 is already present
  k done.
-k PCI driver au8830 lacks driver specific resume support.
  during suspend:
+k Vortex: shutdown...<6>done.
+k ACPI: PCI interrupt for device 0000:00:11.0 disabled
  during resume:
+k PM: Writing back config space on device 0000:00:11.0 at offset 1 (was
  k  2900007, writing 2900003)
  k ACPI: PCI Interrupt 0000:00:11.0[A] -> GSI 19 (level, low) -> IRQ 19
+k Vortex: init.... <6>ata1.00: configured for UDMA/33
+k ALSA sound/core/control.c:331: control 3:0:0:Playback PCM advanced pr
  k ocessing:0 is already present
+k done.
  mplayer unpause:
+- gives mplayer error: alsa-lib: pcm_hw.c:612(snd_pcm_hw_pause) SNDRV_P
    CM_IOCTL_PAUSE failed: File descriptor in bad state
  - nothing else happens
  mplayer exit:
+k vortex_adb_delroutes: route not found! 0x40
+k vortex_adb_delroutes: route not found! 0x2060
  k src alarm
+k vortex_adb_delroutes: route not found! 0x41
+k vortex_adb_delroutes: route not found! 0x2161
  k src alarm
  mplayer start:
-- nothing happens
+- mplayer seems to play fine, but no sound can be heard
  rmmod:
-k vortex: ac97 codec stuck busy
-k vortex: ac97 codec stuck busy
-k vortex: ac97 codec stuck busy
-k vortex: ac97 codec stuck busy
  k analog.c: 0 out of 0 reads (0%) on pci0000:00:11.0/gameport0 failed
-k Vortex: shutdown...<3>mix ALARM 0
-k mix ALARM 0
-k mix ALARM 0
-k mix ALARM 0
-k mix ALARM 0
-k mix ALARM 0
-k done.
+k Vortex: shutdown...<6>done.
  k ACPI: PCI interrupt for device 0000:00:11.0 disabled
