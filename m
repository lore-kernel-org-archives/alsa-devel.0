From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: About iMX6SL AUDMUX (port 7) and SSI3
Date: Wed, 25 Feb 2015 00:38:37 -0800
Message-ID: <20150225083837.GA6436@Asurada>
References: <54E5C1A3.8020301@gmail.com> <20150220050127.GA2861@Asurada-CZ80>
 <54ED87C4.4020105@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pd0-f176.google.com (mail-pd0-f176.google.com
 [209.85.192.176])
 by alsa0.perex.cz (Postfix) with ESMTP id 10FAC2605EE
 for <alsa-devel@alsa-project.org>; Wed, 25 Feb 2015 09:38:51 +0100 (CET)
Received: by pdjz10 with SMTP id z10so3438314pdj.0
 for <alsa-devel@alsa-project.org>; Wed, 25 Feb 2015 00:38:46 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <54ED87C4.4020105@gmail.com>
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

On Wed, Feb 25, 2015 at 04:28:52PM +0800, Xuebing Wang wrote:
> Thanks. As the mainline kernel supports I2S master mode, would you please
> tell me which ASoC machine driver actually uses I2S master mode?

fsl-asoc-card.c

> The reason I am asking is that I am using I2S master mode, I'd like to
> reference that machine driver to configure audmux by function
> imx_audmux_v2_configure_port().

That driver is a general purpose driver for several CODECs supports.
If you plan to get your machine driver upstream, you can try that
one directly; Otherwise, you can extract the audmux configuration
part for your own use.

Nicolin
