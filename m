From: Antonio Ospite <ao2@ao2.it>
Subject: Re: [alsa-lib][PATCH] ucm: docs: typeset lists of
 identifiers explicitly
Date: Wed, 21 Sep 2016 16:05:18 +0200
Message-ID: <20160921160518.df74ee52de4b097cb6fc13e2@ao2.it>
References: <20160921135245.8668-1-ao2@ao2.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ao2.it (ao2.it [92.243.12.208])
 by alsa0.perex.cz (Postfix) with ESMTP id E2B5F2606F7
 for <alsa-devel@alsa-project.org>; Wed, 21 Sep 2016 16:05:20 +0200 (CEST)
In-Reply-To: <20160921135245.8668-1-ao2@ao2.it>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Antonio Ospite <ao2@ao2.it>
List-Id: alsa-devel@alsa-project.org

On Wed, 21 Sep 2016 15:52:45 +0200
Antonio Ospite <ao2@ao2.it> wrote:

> Doxygen doesn't preserve formatting that relies only on indentation,
> typeset lists of identifiers explicitly.
> 
[...]
> ---
>  include/use-case.h | 57 +++++++++++++++++++++++++++---------------------------
>  1 file changed, 29 insertions(+), 28 deletions(-)
> 
> diff --git a/include/use-case.h b/include/use-case.h
> index 9aac6e2..1ebd945 100644
> --- a/include/use-case.h
> +++ b/include/use-case.h
[...]
> @@ -346,19 +347,19 @@ int snd_use_case_geti(snd_use_case_mgr_t *uc_mgr,
[...]
> + *   = _dismod			- disable given modifier = value

Here there should be a '-' in place of the first '=', I only noticed
after sending.

I'll wait some days before sending a v2, or feel free to amend the patch
locally if that's not too much burden.

Thanks,
   Antonio

-- 
Antonio Ospite
https://ao2.it
https://twitter.com/ao2it

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?
