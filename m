From: Timur Tabi <timur@tabi.org>
Subject: Re: iMX6 SSI driver: fsl_ssi vs imx-ssi
Date: Mon, 16 Feb 2015 18:16:03 -0600
Message-ID: <54E28843.4060100@tabi.org>
References: <54E286C6.8030705@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from muin.pair.com (muin.pair.com [209.68.1.55])
 by alsa0.perex.cz (Postfix) with ESMTP id 7FD6B260703
 for <alsa-devel@alsa-project.org>; Tue, 17 Feb 2015 01:16:05 +0100 (CET)
In-Reply-To: <54E286C6.8030705@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Xuebing Wang <xbing6@gmail.com>, alsa-devel@alsa-project.org
Cc: Nicolin Chen <nicoleotsuka@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>
List-Id: alsa-devel@alsa-project.org

Use fsl_ssi.c.  imx-ssi.c is deprecated because it doesn't support 
device trees.

Xuebing Wang wrote:
> Hi community,
>
> I am developing an ASOC codec driver based on iMX6SL platform. I noticed
> there are fsl_ssi.c and imx-ssi.c in folder sound/soc/fsl.
>
> Would you please tell me what are the differences between these 2, and
> which one should I use? Thanks.
>
