From: =?ISO-8859-1?Q?P=E9ter?= Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH v2 2/2] ASoC: omap-mcpdm: Replace legacy
	driver
Date: Tue, 23 Aug 2011 09:49:44 +0300
Message-ID: <12518591.ESZDKfh5zZ@barack>
References: <1313739679-8975-1-git-send-email-peter.ujfalusi@ti.com>
	<1452269.zSYBkDql26@barack> <4E525C03.6090405@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
	by alsa0.perex.cz (Postfix) with ESMTP id 34DE02454E
	for <alsa-devel@alsa-project.org>;
	Tue, 23 Aug 2011 08:49:42 +0200 (CEST)
In-Reply-To: <4E525C03.6090405@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, "Girdwood,
	Liam" <lrg@ti.com>, "Lopez Cruz, Misael" <misael.lopez@ti.com>
List-Id: alsa-devel@alsa-project.org

On Monday 22 August 2011 15:39:15 Lars-Peter Clausen wrote:
> omap_mcpdm_widgets is a global variable.

Yeah, as most of the snd_soc_dapm_widget.

> You assign to it in asoc_mcpdm_probe

Since at compile time I don't have the pointer for the mcpdm (it is allocat=
ed =

earlier in the same function), I need to assign it somewhere.

> and read from it in omap_mcpdm_add_dapm_widget.

I don't see any reference to the omap_mcpdm_widgets in there.

> The fact that you hide your *mcpdm in a void pointer doesn't make it less
> hackish.

Well, from that point of view most of the kernel is hackish. We tend to hav=
e =

void pointers for various things, like platform_data, device_data, =

driver_data, private_data, etc.
You see, the point here is that this private_data for the widget can be use=
d =

for others as well, if needed. It would make no sense to put "struct =

omap_mcpdm *mcpdm", just because I have this requirement first, does it? =


For sure, I could have chosen to create one global pointer for this event =

handler:

static struct omap_mcpdm *mcpdm_global;

Use the mcpdm_global within omap_mcpdm_interface_event function, and assign=
 it =

at asoc_mcpdm_probe time.

Would that look better? IMHO it is not.

As Mark suggested, we should have accessor for this, if we are going to hav=
e =

such a thing.

The reason for this (as I described in the commit message):
OMAP McPDM has the requirement (along with the twl6040), that we need to st=
op =

the cpu dai _after_ the DAC/ADC has been stopped on the codec side.
Now, I do not want to hard wire the twl6040, nor the omap-mcpdm with each =

other.
The omap-mcpdm implements the event callback, and the machine driver is =

responsible to create the DAPM route to make sure we follow the correct =

sequence.
I could as well implemented these things in the machine driver (+global =

pointer for mcpdm), but that can lead duplicated code in the future (new =

machine driver, etc).

-- =

P=E9ter
