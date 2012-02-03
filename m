From: "M R Swami Reddy" <MR.Swami.Reddy@ti.com>
Subject: Re: [PATCH ] ASoC: Add support for TI LM49453 Audio
	codec
Date: Fri, 03 Feb 2012 20:14:29 +0530
Message-ID: <4F2BF2CD.8020600@ti.com>
References: <290463D19D2E064191F1F96ECA480A89434AB423B2@EXMAIL02.scwf.nsc.com>
	<20120202231427.GG3112@opensource.wolfsonmicro.com>
	<290463D19D2E064191F1F96ECA480A89434ABCAEDD@EXMAIL02.scwf.nsc.com>
	<20120203132504.GK3151@opensource.wolfsonmicro.com>
	<4F2BE22A.7070006@nsc.com>
	<20120203135544.GP3151@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sc-mailgw05.nsc.com (mail2.nsc.com [12.238.8.132])
	by alsa0.perex.cz (Postfix) with ESMTP id 298FE10B8A1
	for <alsa-devel@alsa-project.org>; Fri,  3 Feb 2012 15:45:31 +0100 (CET)
Received: from SCNTRDCSS8.nsc.com (scntrdcss8.nsc.com [10.188.130.179])
	by sc-mailgw05.nsc.com (Tumbleweed MailGate 3.7.1) with ESMTP id
	2DC9417E00A0
	for <alsa-devel@alsa-project.org>; Fri,  3 Feb 2012 06:45:20 -0800 (PST)
In-Reply-To: <20120203135544.GP3151@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Girdwood,
	Liam" <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

Mark Brown wrote:
> On Fri, Feb 03, 2012 at 07:03:30PM +0530, M R Swami Reddy wrote:
>> Mark Brown wrote:
>>> On Fri, Feb 03, 2012 at 04:19:00AM -0800, Reddy, MR Swami wrote:
> 
>>>> Setting CHIP_EN bit as '0'. In the _STANDBY mode, CHIP_EN bit setting
>>>> not needed and will remove in the next patch.
> 
>>> This also sounds broken, as I repeatedly said when reviewing previous
>>> versions of the driver if disabling the chip does anything at all then
>>> why don't you need to reenable the chip later?
> 
>> OK. I will remove chip disable code in case if _STANDBY and _OFF modes.
> 
> So the chip disable does nothing?  There's nothing wrong with disabling
> the chip when it goes to idle, it's just that one would expect that
> something ought to then reenable it when the device is needed again.

In _STANDBY mode - chip enable and
in _OFF mode - chip disable

Thanks
Swami
