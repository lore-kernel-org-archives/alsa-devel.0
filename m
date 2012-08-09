From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: [PATCH 2/2] ALSA: hda - Deferred probing with request_firmware_nowait()
Date: Thu, 09 Aug 2012 15:26:56 +0200
Message-ID: <5023BAA0.1080304@canonical.com>
References: <1344494723-6827-1-git-send-email-thierry.reding@avionic-design.de> <s5hhascft86.wl%tiwai@suse.de> <20120809070813.GA6979@avionic-0098.mockup.avionic-design.de> <s5hd330frn1.wl%tiwai@suse.de> <20120809073642.GA24695@avionic-0098.mockup.avionic-design.de> <s5h7gt8fr47.wl%tiwai@suse.de> <20120809080713.GC24808@avionic-0098.mockup.avionic-design.de> <s5hzk64earo.wl%tiwai@suse.de> <20120809103430.GA1560@avionic-0098.mockup.avionic-design.de> <s5hobmk2ql5.wl%tiwai@suse.de> <s5hd3302ovw.wl%tiwai@suse.de> <s5ha9y42os2.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5ha9y42os2.wl%tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Thierry Reding <thierry.reding@avionic-design.de>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On 08/09/2012 03:11 PM, Takashi Iwai wrote:

> @@ -3187,13 +3217,16 @@ static int __devinit azx_probe(struct pci_dev *pci,
>   	if (patch[dev] && *patch[dev]) {
>   		snd_printk(KERN_ERR SFX "Applying patch firmware '%s'\n",
>   			   patch[dev]);
> -		err = request_firmware(&chip->fw, patch[dev], &pci->dev);
> +		err = request_firmware_nowait(THIS_MODULE, true, patch[dev],
> +					      &pci->dev, GFP_KERNEL, card,
> +					      azx_firmware_cb);
>   		if (err < 0)
>   			goto out_free;
> +		chip->probe_deferred = 1;

I might be out on deep water here, but isn't this racy? Or is 
azx_firmware_cb somehow guaranteed not to execute before this function 
has exited?

>   	}
>   #endif /* CONFIG_SND_HDA_PATCH_LOADER */
>
> -	if (!chip->disabled) {
> +	if (!chip->disabled && !chip->probe_deferred) {
>   		err = azx_probe_continue(chip);
>   		if (err < 0)
>   			goto out_free;
>



-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic
