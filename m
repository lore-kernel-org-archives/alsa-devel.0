From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH 1/1] ASoC: Intel: Atom: add a missing star in a memcpy
 call
Date: Sun, 28 Aug 2016 11:17:11 -0700
Message-ID: <1472408231.26978.98.camel@perches.com>
References: <20160828173945.27721-1-nicolas.iooss_linux@m4x.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160828173945.27721-1-nicolas.iooss_linux@m4x.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolas Iooss <nicolas.iooss_linux@m4x.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Sun, 2016-08-28 at 19:39 +0200, Nicolas Iooss wrote:
> In sst_prepare_and_post_msg(), when a response is received in "block",
> the following code gets executed:
> 
>     *data = kzalloc(block->size, GFP_KERNEL);
>     memcpy(data, (void *) block->data, block->size);
> 
> The memcpy() call overwrites the content of the *data pointer instead of
> filling the newly-allocated memory (which pointer is hold by *data).
> Fix this by using *data in the memcpy() call.
> 
> Fixes: 60dc8dbacb00 ("ASoC: Intel: sst: Add some helper functions")
> Cc: stable@vger.kernel.org # 3.19.x
> Signed-off-by: Nicolas Iooss <nicolas.iooss_linux@m4x.org>
> ---
>  sound/soc/intel/atom/sst/sst_pvt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/intel/atom/sst/sst_pvt.c b/sound/soc/intel/atom/sst/sst_pvt.c
> index adb32fefd693..7c398b7c9d4b 100644
> --- a/sound/soc/intel/atom/sst/sst_pvt.c
> +++ b/sound/soc/intel/atom/sst/sst_pvt.c
> @@ -289,7 +289,7 @@ int sst_prepare_and_post_msg(struct intel_sst_drv *sst,
>  				ret = -ENOMEM;
>  				goto out;
>  			} else
> -				memcpy(data, (void *) block->data, block->size);
> +				memcpy(*data, (void *) block->data, block->size);
>  		}
>  	}
>  out:

Perhaps this would be nicer using kmemdup too
---
 sound/soc/intel/atom/sst/sst_pvt.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/sound/soc/intel/atom/sst/sst_pvt.c b/sound/soc/intel/atom/sst/sst_pvt.c
index adb32fe..b1e6b8f 100644
--- a/sound/soc/intel/atom/sst/sst_pvt.c
+++ b/sound/soc/intel/atom/sst/sst_pvt.c
@@ -279,17 +279,15 @@ int sst_prepare_and_post_msg(struct intel_sst_drv *sst,
 
 	if (response) {
 		ret = sst_wait_timeout(sst, block);
-		if (ret < 0) {
+		if (ret < 0)
 			goto out;
-		} else if(block->data) {
-			if (!data)
-				goto out;
-			*data = kzalloc(block->size, GFP_KERNEL);
-			if (!(*data)) {
+
+		if (data && block->data) {
+			*data = kmemdup(block->data, block->size, GFP_KERNEL);
+			if (!*data) {
 				ret = -ENOMEM;
 				goto out;
-			} else
-				memcpy(data, (void *) block->data, block->size);
+			}
 		}
 	}
 out:
