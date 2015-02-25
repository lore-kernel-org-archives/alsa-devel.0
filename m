From: Xuebing Wang <xbing6@gmail.com>
Subject: Re: About iMX6SL AUDMUX (port 7) and SSI3
Date: Wed, 25 Feb 2015 20:15:25 +0800
Message-ID: <54EDBCDD.7040108@gmail.com>
References: <54E5C1A3.8020301@gmail.com> <20150220050127.GA2861@Asurada-CZ80>
 <54ED87C4.4020105@gmail.com> <20150225083837.GA6436@Asurada>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ig0-f175.google.com (mail-ig0-f175.google.com
 [209.85.213.175])
 by alsa0.perex.cz (Postfix) with ESMTP id 8877826061B
 for <alsa-devel@alsa-project.org>; Wed, 25 Feb 2015 13:15:33 +0100 (CET)
Received: by mail-ig0-f175.google.com with SMTP id hn18so34907282igb.2
 for <alsa-devel@alsa-project.org>; Wed, 25 Feb 2015 04:15:31 -0800 (PST)
In-Reply-To: <20150225083837.GA6436@Asurada>
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


On 02/25/2015 04:38 PM, Nicolin Chen wrote:
> On Wed, Feb 25, 2015 at 04:28:52PM +0800, Xuebing Wang wrote:
>> Thanks. As the mainline kernel supports I2S master mode, would you please
>> tell me which ASoC machine driver actually uses I2S master mode?
> fsl-asoc-card.c

Nicolin,

Thanks. I am trying routing aud3 to internal ssi2. Thus in my case: 
int_port = 2, ext_port = 3, right? Of course, there are int_port-- and 
ext_port --.

As I am using I2S master mode (ssi2 generates both bit clock and frame 
sync, thus (dai_fmt & MASK) == SND_SOC_DAIFMT_CBM_CFM. According to 
iMX6SL reference manual, should TFSEL (bits 30..27) of int_ptcr be 
IMX_AUDMUX_V2_PTCR_TFSEL(int_port) (note: int_port vs ext_port), rather 
than the current IMX_AUDMUX_V2_PTCR_TFSEL(ext_port) in file fsl-asoc-card.c?

Thanks again.


>> The reason I am asking is that I am using I2S master mode, I'd like to
>> reference that machine driver to configure audmux by function
>> imx_audmux_v2_configure_port().
> That driver is a general purpose driver for several CODECs supports.
> If you plan to get your machine driver upstream, you can try that
> one directly; Otherwise, you can extract the audmux configuration
> part for your own use.
>
> Nicolin
>
>

-- 
Xuebing
