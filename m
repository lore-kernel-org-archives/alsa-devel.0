From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [alsa-devel] [PATCH] ALSA: hda - Add two more machines to the
 power_save_blacklist
Date: Mon, 8 Apr 2019 09:23:29 +0200
Message-ID: <163657bc-535a-c528-200d-cd3e84894d24@perex.cz>
References: <20190408013535.6423-1-hui.wang@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20190408013535.6423-1-hui.wang@canonical.com>
Content-Language: en-US
Sender: stable-owner@vger.kernel.org
To: Hui Wang <hui.wang@canonical.com>, alsa-devel@alsa-project.org, tiwai@suse.de
Cc: stable@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Dne 08. 04. 19 v 3:35 Hui Wang napsal(a):
> Recently we set CONFIG_SND_HDA_POWER_SAVE_DEFAULT to 1 when
> configuring the kernel, then two machines were reported to have noise
> after installing the new kernel. Put them in the blacklist, the
> noise disappears.

Please, place the new entries sorted using the PCI IDs...

					Jaroslav Kysela

> 
> https://bugs.launchpad.net/bugs/1821663
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Hui Wang <hui.wang@canonical.com>
> ---
>  sound/pci/hda/hda_intel.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
> index ece256a3b48f..f62fb8b16c49 100644
> --- a/sound/pci/hda/hda_intel.c
> +++ b/sound/pci/hda/hda_intel.c
> @@ -2150,6 +2150,9 @@ static struct snd_pci_quirk power_save_blacklist[] = {
>  	SND_PCI_QUIRK(0x17aa, 0x367b, "Lenovo IdeaCentre B550", 0),
>  	/* https://bugzilla.redhat.com/show_bug.cgi?id=1572975 */
>  	SND_PCI_QUIRK(0x17aa, 0x36a7, "Lenovo C50 All in one", 0),
> +	/* https://bugs.launchpad.net/bugs/1821663 */
> +	SND_PCI_QUIRK(0x1631, 0xe017, "Packard Bell NEC IMEDIA 5204", 0),
> +	SND_PCI_QUIRK(0x8086, 0x2064, "Intel Laptop 8086:2064", 0),
>  	{}
>  };
>  #endif /* CONFIG_PM */
> 


-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
