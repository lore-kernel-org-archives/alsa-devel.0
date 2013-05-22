From: "Austin, Brian" <Brian.Austin@cirrus.com>
Subject: Re: [PATCH 0/4] CS42L52 fixes.
Date: Wed, 22 May 2013 17:36:23 +0000
Message-ID: <5F66E62A-200A-4A6D-A231-4E2889D19CB3@cirrus.com>
References: <1369243167-28700-1-git-send-email-nschichan@freebox.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe002.messaging.microsoft.com [65.55.88.12])
 by alsa0.perex.cz (Postfix) with ESMTP id 75076260899
 for <alsa-devel@alsa-project.org>; Wed, 22 May 2013 19:36:38 +0200 (CEST)
In-Reply-To: <1369243167-28700-1-git-send-email-nschichan@freebox.fr>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Nicolas Schichan <nschichan@freebox.fr>, Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Georgi Vlaev <joe@nucleusys.com>
List-Id: alsa-devel@alsa-project.org



On May 22, 2013, at 7:19, "Nicolas Schichan" <nschichan@freebox.fr> wrote:

> Hi,
> 
> In the following emails, you will find the fixes I currently have for
> the CS42L52 driver.
> 
> The fixes are:
> 
> - Set both Master Volume A & B init value to 0x88 (otherwise left
>  channel and right channel master volume would not be the same after
>  init).
> 
> - Use IFACE_CTL2 register for Microphone Bias enum (IFACE_CTL1 is
>  clearly not controling microphone bias according to the datasheet).
> 
> - Various controls would use a bogus shift value, resulting in only the
>  high order bits being updated when changing them.
> 
> - The wrong mask was used when muting/unmuting the codec, resutling in
>  the wrong part of the PB_CTL1 register being cleared, especially the
>  headphone analog gain part.
> 
> All those patches are against the latest linus tree.
> 
> Regards,
> 
> -- 
> Nicolas Schichan
> 
> 
Whole series
Acked-by: Brian Austin <brian.austin@cirrus.com>

Thanks
