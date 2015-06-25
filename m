From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: [PATCH] surround41/50.conf: Use chmap syntax for
	better flexibility
Date: Thu, 25 Jun 2015 10:19:23 +0200
Message-ID: <558BB98B.8040403@canonical.com>
References: <1434617279-10178-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 8F937260435
 for <alsa-devel@alsa-project.org>; Thu, 25 Jun 2015 10:19:20 +0200 (CEST)
In-Reply-To: <1434617279-10178-1-git-send-email-david.henningsson@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This alsa-lib patch seems to have been forgotten? Or at least not pushed 
out.

On 2015-06-18 10:47, David Henningsson wrote:
> In case the hardware only supports a specific channel map,
> this change would allow surround41/50 to select the correct
> channel map and channel count in this situation.
>
> Signed-off-by: David Henningsson <david.henningsson@canonical.com>
> ---
>   src/conf/pcm/surround41.conf | 11 +++++------
>   src/conf/pcm/surround50.conf | 11 +++++------
>   2 files changed, 10 insertions(+), 12 deletions(-)
>
> diff --git a/src/conf/pcm/surround41.conf b/src/conf/pcm/surround41.conf
> index 10e486e..2f82381 100644
> --- a/src/conf/pcm/surround41.conf
> +++ b/src/conf/pcm/surround41.conf
> @@ -53,12 +53,11 @@ pcm.!surround41 {
>   			]
>   		}
>   	}
> -	slave.channels 6
> -	ttable.0.0 1
> -	ttable.1.1 1
> -	ttable.2.2 1
> -	ttable.3.3 1
> -	ttable.4.5 1
> +	ttable.0.FL 1
> +	ttable.1.FR 1
> +	ttable.2.RL 1
> +	ttable.3.RR 1
> +	ttable.4.LFE 1
>   	hint {
>   		description "4.1 Surround output to Front, Rear and Subwoofer speakers"
>   		device $DEV
> diff --git a/src/conf/pcm/surround50.conf b/src/conf/pcm/surround50.conf
> index 7b7b17e..dc95c17 100644
> --- a/src/conf/pcm/surround50.conf
> +++ b/src/conf/pcm/surround50.conf
> @@ -53,12 +53,11 @@ pcm.!surround50 {
>   			]
>   		}
>   	}
> -	slave.channels 6
> -	ttable.0.0 1
> -	ttable.1.1 1
> -	ttable.2.2 1
> -	ttable.3.3 1
> -	ttable.4.4 1
> +	ttable.0.FL 1
> +	ttable.1.FR 1
> +	ttable.2.RL 1
> +	ttable.3.RR 1
> +	ttable.4.FC 1
>   	hint {
>   		description "5.0 Surround output to Front, Center and Rear speakers"
>   		device $DEV
>

-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic
