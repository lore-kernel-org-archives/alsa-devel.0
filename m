From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 00/11] Add ZxR support + bugfixes
Date: Mon, 1 Oct 2018 23:03:28 +0900
Message-ID: <f6aa819a-3db4-e457-8856-ad2debc85947@sakamocchi.jp>
References: <1538276607-30234-1-git-send-email-conmanx360@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1538276607-30234-1-git-send-email-conmanx360@gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Connor McAdams <conmanx360@gmail.com>
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Alastair Bridgewater <alastair.bridgewater@gmail.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Hi,

On Sep 30 2018 12:03, Connor McAdams wrote:
> This patch series adds support for the Sound Blaster ZxR, as well as a
> few bug fixes. This should be the last ca0132 based Creative card that
> needed support to be added.
> 
> Also, I did check to make sure each patch compiles properly this time,
> but you can check yourself just to be sure. :)
> 
> Connor McAdams (11):
>    ALSA: hda/ca0132 - Fix AE-5 control type
>    ALSA: hda/ca0132 - Fix surround sound with output effects
>    ALSA: hda/ca0132 - Add ZxR quirks + new quirk check function
>    ALSA: hda/ca0132 - Add ZxR pincfg
>    ALSA: hda/ca0132 - Add DBpro hda_codec_ops
>    ALSA: hda/ca0132 - Add ZxR init commands
>    ALSA: hda/ca0132 - Add ZxR DSP post-download commands
>    ALSA: hda/ca0132 - Add ZxR input/output select commands
>    ALSA: hda/ca0132 - Remove input select enum for ZxR
>    ALSA: hda/ca0132 - Add ZxR 600 ohm gain control
>    ALSA: hda/ca0132 - Add ZxR exit commands
> 
>   sound/pci/hda/patch_ca0132.c | 369 ++++++++++++++++++++++++++++++++++++++++---
>   1 file changed, 345 insertions(+), 24 deletions(-)

I reviewed the above patches and they looks good to be merged to
upstream.

Reviewed-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>

I've already point some nitpickings but they can be solved
after merging them till next merge window.


Thanks

Takashi Sakamoto
