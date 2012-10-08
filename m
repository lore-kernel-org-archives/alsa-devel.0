From: Daniel J Blueman <daniel@quora.org>
Subject: Re: [3.6-rc7] switcheroo race with Intel HDA...
Date: Tue, 9 Oct 2012 00:34:09 +0800
Message-ID: <CAMVG2ss7hmJAEt-vEsNBmTVDWMYCPyPo0UC34DKDBnr7t5gn8g@mail.gmail.com>
References: <CAMVG2st1-3kz-KRrm-zXZOGw8=QnyYbB3n5e8Z36xAbmD4b5RQ@mail.gmail.com>
	<s5hvceli0ht.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5hvceli0ht.wl%tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Dave Airlie <airlied@redhat.com>, Linux Kernel <linux-kernel@vger.kernel.org>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 8 October 2012 20:58, Takashi Iwai <tiwai@suse.de> wrote:
> At Tue, 25 Sep 2012 13:20:05 +0800,
> Daniel J Blueman wrote:
>> On my Macbook with a discrete Nvidia GPU, there is a race between
>> selecting the integrated GPU and putting the discrete GPU into D3 [1],
>> reliably causing a kernel oops [2].
>>
>> Introducing a delay of ~1s between the calls prevents this. When the
>> second 'OFF' write path executes, it looks like struct azx at
>> card->private_data hasn't yet been allocated yet [3], so there is
>> likely some locking missing.
>
> It's rather pci_get_drvdata() returning NULL (i.e. card is NULL, thus
> card->private_data causes Oops).  Could you check the patch like below
> and see whether you get a kernel warning (but no Oops) or the problem
> gets fixed by shifting the assignment of pci drvdata?
[...]

Good patching. Calling pci_set_drvdata later prevents the oops in HDA,
though we see unexpected 0x0 responses in the response ring buffer
[1], which we don't see when there's a >~1.5s delay between IGD and
OFF.

Thanks,
  Daniel

--- [1]

snd_hda_intel 0000:00:1b.0: enabling device (0000 -> 0002)
snd_hda_intel 0000:00:1b.0: irq 55 for MSI/MSI-X
vga_switcheroo: enabled
input: HDA Intel PCH Headphone as
/devices/pci0000:00/0000:00:1b.0/sound/card0/input11
snd_hda_intel 0000:01:00.1: enabling device (0000 -> 0002)
{echo IGD >/sys/kernel/debug/vgaswitcheroo/switch}
{echo OFF >/sys/kernel/debug/vgaswitcheroo/switch}
hda_intel: Disabling MSI
hda-intel: 0000:01:00.1: Handle VGA-switcheroo audio client
hda-intel: Disabling 0000:01:00.1 via VGA-switcheroo
VGA switcheroo: switched nouveau off
[drm] nouveau 0000:01:00.0: Disabling display...
[drm] nouveau 0000:01:00.0: Disabling fbcon...
[drm] nouveau 0000:01:00.0: Unpinning framebuffer(s)...
[drm] nouveau 0000:01:00.0: Evicting buffers...
[drm] nouveau 0000:01:00.0: Idling channels...
[drm] nouveau 0000:01:00.0: Suspending GPU objects...
[drm] nouveau 0000:01:00.0: And we're gone!
hda-intel: spurious response 0x0:0x0, last cmd=0x1f0004
{repeats 220 times}
hda-intel: spurious response 0x0:0x0, last cmd=0x1f0004
HDMI: failed to get afg sub nodes
-- 
Daniel J Blueman
