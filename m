From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: About iMX6SL AUDMUX (port 7) and SSI3
Date: Thu, 19 Feb 2015 21:01:28 -0800
Message-ID: <20150220050127.GA2861@Asurada-CZ80>
References: <54E5C1A3.8020301@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pd0-f173.google.com (mail-pd0-f173.google.com
 [209.85.192.173])
 by alsa0.perex.cz (Postfix) with ESMTP id D47B62605B6
 for <alsa-devel@alsa-project.org>; Fri, 20 Feb 2015 06:01:35 +0100 (CET)
Received: by pdbfl12 with SMTP id fl12so5047604pdb.4
 for <alsa-devel@alsa-project.org>; Thu, 19 Feb 2015 21:01:34 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <54E5C1A3.8020301@gmail.com>
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

On Thu, Feb 19, 2015 at 06:57:39PM +0800, Xuebing Wang wrote:

> I am working on ASoC based sound driver for our iMX6SL based board.
> There are 3 I2S peripherals on the board:
> - iMX6SL pads AUD3 (as in AUD3_TXC), connect to peripheral Codec3
> - iMX6SL pads AUD5 connect to Codec5
> - iMX6SL pads Aud6, connect to Codec6
> 
> Q1) Is internal SSI3 controller (ssi@02030000) actually *hard-wired*
> to AUDMUX port 7?

Yes. The first version of AUDMUX was only designed for two SSIs.
Later version of i.MX SoC added an extra SSI so it had to connect
to AUD7 which looks a bit weird.

> Q2) Can I configure audmux as below?
> - External AUD3 -> internal SSI3 (which is actually audmux port 7?)
> - External AUD5 -> internal SSI2 (ssi@0202c000)
> - External AUD6 -> internal SSI1 (ssi@02028000)

I think you can.

Nicolin
