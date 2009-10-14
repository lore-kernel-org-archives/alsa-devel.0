From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH - try2] ASoC: Codec driver for Texas
	Instruments tlv320dac33 codec
Date: Wed, 14 Oct 2009 08:11:08 +0300
Message-ID: <200910140811.08721.peter.ujfalusi@nokia.com>
References: <1255435391-18160-1-git-send-email-peter.ujfalusi@nokia.com>
	<1255495839.30157.294.camel@eenurkka-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx03.nokia.com (smtp.nokia.com [192.100.122.230])
	by alsa0.perex.cz (Postfix) with ESMTP id 3FB631038E0
	for <alsa-devel@alsa-project.org>;
	Wed, 14 Oct 2009 07:11:18 +0200 (CEST)
In-Reply-To: <1255495839.30157.294.camel@eenurkka-desktop>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Nurkkala Eero.An (EXT-Offcode/Oulu)" <ext-Eero.Nurkkala@nokia.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Wednesday 14 October 2009 07:50:39 Nurkkala Eero.An (EXT-Offcode/Oulu) w=
rote:
> On Tue, 2009-10-13 at 14:03 +0200, Ujfalusi Peter (Nokia-D/Tampere)
> wrote:
> =

> Having two almost identical functions probably "rang the bells" with you
> also.
> =

> How about:
> =

> static int dac33_write_locked(struct snd_soc_codec *codec, unsigned int
> reg, unsigned int value)
> {
> 	int ret;
> =

> 	mutex_lock();
> 	ret =3D dac33_write(codec, reg, value);
> 	mutex_unlock();
> =

> 	return ret;
> }
> =

> (one way around it)

Yes, good idea.
I'll send another patch, but I want to wait for Mark's comments first, and =

address his concerns as well, if he has.

-- =

P=E9ter
