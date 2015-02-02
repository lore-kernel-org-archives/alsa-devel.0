From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 03/14] ALSA: Add a helper to initialize
	device
Date: Mon, 02 Feb 2015 14:31:40 +0100
Message-ID: <54CF7C3C.6020100@metafoo.de>
References: <1422872678-4815-1-git-send-email-tiwai@suse.de>
 <1422872678-4815-4-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-232.synserver.de (smtp-out-232.synserver.de
 [212.40.185.232])
 by alsa0.perex.cz (Postfix) with ESMTP id 30F7C260614
 for <alsa-devel@alsa-project.org>; Mon,  2 Feb 2015 14:31:39 +0100 (CET)
In-Reply-To: <1422872678-4815-4-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 02/02/2015 11:24 AM, Takashi Iwai wrote:
> diff --git a/sound/core/init.c b/sound/core/init.c
> index 074875d68c15..2f730efe97b6 100644
> --- a/sound/core/init.c
> +++ b/sound/core/init.c
> @@ -157,6 +157,25 @@ static int get_slot_from_bitmask(int mask, int (*check)(struct module *, int),
>   	return mask; /* unchanged */
>   }
>
> +static void default_release(struct device *dev)
> +{
> +}

A empty release callback is pretty much always wrong and typically causes 
use-after-free bugs. It might be correct in this case, but there should at 
least be a comment explaining why it is correct. And on the long run things 
should probably be re-factored to do all memory freeing in a subdevice 
specific release function.

- Lars
