From: "Wang, Kuirong" <kuirongw@quicinc.com>
Subject: Re: How to trigger a widget?
Date: Fri, 24 Feb 2012 04:57:40 +0000
Message-ID: <D618B7A80E26984A9E4E1FD204983C1AA8F398@nasanexd01d.na.qualcomm.com>
References: <D618B7A80E26984A9E4E1FD204983C1AA88700@nasanexd01d.na.qualcomm.com>
	<4F420D6D.4050500@metafoo.de>
	<D618B7A80E26984A9E4E1FD204983C1AA8AAF4@nasanexd01d.na.qualcomm.com>
	<4F449901.302@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wolverine01.qualcomm.com (wolverine01.qualcomm.com
	[199.106.114.254])
	by alsa0.perex.cz (Postfix) with ESMTP id 155CF244AA
	for <alsa-devel@alsa-project.org>; Fri, 24 Feb 2012 05:57:42 +0100 (CET)
In-Reply-To: <4F449901.302@ti.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

On 02/21/2012 11:28 PM, Peter Ujfalusi  wrote:
>Would not it be simpler if you just enable/disable the feature in the kcon=
trol's set callback?
>
>Another way I would go is this:
>
>                  |-> (off) ---------|
>[Feature switch] -|                  |-> [next widget]
>                  |-> (on) -> [PGA] -|
>
>In the PGA you turn on/off the feature. If the switch changes it will not =
affect other items in the path, it will only make the PGA to turn on/off.
>
>--
>P=E9ter

Peter,

I don't want to power on this circuit related to the feature if the audio s=
tream is not playing so if I use the kcontrol callback function to do so, i=
t could power up even the audio stream is not playing. =


I will try the way you suggested by using a switch. In the meanwhile, I wil=
l check why the enable_pin doesn't work as expected in my system.

Thanks!

Kuirong
