From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: Audio codec volume control
Date: Thu, 20 Sep 2012 13:46:57 +0300
Message-ID: <505AF421.1040906@ti.com>
References: <505ACC37.3060209@st.com> <505AE8C6.3040001@ti.com>
 <505AEB19.7080205@st.com> <505AED95.20400@ti.com> <505AF279.9050906@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog130.obsmtp.com (na3sys009aog130.obsmtp.com
 [74.125.149.143])
 by alsa0.perex.cz (Postfix) with ESMTP id 25B8C2652C8
 for <alsa-devel@alsa-project.org>; Thu, 20 Sep 2012 12:46:03 +0200 (CEST)
Received: by oagl20 with SMTP id l20so1900253oag.38
 for <alsa-devel@alsa-project.org>; Thu, 20 Sep 2012 03:46:02 -0700 (PDT)
In-Reply-To: <505AF279.9050906@st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Rajeev kumar <rajeev-dlh.kumar@st.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On 09/20/2012 01:39 PM, Rajeev kumar wrote:
> Hello Peter,
> =

> On 9/20/2012 3:49 PM, Peter Ujfalusi wrote:
> Thanks for the info.
> =

> Please find below the controls I have provided
> =

> static const char *pwm_mode_text[] =3D { "Binary", "Headphone", "Ternary",
>         "Phase-shift"};
> =

> static const DECLARE_TLV_DB_SCALE(out_gain_tlv, -9150, 50, 0);
> static const DECLARE_TLV_DB_SCALE(master_vol_tlv, -12750, 50, 0);
> static const SOC_ENUM_SINGLE_DECL(pwm_src, STA529_FFXCFG1, 4, pwm_mode_te=
xt);
> =

> static const struct snd_kcontrol_new sta529_snd_controls[] =3D {
>         SOC_DOUBLE_R_TLV("Digital Playback Volume", STA529_LVOL, STA529_R=
VOL, 0,
>                         127, 0, out_gain_tlv),
>         SOC_SINGLE_TLV("Master Playback Volume", STA529_MVOL, 0, 127, 1,
>                         master_vol_tlv),
>         SOC_ENUM("PWM Select", pwm_src),
> };
> =

> So in our amixer output I am not getting any separate numid for left/right
> volume, so that user can control it.

You should have single numid for the stereo control:
amixer sget Digital

amixer sget Master

You should see something like this with the stereo control:

beagle-gentoo dapm # amixer sget Headset
Simple mixer control 'Headset',0
  Capabilities: pvolume penum
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 3
  Mono:
  Front Left: Playback 2 [67%] [0.00dB]
  Front Right: Playback 2 [67%] [0.00dB]

> =

> Is there something I am missing in my code.

Looks fine for me.

-- =

P=E9ter
