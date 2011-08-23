From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v2 2/2] ASoC: omap-mcpdm: Replace legacy
 driver
Date: Tue, 23 Aug 2011 12:14:58 +0200
Message-ID: <4E537DA2.30607@metafoo.de>
References: <1313739679-8975-1-git-send-email-peter.ujfalusi@ti.com>	<1452269.zSYBkDql26@barack>
	<4E525C03.6090405@metafoo.de> <12518591.ESZDKfh5zZ@barack>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailhost.informatik.uni-hamburg.de
	(mailhost.informatik.uni-hamburg.de [134.100.9.70])
	by alsa0.perex.cz (Postfix) with ESMTP id BC1502462F
	for <alsa-devel@alsa-project.org>;
	Tue, 23 Aug 2011 12:15:29 +0200 (CEST)
In-Reply-To: <12518591.ESZDKfh5zZ@barack>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: =?ISO-8859-1?Q?P=E9ter_Ujfalusi?= <peter.ujfalusi@ti.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, "Girdwood,
	Liam" <lrg@ti.com>, "Lopez Cruz, Misael" <misael.lopez@ti.com>
List-Id: alsa-devel@alsa-project.org

On 08/23/2011 08:49 AM, P=E9ter Ujfalusi wrote:
> On Monday 22 August 2011 15:39:15 Lars-Peter Clausen wrote:
>> omap_mcpdm_widgets is a global variable.
> =

> Yeah, as most of the snd_soc_dapm_widget.
> =


The point is, you use it to pass runtime specific data around, while the ot=
hers
are constant compile time data, which are used as a template.

>> You assign to it in asoc_mcpdm_probe
> =

> Since at compile time I don't have the pointer for the mcpdm (it is alloc=
ated =

> earlier in the same function), I need to assign it somewhere.
> =

>> and read from it in omap_mcpdm_add_dapm_widget.
> =

> I don't see any reference to the omap_mcpdm_widgets in there.

+	return snd_soc_dapm_new_controls(dapm, omap_mcpdm_widgets,
+					ARRAY_SIZE(omap_mcpdm_widgets));


> =

>> The fact that you hide your *mcpdm in a void pointer doesn't make it less
>> hackish.
> =

> Well, from that point of view most of the kernel is hackish. We tend to h=
ave =

> void pointers for various things, like platform_data, device_data, =

> driver_data, private_data, etc.

I'm not arguing against such constructs. I'm arguing against your usage of =
them.

Let me give you an example which is analogous to yours:

static struct platform_device foo;

static void bar_probe(struct platform_device *pdev)
{
	foo.dev.platform_data =3D ...;
}

void bar_some_global_func(void)
{
	platform_device_add(&foo);
}

You'll rarely see this in driver code.

If that doesn't convince you, ask yourself what would happen if you had two
instances of the mcpdm driver.

> You see, the point here is that this private_data for the widget can be u=
sed =

> for others as well, if needed. It would make no sense to put "struct =

> omap_mcpdm *mcpdm", just because I have this requirement first, does it? =

> =

> For sure, I could have chosen to create one global pointer for this event =

> handler:
> =

> static struct omap_mcpdm *mcpdm_global;
> =

> Use the mcpdm_global within omap_mcpdm_interface_event function, and assi=
gn it =

> at asoc_mcpdm_probe time.
> =

> Would that look better? IMHO it is not.
> =


Your current solution might look better on the surface, but it is deep ugly=
 on
the inside. You've hidden your mcpdm_global in a construct that is normally
present in a ASoC driver. You've just slightly changed it in subtitle way,
apparently so subtitle you don't even see it yourself.
