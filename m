From: Peter Rosin <peda@axentia.se>
Subject: Re: [PATCH 1/2] dt-bindings: trivial: add tfa9879
	device
Date: Sun, 3 Dec 2017 07:59:04 +0100
Message-ID: <8e295c61-089e-170d-bca2-42ded2021c99@axentia.se>
References: <20171201224425.5477-1-peda@axentia.se>
 <20171201224425.5477-2-peda@axentia.se>
 <CAOMZO5BA2ZbBnPVORALkEGV21j7H9GJW_2uVvtEEU=8qM599-w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from EUR03-AM5-obe.outbound.protection.outlook.com
 (mail-eopbgr30101.outbound.protection.outlook.com [40.107.3.101])
 by alsa0.perex.cz (Postfix) with ESMTP id 6E975266BEF
 for <alsa-devel@alsa-project.org>; Sun,  3 Dec 2017 07:59:11 +0100 (CET)
In-Reply-To: <CAOMZO5BA2ZbBnPVORALkEGV21j7H9GJW_2uVvtEEU=8qM599-w@mail.gmail.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <festevam@gmail.com>
Cc: Mark Rutland <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.com>, linux-kernel <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Russell King <linux@armlinux.org.uk>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Nicolas Ferre <nicolas.ferre@microchip.com>
List-Id: alsa-devel@alsa-project.org

On 2017-12-02 22:17, Fabio Estevam wrote:
> On Fri, Dec 1, 2017 at 8:44 PM, Peter Rosin <peda@axentia.se> wrote:
>> Add record for NXP TFA9879 Mono BTL Class D audio amplifier.
>>
>> Signed-off-by: Peter Rosin <peda@axentia.se>
>> ---
>>  Documentation/devicetree/bindings/trivial-devices.txt | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/Documentation/devicetree/bindings/trivial-devices.txt b/Documentation/devicetree/bindings/trivial-devices.txt
>> index af284fbd4d23..4cf30ce4e71f 100644
>> --- a/Documentation/devicetree/bindings/trivial-devices.txt
>> +++ b/Documentation/devicetree/bindings/trivial-devices.txt
>> @@ -157,6 +157,7 @@ nxp,pcf2127         Real-time clock
>>  nxp,pcf2129            Real-time clock
>>  nxp,pcf8563            Real-time clock/calendar
>>  nxp,pcf85063           Tiny Real-Time Clock
>> +nxp,tfa9879            Mono BTL Class D audio amplifier
> 
> This is already described at Documentation/devicetree/bindings/sound/tfa9879.txt

Right. However, the patch adding that should have been sent to me, the
maintainer of the driver. That is carefully recorded in MAINTAINERS. So,
forgive me for assuming that nothing had changed in the driver behind my
back.

Had that patch been sent my way as it should have been, I would have
insisted that maintenance of the bindings had been kept together with
the maintenance of the driver.

Cheers,
Peter
