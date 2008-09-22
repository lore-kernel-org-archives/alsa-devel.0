From: "Wei Ni" <wni@nvidia.com>
Subject: Re: [PATCH] add the nvidia HDMI codec
	driverfor	MCP77/79
Date: Mon, 22 Sep 2008 14:33:58 +0800
Message-ID: <15F501D1A78BD343BE8F4D8DB854566B3332408C@hkemmail01.nvidia.com>
References: <200809031558156739794@gmail.com><s5hhc8xpq6z.wl%tiwai@suse.de><15F501D1A78BD343BE8F4D8DB854566B31F8F744@hkemmail01.nvidia.com><s5h4p4xph6x.wl%tiwai@suse.de><48BE7EE4.8020800@insite.cz>
	<s5h63ouvpfc.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hqemgate04.nvidia.com (hqemgate04.nvidia.com [216.228.112.152])
	by alsa0.perex.cz (Postfix) with ESMTP id 78E61243D4
	for <alsa-devel@alsa-project.org>;
	Mon, 22 Sep 2008 08:34:12 +0200 (CEST)
Content-class: urn:content-classes:message
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, peerchen <peerchen@gmail.com>
Cc: Peer Chen <pchen@nvidia.com>, alsa-devel <alsa-devel@alsa-project.org>, linux-kernel <linux-kernel@vger.kernel.org>, Pavel Hofman <pavel.hofman@insite.cz>, akpm <akpm@linux-foundation.org>
List-Id: alsa-devel@alsa-project.org

Hi, Takashi

About the "long delay", it seemed that we need to add this "delay" to
fix some issue on our aza controller.
Because it related with the controller, not just codec, so I think this
flag should not be added in codec-initialization part.
I think it's better to add the flag in that place which I submitted.

Thanks

-----Original Message-----
From: Wei Ni 
Sent: Friday, September 19, 2008 12:43 PM
To: 'Takashi Iwai'; peerchen
Cc: Pavel Hofman; Peer Chen; alsa-devel; linux-kernel; akpm
Subject: RE: [alsa-devel] [PATCH] add the nvidia HDMI codec driverfor
MCP77/79

Thanks for your reply.

About the "long delay", we had some problems on reading RIRB buffer when
testing this driver, so we add this "delay"
We will try to find a best way to fix this issue.

And we didn't familiar with git, we will research it more such as
"rebase" and then submit the patch file again.

Thanks

-----Original Message-----
From: Takashi Iwai [mailto:tiwai@suse.de] 
Sent: Wednesday, September 17, 2008 10:05 PM
To: peerchen
Cc: Wei Ni; Pavel Hofman; Peer Chen; alsa-devel; linux-kernel; akpm
Subject: Re: [alsa-devel] [PATCH] add the nvidia HDMI codec driverfor
MCP77/79

At Wed, 17 Sep 2008 17:00:04 +0800,
peerchen wrote:
> 
> new patch base on git tree.
> 
> Signed-off-by: Wei Ni <wni@nvidia.com>
> Signed-off-by: Peer Chen <peerchen@gmail.com>

Thanks!

But, the patch looks like no "rebase".  You secretly added a new
function call that wasn't in your previous patch, namely...

> diff -uprN -X linux-2.6-tiwai-sound/Documentation/dontdiff
linux-2.6-tiwai-sound/sound/pci/hda/hda_intel.c
linux-2.6-tiwai-sound-niwei/sound/pci/hda/hda_intel.c
> --- linux-2.6-tiwai-sound/sound/pci/hda/hda_intel.c	2008-09-10
17:40:52.000000000 +0800
> +++ linux-2.6-tiwai-sound-niwei/sound/pci/hda/hda_intel.c
2008-09-10 17:49:31.000000000 +0800
> @@ -1220,6 +1220,9 @@ static int __devinit azx_codec_create(st
>  	if (err < 0)
>  		return err;
>  
> +	if (chip->driver_type == AZX_DRIVER_NVIDIA)
> +		chip->bus->needs_damn_long_delay = 1;
> +

Do we really need this inevitably?  I don't think so -- otherwise I
would have far more bug reports.

This flag is the last resort and should be avoided as much as
possible.  This results in a significant slow down of suspend/resume
speed, for example.

If it's really needed with some devices and there is no other way to
fix it, add this flag rather in the codec-initialization part.

Also, if you resend a patch, please add the original patch description 
again.  This helps my patch work a lot indeed.


thanks,

Takashi
-----------------------------------------------------------------------------------
This email message is for the sole use of the intended recipient(s) and may contain
confidential information.  Any unauthorized review, use, disclosure or distribution
is prohibited.  If you are not the intended recipient, please contact the sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------------------
