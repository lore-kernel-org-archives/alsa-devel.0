From: Kevin Cernekee <cernekee@chromium.org>
Subject: Re: [PATCH 1/3] ASoC: tas571x: Add DT binding document
Date: Mon, 20 Apr 2015 14:18:56 -0700
Message-ID: <CAJzqFtYBvNAgwROZ09MGanYOyyF0EXEL7W9ZF4eAhprQVquNcQ@mail.gmail.com>
References: <1429134141-17924-1-git-send-email-cernekee@chromium.org> <20150418111622.GD26185@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150418111622.GD26185@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, dgreid@chromium.org, Andrew Bresticker <abrestic@chromium.org>, Olof Johansson <olofj@chromium.org>, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

Resending from the correct account.


On Sat, Apr 18, 2015 at 4:16 AM, Mark Brown <broonie@kernel.org> wrote:
> On Wed, Apr 15, 2015 at 02:42:19PM -0700, Kevin Cernekee wrote:
>
>> +- VDD-supply: regulator phandle for the AVDD/DVDD/HP_VDD supply
>
> This is clearly not correct - if there are three separate physical
> supplies there should be three separate regulators requested.  They may
> all resolve to one physical regulator on the board you are working with
> but that might not be true on other boards.

In the "simplified diagram," TI shows a single AVDD/DVDD/HP_VDD supply:

http://www.ti.com/lit/ds/symlink/tas5717.pdf#2

Page 20 also suggests the use of a single 3.3V supply for AVDD/DVDD/HP_VDD.

But this combines a number of separate pins.  On 5711 we have
dedicated pins for:

PVDD_A
PVDD_B
PVDD_C
PVDD_D
AVDD
DVDD

On 5717 we have dedicated pins for:

PVDD_AB
PVDD_CD
AVDD
DVDD
HPVDD

I didn't see anything in the datasheet suggesting it is OK to have
different voltages or power states on the various supply pins (other
than the special voltage on PVDD).

I can add as many regulator entries as appropriate.  What do you recommend?
