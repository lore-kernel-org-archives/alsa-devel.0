From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH] ASoC: intel: mfld: Make static string
 arrays 'const 'char * const []'
Date: Wed, 16 Nov 2016 08:21:59 +0530
Message-ID: <20161116025159.GP3000@localhost>
References: <1479242445-12069-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id 2FE71266C18
 for <alsa-devel@alsa-project.org>; Wed, 16 Nov 2016 03:42:35 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1479242445-12069-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Nov 15, 2016 at 09:40:45PM +0100, Lars-Peter Clausen wrote:
> const char * const [] is the preferred type for static string arrays since
> this states explicitly that the individual entries are not going to be
> changed. Due to limitations in the ASoC API it was not possible to use it
> for enum text arrays. Commit 87023ff74b23 ("ASoC: Declare const properly
> for enum texts") changed this, but most drivers still use 'const char
> * []' as the type for their enum text arrays.
> 
> Change these occurrences of 'static * const char * []' to 'static const
> char * const []'.
> 
> The conversion was done automatically using the following coccinelle
> semantic patch:
> // <smpl>
> @disable optional_qualifier@
> identifier s;
> @@
>  static
> -const char *
> +const char * const
>  s[] = ...;
> // </smpl>
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>

Acked-by: Vinod Koul <vinod.koul@intel.com>

-- 
~Vinod
