From: Quentin Lambert <lambert.quentin@gmail.com>
Subject: Re: [PATCH] ALSA: aoa: convert bus code to use dev_groups
Date: Thu, 28 May 2015 15:59:57 +0200
Message-ID: <55671F5D.6060807@gmail.com>
References: <1432817307-28380-1-git-send-email-lambert.quentin@gmail.com> <s5hwpzs7qrz.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <s5hwpzs7qrz.wl-tiwai@suse.de>
Sender: kernel-janitors-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Johannes Berg <johannes@sipsolutions.net>, Jaroslav Kysela <perex@perex.cz>, linuxppc-dev@lists.ozlabs.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: alsa-devel@alsa-project.org



On 28/05/2015 15:52, Takashi Iwai wrote:
> At Thu, 28 May 2015 14:48:27 +0200,
> Quentin Lambert wrote:
>> You should use dev_groups instead of the dev_attrs field of struct
>> bus_type. This converts the MDIO bus code to use the correct field.
>>
>> These modifications were made using Coccinelle.
>>
>> Signed-off-by: Quentin Lambert <lambert.quentin@gmail.com>
> What's wrong with dev_attrs?
> (Not offending, I'm just curious where the preference for dev_groups
>   is referred...)

This patch is based on commit 4192c74940e23da727eb02b7b4ee779dde2f670,
its message indicates that dev_attrs is going away.

Quentin

