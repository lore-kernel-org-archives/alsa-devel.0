From: Xuebing Wang <xbing6@gmail.com>
Subject: Re: About iMX6SL AUDMUX (port 7) and SSI3
Date: Wed, 25 Feb 2015 16:28:52 +0800
Message-ID: <54ED87C4.4020105@gmail.com>
References: <54E5C1A3.8020301@gmail.com> <20150220050127.GA2861@Asurada-CZ80>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ie0-f180.google.com (mail-ie0-f180.google.com
 [209.85.223.180])
 by alsa0.perex.cz (Postfix) with ESMTP id A34932605CB
 for <alsa-devel@alsa-project.org>; Wed, 25 Feb 2015 09:29:01 +0100 (CET)
Received: by iecrl12 with SMTP id rl12so3082480iec.2
 for <alsa-devel@alsa-project.org>; Wed, 25 Feb 2015 00:29:00 -0800 (PST)
In-Reply-To: <20150220050127.GA2861@Asurada-CZ80>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: alsa-devel@alsa-project.org, niranjan Patil <Niranjan.Patil@infocus.com>, timur Tabi <timur@tabi.org>, richard Jiang <Richard.Jiang@infocus.com>, xiubo Li <Xiubo.Lee@gmail.com>
List-Id: alsa-devel@alsa-project.org

Nicolin,

Thanks. As the mainline kernel supports I2S master mode, would you 
please tell me which ASoC machine driver actually uses I2S master mode?

The reason I am asking is that I am using I2S master mode, I'd like to 
reference that machine driver to configure audmux by function 
imx_audmux_v2_configure_port().

Thanks.


On 02/20/2015 01:01 PM, Nicolin Chen wrote:
> On Thu, Feb 19, 2015 at 06:57:39PM +0800, Xuebing Wang wrote:
>
>> I am working on ASoC based sound driver for our iMX6SL based board.
>> There are 3 I2S peripherals on the board:
>> - iMX6SL pads AUD3 (as in AUD3_TXC), connect to peripheral Codec3
>> - iMX6SL pads AUD5 connect to Codec5
>> - iMX6SL pads Aud6, connect to Codec6
>>
>> Q1) Is internal SSI3 controller (ssi@02030000) actually *hard-wired*
>> to AUDMUX port 7?
> Yes. The first version of AUDMUX was only designed for two SSIs.
> Later version of i.MX SoC added an extra SSI so it had to connect
> to AUD7 which looks a bit weird.
>
>> Q2) Can I configure audmux as below?
>> - External AUD3 -> internal SSI3 (which is actually audmux port 7?)
>> - External AUD5 -> internal SSI2 (ssi@0202c000)
>> - External AUD6 -> internal SSI1 (ssi@02028000)
> I think you can.
>
> Nicolin
>

-- 
Xuebing
