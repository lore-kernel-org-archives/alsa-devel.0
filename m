From: Jorge <jorge.sanjuan@codethink.co.uk>
Subject: Re: [PATCH v4 4/4] ALSA: usb-audio: UAC3: Parse Input Terminal number
 of channels.
Date: Mon, 14 May 2018 09:54:25 +0100
Message-ID: <e2088eb5-381f-3ad4-8e59-381a729346d0@codethink.co.uk>
References: <20180420170327.31569-1-jorge.sanjuan@codethink.co.uk>
 <20180511152537.32267-1-jorge.sanjuan@codethink.co.uk>
 <20180511152537.32267-5-jorge.sanjuan@codethink.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180511152537.32267-5-jorge.sanjuan@codethink.co.uk>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: tiwai@suse.com
Cc: alsa-devel@alsa-project.org, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, ruslan.bilovol@gmail.com
List-Id: alsa-devel@alsa-project.org



On 11/05/18 16:25, Jorge Sanjuan wrote:
> Obtain the number of channels for the Input Terminal from the
> Logical Cluster Descriptor. This achieves a useful minimal parsing
> of this unit so it can be used in other units in the topology.
> 
> Signed-off-by: Jorge Sanjuan <jorge.sanjuan@codethink.co.uk>
> ---
>   sound/usb/mixer.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
> index 431f3c319839..19b25fbc7437 100644
> --- a/sound/usb/mixer.c
> +++ b/sound/usb/mixer.c
> @@ -903,9 +903,9 @@ static int check_input_term(struct mixer_build *state, int id,
>   				 * recursion calls */
>   				term->id = id;
>   				term->type = le16_to_cpu(d->wTerminalType);
> +				term->channels = get_cluster_channels_v3(state, d->wClusterDescrID);


Sorry about this. I just spotted that I should have used the helper 
function I added to access d->wClusterDescrID 
`uac3_mixer_unit_wClusterDescrID`.

I got the sparse warning for the endianess and realized that. I'll 
resend this one patch.

>   
> -				/* REVISIT: UAC3 IT doesn't have channels/cfg */
> -				term->channels = 0;
> +				/* REVISIT: UAC3 IT doesn't have channels cfg */
>   				term->chconfig = 0;
>   
>   				term->name = le16_to_cpu(d->wTerminalDescrStr);
> 
