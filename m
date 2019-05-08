From: "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
Subject: Re: [PATCH 01/16] lib: fix match_string() helper on -1
	array size
Date: Wed, 8 May 2019 11:31:15 +0000
Message-ID: <c8cfa5dbdfc0b0665d1b48f37ba57c3ec1233197.camel__22815.8730011032$1557315151$gmane$org@analog.com>
References: <20190508112842.11654-1-alexandru.ardelean@analog.com>
 <20190508112842.11654-2-alexandru.ardelean@analog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from NAM01-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr740075.outbound.protection.outlook.com [40.107.74.75])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 471C8F80796
 for <alsa-devel@alsa-project.org>; Wed,  8 May 2019 13:31:23 +0200 (CEST)
In-Reply-To: <20190508112842.11654-2-alexandru.ardelean@analog.com>
Content-Language: en-US
Content-ID: <BE083E2328EDB84B98DBA67ED168014A@analog.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>, "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-security-module@vger.kernel.org" <linux-security-module@vger.kernel.org>, "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>, "linux-integrity@vger.kernel.org" <linux-integrity@vger.kern>
Cc: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

On Wed, 2019-05-08 at 14:28 +0300, Alexandru Ardelean wrote:
> The documentation the `_match_string()` helper mentions that `n`
> should be:
>  * @n: number of strings in the array or -1 for NULL terminated arrays
> 
> The behavior of the function is different, in the sense that it exits on
> the first NULL element in the array, regardless of whether `n` is -1 or a
> positive number.
> 
> This patch changes the behavior, to exit the loop when a NULL element is
> found and n == -1. Essentially, this aligns the behavior with the
> doc-string.
> 
> There are currently many users of `match_string()`, and so, in order to
> go
> through them, the next patches in the series will focus on doing some
> cosmetic changes, which are aimed at grouping the users of
> `match_string()`.
> 

This is the duplicate & should be dropped.
Sorry for this.

> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> ---
>  lib/string.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/lib/string.c b/lib/string.c
> index 3ab861c1a857..76edb7bf76cb 100644
> --- a/lib/string.c
> +++ b/lib/string.c
> @@ -648,8 +648,11 @@ int match_string(const char * const *array, size_t
> n, const char *string)
>  
>  	for (index = 0; index < n; index++) {
>  		item = array[index];
> -		if (!item)
> +		if (!item) {
> +			if (n != (size_t)-1)
> +				continue;
>  			break;
> +		}
>  		if (!strcmp(item, string))
>  			return index;
>  	}
