From: "Ujfalusi, Peter" <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 2/2] ASoC: sdp4430: Fix Panda support
Date: Mon, 21 Nov 2011 16:17:02 +0200
Message-ID: <CAPo=G1yZ8mUw=68jFo1S03tdE1yUOkpToCvDBaK02YGaO6nAxg@mail.gmail.com>
References: <1321881246-24163-1-git-send-email-peter.ujfalusi@ti.com>
	<1321881246-24163-3-git-send-email-peter.ujfalusi@ti.com>
	<20111121133836.GA22906@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog118.obsmtp.com (na3sys009aog118.obsmtp.com
	[74.125.149.244])
	by alsa0.perex.cz (Postfix) with ESMTP id AE94F2437F
	for <alsa-devel@alsa-project.org>; Mon, 21 Nov 2011 15:17:10 +0100 (CET)
Received: by ggnr4 with SMTP id r4so1742019ggn.30
	for <alsa-devel@alsa-project.org>; Mon, 21 Nov 2011 06:17:02 -0800 (PST)
In-Reply-To: <20111121133836.GA22906@opensource.wolfsonmicro.com>
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

On Mon, Nov 21, 2011 at 3:38 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Mon, Nov 21, 2011 at 03:14:06PM +0200, Peter Ujfalusi wrote:
>
>> - =A0 =A0 if (!machine_is_omap_4430sdp())
>> + =A0 =A0 if (machine_is_omap_4430sdp())
>> + =A0 =A0 =A0 =A0 =A0 =A0 snd_soc_sdp4430.name =3D "OMAP4 SDP";
>> + =A0 =A0 else if (machine_is_omap4_panda())
>> + =A0 =A0 =A0 =A0 =A0 =A0 snd_soc_sdp4430.name =3D "OMAP4 Panda";
>> + =A0 =A0 else
>
> I'm not thrilled by this given that I'd imagine this'll end up like
> Beagle and have lots of derivatives. =A0Why not just change the string to
> be something generic along the lines of "OMAP4 audio reference design"
> rather than the name of a particular board?

Not sure how to handle this...
Panda does not have Digital Mic, analog Main/Sub mic, and Vibra support in =
HW.
Panda is simple in terms of audio. SDP is more like reference design
with all possible
audio connection.
When I add UCM profiles for SDP/Panda they should be different (due to
different HW), and the best
way is to have different card names for them.
But they can share the same machine driver, since SDP just have more featur=
es.

-- =

P=E9ter
