From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH] ASoC: dmic codec: Support for DT
Date: Tue, 15 May 2012 14:44:35 +0300
Message-ID: <4FB241A3.3020104@ti.com>
References: <1336478157-27526-1-git-send-email-peter.ujfalusi@ti.com>
	<20120508125837.GN15893@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog113.obsmtp.com (na3sys009aog113.obsmtp.com
	[74.125.149.209])
	by alsa0.perex.cz (Postfix) with ESMTP id DE2E624CC3
	for <alsa-devel@alsa-project.org>;
	Tue, 15 May 2012 13:44:28 +0200 (CEST)
Received: by lagz14 with SMTP id z14so4169907lag.7
	for <alsa-devel@alsa-project.org>; Tue, 15 May 2012 04:44:25 -0700 (PDT)
In-Reply-To: <20120508125837.GN15893@opensource.wolfsonmicro.com>
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

On 05/08/2012 03:58 PM, Mark Brown wrote:
> On Tue, May 08, 2012 at 02:55:57PM +0300, Peter Ujfalusi wrote:
> =

>> +dmic_codec: dmic_codec@0 { /* generic DMIC codec */
>> +	compatible =3D "generic,dmic-codec";
>> +};
> =

> Why is this called "dmic-codec" and not "dmic"?  We probably need to
> have a think about this in the context of the handling of random
> on-board passive components in general - things like jacks and so on - =

> is the most sensible thing to have a platform device for everything, or
> is that getting too noisy?

I don't think that we would need platform devices for most of the
passive components you have listed.
AFAIK (Liam can correct me if I'm wrong) the reason that we have this
(dmic codec) is to be able to use the OMAP4+ DMIC in a card.
In most cases the digital microphones are passive components connected
to a codec and the codec is then interfaced with the CPU dai.
With the OMAP4 DMIC we have the microphones connected directly to the
CPU dai. In some sense the OMAP4+ DMIC block is a CPU dai and a codec at
the same time. Or we can view it as we have PDM link betweent he CPU dai
and the codec (dmic).

Not entirely sure if we will need to have dts section for the dmic, I
can just create the platform device in the abe-twl6040 machine driver if
the setup includes digital microphones.

-- =

P=E9ter
