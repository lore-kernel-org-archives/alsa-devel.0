From: Manuel Lauss <manuel.lauss@googlemail.com>
Subject: Re: [PATCH v5] ASoC/2.6.37: fix au1x platform
Date: Fri, 27 Aug 2010 15:32:16 +0200
Message-ID: <AANLkTikr3rpij1FuKAQrwR0U8kpJUnKzfVJEzeYeGEsk@mail.gmail.com>
References: <1282827231-17323-1-git-send-email-manuel.lauss@googlemail.com>
	<1282913484.3025.25.camel@odin>
	<1365302F-4C5D-4075-8D38-94DEEEF2583E@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-iw0-f179.google.com (mail-iw0-f179.google.com
	[209.85.214.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 6787B245F3
	for <alsa-devel@alsa-project.org>;
	Fri, 27 Aug 2010 15:32:17 +0200 (CEST)
Received: by iwn4 with SMTP id 4so2587208iwn.38
	for <alsa-devel@alsa-project.org>; Fri, 27 Aug 2010 06:32:16 -0700 (PDT)
In-Reply-To: <1365302F-4C5D-4075-8D38-94DEEEF2583E@opensource.wolfsonmicro.com>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Ian Lartey <ian@opensource.wolfsonmicro.com>, "alsa-devel@vger.kernel.org" <alsa-devel@vger.kernel.org>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Hello,

On Fri, Aug 27, 2010 at 3:07 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On 27 Aug 2010, at 13:51, Liam Girdwood <lrg@slimlogic.co.uk> wrote:
>
>> On Thu, 2010-08-26 at 14:53 +0200, Manuel Lauss wrote:
>>> This patch fixes up the au1x audio platform after the multi-component
>>> merge:
>>> - compile fixes and updates to get DB1200 platform audio working again,
>>> - removal of global variables in AC97/I2S/DMA(PCM) modules.
>>>
>>> The AC97 part is limited to one instance only for now due to issues
>>> with getting at driver data in the soc_ac97_ops.
>>>
>>> Signed-off-by: Manuel Lauss <manuel.lauss@googlemail.com>
>>> ---
>>> v5: smaller patch
>>> v4: fixed a bug in the previous bugfix, and added DAI drvdata accessors.
>>> v3: fixed a bug which caused cat /proc/iomem to loop endlessly.
>>> v2: prepare PCM,I2S for multiple card operation, use dev_name() for DAI=
 name.
>>>
>>> Against Liam's asoc/for-2.6.37 branch.
>>>
>>> Tested on DB1200 and DB1300 (here both I2S and AC97 operate as
>>> independent cards), =A0please fold this into the other Au1x multi-compo=
nent
>>> patches.
>>>
>>
>> This all looks fine
>>
>>> Issues I observed with AC97:
>>> * AC97 is limited to a single instance since I cannot get at the driver
>>> =A0data in the AC97 callbacks at all time (or did I miss anything?):
>>> =A0when the AC97 codec calls snd_ac97_mixer(), it calls into the soc_ac=
97_ops
>>> =A0callbacks; however ac97->bus->card->private_data (suggested by Mark)
>>> =A0is _always_ NULL, so no way to get at the dai and ultimately driver =
data.
>>>
>>> * generic AC97 codec use spits out this kobject warning, which is cause=
d by the
>>> =A0"device_register()" in soc-core.c::soc_ac97_dev_register():
>>>
>>
>> Although I'm curious about these issues. I didn't see them when testing
>> on my now non working Zylonite with WM9713 (AC97), so I'm suspecting
>> it's related to the generic AC97 somehow.
>
> Yeah, the generic AC97 code doesn't really know what's going on with ASoC=
 so we're probably upsetting it again. Most likely we need to redo the stuf=
f to suppress the card registration for AC97 cards.
>
>> Unfortunately, this will need someone with working AC97 hardware to fix
>> this issue.
>>
>> Is the AC97 DAI being probed before the generic AC97 codec driver in
>> this case ?

Yes.

I've found another AC97-related issue on another board (DB1300):
With AC97 enabled, the device warning doesn't appear but my ethernet
is gone instead:

[...]
smsc911x: Driver version 2008-10-21.
smsc911x-mdio: probed
eth0: attached PHY driver [SMSC LAN8700] (mii_bus:phy_addr=3Dffffffff:01, i=
rq=3D-1)
net eth0: MAC Address: 00:0f:30:11:00:a1
WM9711/WM9712 SoC Audio Codec 0.4
asoc: wm9712-hifi <-> au1xpsc_ac97.1 mapping ok
asoc: wm8731-hifi <-> au1xpsc_i2s.2 mapping ok
ALSA device list:
  #0: DB1300_AC97
  #1: DB1300_I2S
IP-Config: Failed to open eth0
IP-Config: No network devices available.
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[...]

Omit the ac97 "soc-audio" device registration and ethernet comes back
(the DB1200
for example doesn't hit the reset switch with the AC97 warning present).

Otherwise both cards work fine at the same time.

Thank you!
      Manuel Lauss
