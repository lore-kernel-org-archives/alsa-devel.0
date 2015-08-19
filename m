From: Daniel Mack <daniel@zonque.org>
Subject: Re: [PATCH v2] ALSA: usb-audio: Recurse before saving
 terminal properties
Date: Wed, 19 Aug 2015 17:17:19 +0200
Message-ID: <55D49DFF.80403@zonque.org>
References: <1439969289-25357-1-git-send-email-julian@jusst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.zonque.de (svenfoo.org [82.94.215.22])
 by alsa0.perex.cz (Postfix) with ESMTP id 32534265054
 for <alsa-devel@alsa-project.org>; Wed, 19 Aug 2015 17:17:21 +0200 (CEST)
In-Reply-To: <1439969289-25357-1-git-send-email-julian@jusst.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Julian Scheel <julian@jusst.de>, tiwai@suse.de, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 08/19/2015 09:28 AM, Julian Scheel wrote:
> The input terminal parser recurses into the referenced clock entity to verify
> it is existant and thus the terminal descriptor is valid. The actual property
> values of the term instance which is initially parsed must not be overriden by
> the recursion. For this to work the term properties have to be assigned after
> recursing into the referenced clock entity descriptors.
> 
> Signed-off-by: Julian Scheel <julian@jusst.de>

Given your explanations, I believe this is the right thing to do.

Acked-by: Daniel Mack <daniel@zonque.org>


Thanks!


> ---
> Changes in v2:
> - Store term->id after recursion as well, as it gets overriden in the
>   recursion
> - Add comments explaining that the recursion is only for validation of the
>   descriptor validity
> ---
>  sound/usb/mixer.c | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)
> 
> diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
> index 81055d3..c50790c 100644
> --- a/sound/usb/mixer.c
> +++ b/sound/usb/mixer.c
> @@ -731,15 +731,21 @@ static int check_input_term(struct mixer_build *state, int id,
>  				term->name = d->iTerminal;
>  			} else { /* UAC_VERSION_2 */
>  				struct uac2_input_terminal_descriptor *d = p1;
> -				term->type = le16_to_cpu(d->wTerminalType);
> -				term->channels = d->bNrChannels;
> -				term->chconfig = le32_to_cpu(d->bmChannelConfig);
> -				term->name = d->iTerminal;
>  
> -				/* call recursively to get the clock selectors */
> +				/* call recursively to verify that the
> +				 * referenced clock entity is valid */
>  				err = check_input_term(state, d->bCSourceID, term);
>  				if (err < 0)
>  					return err;
> +
> +				/* save input term properties after recursion,
> +				 * to ensure they are not overriden by the
> +				 * recursion calls */
> +				term->id = id;
> +				term->type = le16_to_cpu(d->wTerminalType);
> +				term->channels = d->bNrChannels;
> +				term->chconfig = le32_to_cpu(d->bmChannelConfig);
> +				term->name = d->iTerminal;
>  			}
>  			return 0;
>  		case UAC_FEATURE_UNIT: {
> 
