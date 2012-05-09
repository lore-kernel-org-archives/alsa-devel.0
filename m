From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 4/4] ASoC: omap-abe-twl6040: Add device
	tree support
Date: Wed, 09 May 2012 14:45:17 +0300
Message-ID: <4FAA58CD.5010609@ti.com>
References: <1336479314-27766-1-git-send-email-peter.ujfalusi@ti.com>
	<1336479314-27766-5-git-send-email-peter.ujfalusi@ti.com>
	<20120508135912.GR15893@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog103.obsmtp.com (na3sys009aog103.obsmtp.com
	[74.125.149.71])
	by alsa0.perex.cz (Postfix) with ESMTP id C3038104576
	for <alsa-devel@alsa-project.org>;
	Wed,  9 May 2012 14:06:58 +0200 (CEST)
Received: by lagr15 with SMTP id r15so165379lag.30
	for <alsa-devel@alsa-project.org>; Wed, 09 May 2012 05:06:56 -0700 (PDT)
In-Reply-To: <20120508135912.GR15893@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>, Misael Lopez Cruz <misael.lopez@ti.com>
List-Id: alsa-devel@alsa-project.org

On 05/08/2012 04:59 PM, Mark Brown wrote:
> On Tue, May 08, 2012 at 03:15:14PM +0300, Peter Ujfalusi wrote:
> =

>> 	abe-twl6040,jack_detection =3D <0>;
> =

> Shouldn't this be a boolean property that simply needs to be present to
> flag detection?

It does work like that as well. This property only need to be there (and
to be set to 1) if the board can detect the jack.

> =

>> 	dai-link1,codec =3D <&twl6040_codec>;
>> 	dai-link1,dai =3D <&mcpdm>;
> =

> This seems like it ought to be an array of nodes, one per link, instead
> of having an index in the property name.  It should certainly be easier
> to parse.

Very true. We can handle this in a similar way as we handle the
routings. It might be a good idea to add this as a generic ASoC core
feature?

Something like:
abe-twl6040,dai-link =3D
		<&twl6040_codec>, <&mcpdm>;

Other platforms could use this and we could handle it with the same code
in the core.

> It also seems like it's not at all board specific and should be factored
> out.
> =

>> 	abe-twl6040,audio-routing =3D
>> 		"Headset Stereophone", "HSOL",
>> 		"Headset Stereophone", "HSOR",
> =

> Binding should document what the board-defined nodes are.

OK, I'll update the documentation (also covering the codec)

> =

>> +Example:
>> +
>> +sound { /* ASoC */
>> +	compatible =3D "ti,abe-twl6040";
>> +	abe-twl6040,model =3D "SDP4430";
> =

> Please don't repeat your binding documentation in the changelog, it's
> already in the patch and means it comes after the documentation.

OK, I'll remove the examples from the changelog.

-- =

P=E9ter
