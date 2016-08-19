From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH for 4.8] ASoC: omap-abe-twl6040: Correct
 dmic-codec device registration
Date: Fri, 19 Aug 2016 12:54:28 +0300
Message-ID: <d553cc24-f5b5-3b8a-d187-53fdf8d978ae@ti.com>
References: <20160819063424.16383-1-peter.ujfalusi@ti.com>
 <20160819085404.GI1041@n2100.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com [198.47.19.12])
 by alsa0.perex.cz (Postfix) with ESMTP id 7C2AB26621A
 for <alsa-devel@alsa-project.org>; Fri, 19 Aug 2016 11:54:34 +0200 (CEST)
In-Reply-To: <20160819085404.GI1041@n2100.armlinux.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: alsa-devel@alsa-project.org, Tony Lindgren <tony@atomide.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>, misael.lopez@ti.com
List-Id: alsa-devel@alsa-project.org

On 08/19/16 11:54, Russell King - ARM Linux wrote:
> On Fri, Aug 19, 2016 at 09:34:24AM +0300, Peter Ujfalusi wrote:
>> The dmic-codec was registered within the platform_driver's probe functio=
n,
>> which can cause deferred probe to run in loops as reported and analyzed =
by
>> Russell King.
>>
>> Use module_init/exit in the driver and handle the dmic-codec device
>> registration and removal at that level instead of the platform_driver
>> probe/remove.
>>
>> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
>> Reported-by: Russell King <linux@arm.linux.org.uk>
> =

> I think this address came from memory... it's certainly not the one that
> I'm using today. ;)

I'm really sorry. I have one txt file where I store e-mail addresses when I=
'm
lazy to look them up in my mailbox. txt updated.

Mark: can you fix Russell's e-mail addrress to:
linux@armlinux.org.uk

Or I can resend the patch.

> =

>> ---
> =

> This certainly fixes the problem:
> =

> VUSB: disabling
> mmcblk0: mmc0:0002 00000 972 MiB
> ALSA device list:
>  mmcblk0: p1 p2
>   No soundcards found.
> omap-abe-twl6040 sound: ASoC: CPU DAI (null) not registered
> omap-abe-twl6040 sound: snd_soc_register_card() failed: -517
> Waiting 2 sec before mounting root device...
> EXT4-fs (mmcblk0p2): mounting ext3 file system using the ext4 subsystem
> EXT4-fs (mmcblk0p2): warning: maximal mount count reached, running e2fsck=
 is recommended
> =

> and allows booting to continue.  Thanks.
> =

> Tested-by: Russell King <rmk+kernel@armlinux.org.uk>
> =



-- =

P=E9ter
