From: Vinod <vkoul@kernel.org>
Subject: Re: [PATCH] ASoC: qcom: add sdm845 sound card support
Date: Wed, 20 Jun 2018 15:01:06 +0530
Message-ID: <20180620093106.GI13316@vkoul-mobl>
References: <1529320591-22434-1-git-send-email-rohitkr@codeaurora.org>
 <20180619050527.GR25852@vkoul-mobl>
 <8562b574-3738-8983-53e7-64366590fad4@codeaurora.org>
 <20180619162230.GF13316@vkoul-mobl>
 <f7891675-4c98-7fc6-b80f-840ada9a1c5b@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by alsa0.perex.cz (Postfix) with ESMTP id 241D42673CB
 for <alsa-devel@alsa-project.org>; Wed, 20 Jun 2018 11:31:15 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <f7891675-4c98-7fc6-b80f-840ada9a1c5b@codeaurora.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Rohit Kumar <rohitkr@codeaurora.org>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, bgoswami@codeaurora.org, linux-kernel@vger.kernel.org, plai@codeaurora.org, tiwai@suse.com, lgirdwood@gmail.com, robh+dt@kernel.org, broonie@kernel.org, srinivas.kandagatla@linaro.org
List-Id: alsa-devel@alsa-project.org

Hi Rohit,

On 20-06-18, 13:07, Rohit Kumar wrote:
> > On 19-06-18, 19:20, Rohit Kumar wrote:
> > > On 6/19/2018 10:35 AM, Vinod wrote:
> > > > On 18-06-18, 16:46, Rohit kumar wrote:
> > > > =

> > > > > +struct sdm845_snd_data {
> > > > > +	struct snd_soc_card *card;
> > > > > +	struct regulator *vdd_supply;
> > > > > +	struct snd_soc_dai_link dai_link[];
> > > > > +};
> > > > > +
> > > > > +static struct mutex pri_mi2s_res_lock;
> > > > > +static struct mutex quat_tdm_res_lock;
> > > > any reason why the locks can't be part of sdm845_snd_data?
> > > > Also why do we need two locks ?
> > > No specific reason, I will move it to sdm845_snd_data.
> > > These locks are used to protect enable/disable of bit clocks. We have
> > > Primary MI2S RX/TX
> > > and Quaternary TDM RX/TX interfaces. For primary mi2s rx/tx, we have =
single
> > > clock which is
> > > synchronized with pri_mi2s_res_lock. For Quat TDM RX/TX, we are using
> > > quat_tdm_res_lock.
> > > We need two locks as we are protecting two different resources.
> > I think bigger question is why do you need any locks? What is the race
> > scenario you envision which needs protection
> > =

> =

> Below is one of the race condition:
> =

> Thread1=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0=A0=A0 =
|=A0=A0=A0=A0=A0=A0=A0=A0 Thread2
> ----------------------------------------------------------
> startup()=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 |
> count++;=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 |=A0=A0=A0 startup()
> read count (count =3D 1) |
> enable_clock()=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=A0=A0=A0 count=
++;=A0=A0 //count =3D 2
> shutdown()=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 |
> count--;// count =3D 1=A0=A0=A0=A0=A0 |
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | read count (count =3D 1)
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | enable_clock()
> =

> Here clock will be enabled twice but disable will be called only once when
> count =3D 0.
> =

> This will make the clock always enabled. So, I think we should keep either
> mutex lock or atomic variable to synchronize this.

we are using DPCM here right?

-- =

~Vinod
