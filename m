From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH] slimbus: Unlock on error path in
	slim_msg_response()
Date: Tue, 9 Jan 2018 09:48:00 +0000
Message-ID: <0c22be94-b5dd-171a-4c17-94aaaae4dee6@linaro.org>
References: <20180109093435.4n45kxibmpvpb5i2@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f43.google.com (mail-wm0-f43.google.com [74.125.82.43])
 by alsa0.perex.cz (Postfix) with ESMTP id C81A326717C
 for <alsa-devel@alsa-project.org>; Tue,  9 Jan 2018 10:48:06 +0100 (CET)
Received: by mail-wm0-f43.google.com with SMTP id f140so19281434wmd.2
 for <alsa-devel@alsa-project.org>; Tue, 09 Jan 2018 01:48:06 -0800 (PST)
In-Reply-To: <20180109093435.4n45kxibmpvpb5i2@mwanda>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Dan Carpenter <dan.carpenter@oracle.com>, Sagar Dharia <sdharia@codeaurora.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org



On 09/01/18 09:34, Dan Carpenter wrote:
> We need to unlock and restore IRQs before returning on this error path.
> 
> Fixes afbdcc7c384b0 ("slimbus: Add messaging APIs to slimbus framework")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> diff --git a/drivers/slimbus/messaging.c b/drivers/slimbus/messaging.c
> index 755462a4c75e..94818a8427e2 100644
> --- a/drivers/slimbus/messaging.c
> +++ b/drivers/slimbus/messaging.c
> @@ -36,6 +36,7 @@ void slim_msg_response(struct slim_controller *ctrl, u8 *reply, u8 tid, u8 len)
>   
>   	msg = txn->msg;
>   	if (msg == NULL || msg->rbuf == NULL) {
> +		spin_unlock_irqrestore(&ctrl->txn_lock, flags);
>   		dev_err(ctrl->dev, "Got response to invalid TID:%d, len:%d\n",
>   				tid, len);
>   		return;
> 

Pl note that there are already some patches in flight which are yet to 
be merged fixes most of the static checker errors :

This is already fixed at:

https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1575798.html
