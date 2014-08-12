From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: Re: [PATCH] sound: pci: es1968: use pci_device_id
Date: Tue, 12 Aug 2014 18:11:19 +0530
Message-ID: <CADVatmObZZ+DkFsuyagD05f=LhobVP4u-7gC9LXr_UcDgV_TOg@mail.gmail.com>
References: <1407845740-3524-1-git-send-email-sudipm.mukherjee@gmail.com>
	<s5hbnrpgah7.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5hbnrpgah7.wl%tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: perex@perex.cz, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Tue, Aug 12, 2014 at 5:56 PM, Takashi Iwai <tiwai@suse.de> wrote:
> At Tue, 12 Aug 2014 17:45:40 +0530,
> Sudip Mukherjee wrote:
>>
>> Uses the struct pci_device_id instead of the depreciated macro DEFINE_PCI_DEVICE_TABLE.
>
> If we do this, better to apply to all sound/pci/* at once after
> 3.17-rc1 is released.
>
>
> thanks,
>
> Takashi

If we apply to all sound.pci/* , then it will be 69 replacements in
one go. If you all want that way , then will do it after 3.17-rc1 is
releases .

Thanks
Sudip
