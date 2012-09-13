From: Tabi Timur-B04825 <B04825@freescale.com>
Subject: Re: Need help with WM8960
Date: Thu, 13 Sep 2012 03:26:03 +0000
Message-ID: <6AE080B68D46FC4BA2D2769E68D765B7080568F2@039-SN2MPN1-023.039d.mgd.msft.net>
References: <5051160C.2010802@freescale.com>
 <20120913024245.GA4467@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe004.messaging.microsoft.com [213.199.154.207])
 by alsa0.perex.cz (Postfix) with ESMTP id EA1D82616E3
 for <Alsa-devel@alsa-project.org>; Thu, 13 Sep 2012 05:26:08 +0200 (CEST)
In-Reply-To: <20120913024245.GA4467@opensource.wolfsonmicro.com>
Content-Language: en-US
Content-ID: <E46CF63A2FB5A24BA5BB1B16CEAF9652@mgd.freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "Alsa-devel@alsa-project.org" <Alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Mark Brown wrote:
>
>> >Third, in order to actually hear audio, I had to unmute the "Left Output
>> >Mixer PCM" and "Right Output Mixer PCM".  Is this something that the
>> >machine driver should do automatically?  And if so, how?

> No, it's something that the application should do.

How would the application know to unmute those two particular controls? 
The only way I figured it out is by launching alsamixer and playing with 
every control until I heard sound.

-- 
Timur Tabi
Linux kernel developer at Freescale
