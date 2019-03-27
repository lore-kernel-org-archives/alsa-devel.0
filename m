From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [PATCH alsa-plugins] configure: Fix unexpanded
 ALSA_DATA_DIR
Date: Wed, 27 Mar 2019 13:54:44 +0100
Message-ID: <a93a7209-2b77-1a31-7aea-8bee2f5d8049@perex.cz>
References: <20190327114204.26304-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 22AFAF801D8
 for <alsa-devel@alsa-project.org>; Wed, 27 Mar 2019 13:54:46 +0100 (CET)
In-Reply-To: <20190327114204.26304-1-tiwai@suse.de>
Content-Language: en-US
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Dne 27. 03. 19 v 12:42 Takashi Iwai napsal(a):
> When no --with-alsadatadir is given, configure scripts takes
> $datadir/alsa as the default location, while it's expanded to
> $prefix/data/alsa.  Although ALSA_DATA_DIR is set via
> AC_DEFINE_UNQUOTED(), this expands only $alsadatadir itself and not
> about the $prefix in the content.  For resolving this, we need to do
> eval twice.
> 
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
>  configure.ac | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/configure.ac b/configure.ac
> index 1be4a70c803c..5b131e704c2f 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -211,7 +211,7 @@ if test -z "$alsadatadir"; then
>      eval dir="$datadir"
>      case "$dir" in
>      /*) ;;
> -    *) dir="$dir"
> +    *) eval dir="$dir"
>      esac
>      alsadatadir="$dir/alsa"
>  fi
> 

Acked-by: Jaroslav Kysela <perex@perex.cz>

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
