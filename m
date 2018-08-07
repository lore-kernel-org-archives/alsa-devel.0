From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [bug report] slimbus: ngd: Add qcom SLIMBus NGD
	driver
Date: Tue, 7 Aug 2018 13:33:19 +0100
Message-ID: <64011262-591f-751d-c318-59209059a603@linaro.org>
References: <20180807120707.3yjy6ggguk3frtrr@kili.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f68.google.com (mail-wm0-f68.google.com [74.125.82.68])
 by alsa0.perex.cz (Postfix) with ESMTP id 46274267692
 for <alsa-devel@alsa-project.org>; Tue,  7 Aug 2018 14:33:21 +0200 (CEST)
Received: by mail-wm0-f68.google.com with SMTP id r24-v6so14243864wmh.0
 for <alsa-devel@alsa-project.org>; Tue, 07 Aug 2018 05:33:21 -0700 (PDT)
In-Reply-To: <20180807120707.3yjy6ggguk3frtrr@kili.mountain>
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
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Dan,

Thanks for the sharing out this warning msg.

On 07/08/18 13:07, Dan Carpenter wrote:
> Hello Srinivas Kandagatla,
> 
> This is a semi-automatic email about new static checker warnings.
> 
> The patch 917809e2280b: "slimbus: ngd: Add qcom SLIMBus NGD driver"
> from Jun 19, 2018, leads to the following Smatch complaint:
> 
>      drivers/slimbus/qcom-ngd-ctrl.c:867 qcom_slim_ngd_xfer_msg()
>       warn: variable dereferenced before check 'txn->msg' (see line 791)
> 
> drivers/slimbus/qcom-ngd-ctrl.c
>     790	
>     791		if (txn->msg->num_bytes > SLIM_MSGQ_BUF_LEN ||
>                      ^^^^^^^^^
> Dereference
> 
>     792				txn->rl > SLIM_MSGQ_BUF_LEN) {
>     793			dev_err(ctrl->dev, "msg exeeds HW limit\n");

...
>     866	
>     867		if (txn->msg && txn->msg->wbuf)
>                      ^^^^^^^^
> This check is too late.

To be honest this function should not be invoked with txn->msg being 
NULL. I can see that slim_val_inf_sanity() enforces this, but we can add 
an additional check in slim_do_transfer() for this not to happen in case 
  slim_do_transfer() is invoked directly.

Check in this ngd driver is totally redundant.
I will try to send a cleanup patch for this once rc1 is out.

thanks,
srini
> 
>     868			memcpy(puc, txn->msg->wbuf, txn->msg->num_bytes);
>     869	
> 
> regards,
> dan carpenter
> 
