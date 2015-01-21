From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: Question about codec which is supporting TDM /
	5.1ch
Date: Wed, 21 Jan 2015 13:05:10 +0100
Message-ID: <54BF95F6.7000108@metafoo.de>
References: <SIXPR06MB0463DA8E64794D44FB73E300C1590@SIXPR06MB0463.apcprd06.prod.outlook.com>
 <HKNPR06MB3221239EC2C1BA4FF216094B5590@HKNPR06MB322.apcprd06.prod.outlook.com>
 <SIXPR06MB0463190557784E65CDBDD30FC1590@SIXPR06MB0463.apcprd06.prod.outlook.com>
 <SIXPR06MB06548D6E23E7CD8B79F1BD44BC590@SIXPR06MB0654.apcprd06.prod.outlook.com>
 <HKXPR06MB34170B809052DD484A1B62DA9460@HKXPR06MB341.apcprd06.prod.outlook.com>
 <SIXPR06MB0463BD85668E6D68EEC9A5E3C1460@SIXPR06MB0463.apcprd06.prod.outlook.com>
 <SIXPR06MB333851D089CC87404B679C1B5460@SIXPR06MB333.apcprd06.prod.outlook.com>
 <54ACD3BF.9060107@renesas.com>
 <HKXPR06MB0615ABF482506554FD9A7191D7460@HKXPR06MB0615.apcprd06.prod.outlook.com>
 <54BE1BC0.6090408@renesas.com>
 <HKXPR06MB0615D0AA32CC1219B1E5E95DD74B0@HKXPR06MB0615.apcprd06.prod.outlook.com>
 <HKXPR06MB341C8969D2788FE21F887E2A94B0@HKXPR06MB341.apcprd06.prod.outlook.com>
 <87ppa8mvqh.wl%kuninori.morimoto.gx@renesas.com>
 <87oapsmvav.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-053.synserver.de (smtp-out-053.synserver.de
 [212.40.185.53])
 by alsa0.perex.cz (Postfix) with ESMTP id DF705261B2A
 for <alsa-devel@alsa-project.org>; Wed, 21 Jan 2015 13:05:09 +0100 (CET)
In-Reply-To: <87oapsmvav.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Mark Brown <broonie@linaro.org>, Mark Brown <broonie@kernel.org>, Linux-ALSA <alsa-devel@alsa-project.org>
Cc: TOMOHARU FUKAWA <tomoharu.fukawa.eb@renesas.com>, shiiba <naoya.shiiba.nx@renesas.com>, YOSHIFUMI HOSOYA <yoshifumi.hosoya.wj@renesas.com>, shimoda <yoshihiro.shimoda.uh@renesas.com>, Magnus <magnus.damm@gmail.com>, komatsu <toshiaki.komatsu.ud@renesas.com>, tanaka <hiroo.tanaka.sx@renesas.com>
List-Id: alsa-devel@alsa-project.org

On 01/21/2015 08:44 AM, Kuninori Morimoto wrote:
>
> Hi ALSA / ALSA SoC
>
> Now, we want to create new board, and then, we want to use below codec if exist.
> Can you show it to us if it was exist ?
> (I researched it on upstream Linux source tree, but couldn't find....)
>
>   - upstream Linux supports its driver
>   - it supports TDM format
>   - it supports 5.1ch sound
>   - it supports DT bindings (if possible)

Hi,

The AD1937(I2C) and AD1938/AD1939/ADAU1328(SPI) have TDM support and 8 DACs. 
So they can support up to 7.1.

For more info see 
http://wiki.analog.com/resources/tools-software/linux-drivers/sound/ad1936

- Lars
