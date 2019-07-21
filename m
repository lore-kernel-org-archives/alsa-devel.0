From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH] slimbus: fix duplicated argument to ||
Date: Sun, 21 Jul 2019 11:04:04 -0700
Message-ID: <4154c43331e4d1d361db41194587d3d41cf991b0.camel@perches.com>
References: <20190721174715.GA10747@hari-Inspiron-1545>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190721174715.GA10747@hari-Inspiron-1545>
Sender: linux-kernel-owner@vger.kernel.org
To: Hariprasad Kelam <hariprasad.kelam@gmail.com>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Sun, 2019-07-21 at 23:17 +0530, Hariprasad Kelam wrote:
> Remove duplicate argument SLIM_MSG_MC_REQUEST_CLEAR_INFORMATION.
> 
> fix below issue reported by coccicheck
> ./drivers/slimbus/slimbus.h:440:3-46: duplicated argument to && or ||
> 
> Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
> ---
>  drivers/slimbus/slimbus.h | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/slimbus/slimbus.h b/drivers/slimbus/slimbus.h
> index 9be4108..46a6441 100644
> --- a/drivers/slimbus/slimbus.h
> +++ b/drivers/slimbus/slimbus.h
> @@ -438,8 +438,7 @@ static inline bool slim_tid_txn(u8 mt, u8 mc)
>  	return (mt == SLIM_MSG_MT_CORE &&
>  		(mc == SLIM_MSG_MC_REQUEST_INFORMATION ||
>  		 mc == SLIM_MSG_MC_REQUEST_CLEAR_INFORMATION ||
> -		 mc == SLIM_MSG_MC_REQUEST_VALUE ||
> -		 mc == SLIM_MSG_MC_REQUEST_CLEAR_INFORMATION));
> +		 mc == SLIM_MSG_MC_REQUEST_VALUE));
>  }

Perhaps this was intended to be
		mc ==  SLIM_MSG_MC_REQUEST_CHANGE_VALUE ?
