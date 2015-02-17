From: Xuebing Wang <xbing6@gmail.com>
Subject: Re: iMX6 SSI driver: fsl_ssi vs imx-ssi
Date: Tue, 17 Feb 2015 08:47:45 +0800
Message-ID: <54E28FB1.60309@gmail.com>
References: <54E286C6.8030705@gmail.com> <54E28843.4060100@tabi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qc0-f181.google.com (mail-qc0-f181.google.com
 [209.85.216.181])
 by alsa0.perex.cz (Postfix) with ESMTP id 0AA07260703
 for <alsa-devel@alsa-project.org>; Tue, 17 Feb 2015 01:47:51 +0100 (CET)
Received: by mail-qc0-f181.google.com with SMTP id p6so26628556qcv.12
 for <alsa-devel@alsa-project.org>; Mon, 16 Feb 2015 16:47:50 -0800 (PST)
In-Reply-To: <54E28843.4060100@tabi.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@tabi.org>, alsa-devel@alsa-project.org
Cc: Nicolin Chen <nicoleotsuka@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>
List-Id: alsa-devel@alsa-project.org

Timur, thanks,

What about fsl_dma.c vs imx-pcm-dma.c?

Should I use imx-audmux.c for audmux?


On 02/17/2015 08:16 AM, Timur Tabi wrote:
> Use fsl_ssi.c.  imx-ssi.c is deprecated because it doesn't support 
> device trees.
>
> Xuebing Wang wrote:
>> Hi community,
>>
>> I am developing an ASOC codec driver based on iMX6SL platform. I noticed
>> there are fsl_ssi.c and imx-ssi.c in folder sound/soc/fsl.
>>
>> Would you please tell me what are the differences between these 2, and
>> which one should I use? Thanks.
>>
>
>

-- 
Xuebing
