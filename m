From: Gou Zhuang <gouzhuang@bigfoot.com>
Subject: Re: Oops on resume, X crashes
Date: Fri, 24 Oct 2003 13:45:53 +0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3F98BC91.3090606@bigfoot.com>
References: <3F939367.80804@bigfoot.com>	<s5h4qy4dkx5.wl@alsa2.suse.de>	<3F94F094.80109@Sun.COM>	<s5hr816de2j.wl@alsa2.suse.de>	<3F979B68.9030006@bigfoot.com> <s5hptgn96lc.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hptgn96lc.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Gou Zhuang <gouzhuang@bigfoot.com>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> At Thu, 23 Oct 2003 17:12:08 +0800,
> Gou Zhuang wrote:
> 
>>I turned on OSS_DEBUG in pcm_oss.c. I did not start X this time, I only started artsd from
>>console to reproduce the oops. Below is the messages after resume, my comments are marked
>>with <<<---------
>>
>>-------------------------
>>MYDEBUG intel8x0.c:2141: Entering intel8x0_suspend()
>>MYDEBUG intel8x0.c:2149: Call snd_pcm_suspend_all() on Intel 82801CA-ICH3
>>MYDEBUG intel8x0.c:2149: Call snd_pcm_suspend_all() on Intel 82801CA-ICH3 - MIC ADC
>>MYDEBUG intel8x0.c:2152: Call snd_power_change_state(card, SNDRV_CTL_POWER_D3hot)
>>MYDEBUG intel8x0.c:2154: Return from snd_power_change_state()
>>pcm_oss: ioctl = 0x8010500c
>>pcm_oss: space: bytes = 7168, fragments = 7, fragstotal = 7, fragsize = 1024
>>pcm_oss: write: recovering from SUSPEND
>>ALSA pcm_oss.c:552: snd_pcm_oss_prepare: SNDRV_PCM_IOCTL_PREPARE failed
>>pcm_oss: write 1024 bytes (wrote -11 bytes)  <<<----------- IT SEEMS THE WRITE FAILED!
> 
> 
> that's ok, because it's opened with non-block mode.
> 
> 
>>MYDEBUG intel8x0.c:2162: Entering intel8x0_resume()
>>MYDEBUG intel8x0.c:2167: Call pci_enable_device(chip->pci)
>>PCI: Found IRQ 11 for device 00:1f.5
>>PCI: Sharing IRQ 11 with 00:1f.6
>>MYDEBUG intel8x0.c:2169: Call pci_set_master(chip->pci)
>>PCI: Setting latency timer of device 00:1f.5 to 64
>>MYDEBUG intel8x0.c:2067: Entering snd_intel8x0_chip_init()
>>MYDEBUG ../../alsa-kernel/pci/ac97/ac97_codec.c:2148: Entering snd_ac97_resume()
>>MYDEBUG ../../alsa-kernel/pci/ac97/ac97_codec.c:2148: Entering snd_ac97_resume()
>>MYDEBUG intel8x0.c:2177: Call snd_power_change_state(card, SNDRV_CTL_POWER_D0)
> 
> 
> ok, i think i found a bug.
> please try the attached patch.
> 
> 
> Takashi

I applied the patch, the oops went away :) But I still get a lot of
"ALSA pcm_oss.c:552: snd_pcm_oss_prepare: SNDRV_PCM_IOCTL_PREPARE failed".

And the artsd crashed after resume with the following errmsg:

Sound Server fatal error:
AudioSubSystem::handleIO: write failed
len = 16, can_write = 24, errno = 4 (interrupted system call)

Do you have any clue on this?

gouzhuang



-------------------------------------------------------
This SF.net email is sponsored by: The SF.net Donation Program.
Do you like what SourceForge.net is doing for the Open
Source Community?  Make a contribution, and help us add new
features and functionality. Click here: http://sourceforge.net/donate/
