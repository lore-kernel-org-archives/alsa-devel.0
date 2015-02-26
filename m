From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: About iMX6SL AUDMUX (port 7) and SSI3
Date: Wed, 25 Feb 2015 22:28:25 -0800
Message-ID: <20150226062824.GA2112@Asurada>
References: <54E5C1A3.8020301@gmail.com> <20150220050127.GA2861@Asurada-CZ80>
 <54ED87C4.4020105@gmail.com> <20150225083837.GA6436@Asurada>
 <54EDBCDD.7040108@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f44.google.com (mail-pa0-f44.google.com
 [209.85.220.44])
 by alsa0.perex.cz (Postfix) with ESMTP id C52E6261785
 for <alsa-devel@alsa-project.org>; Thu, 26 Feb 2015 07:28:35 +0100 (CET)
Received: by padfa1 with SMTP id fa1so11552319pad.2
 for <alsa-devel@alsa-project.org>; Wed, 25 Feb 2015 22:28:34 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <54EDBCDD.7040108@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Xuebing Wang <xbing6@gmail.com>
Cc: alsa-devel@alsa-project.org, niranjan Patil <Niranjan.Patil@infocus.com>, timur Tabi <timur@tabi.org>, richard Jiang <Richard.Jiang@infocus.com>, xiubo Li <Xiubo.Lee@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Feb 25, 2015 at 08:15:25PM +0800, Xuebing Wang wrote:

> Thanks. I am trying routing aud3 to internal ssi2. Thus in my case: int_port
> = 2, ext_port = 3, right? Of course, there are int_port-- and ext_port --.

As the port numbers come from Device Tree which is hardware description
so it must match the index from hardware Reference Manual. You don't
need to worry about unless there's a bug.

> As I am using I2S master mode (ssi2 generates both bit clock and frame sync,
> thus (dai_fmt & MASK) == SND_SOC_DAIFMT_CBM_CFM. According to iMX6SL

CBM_CFM stands for CODEC Bit Clock Master and CODEC Frame Sync Clock Master.
So what you need is the opposite -- SND_SOC_DAIFMT_CBS_CFS.

Nicolin
