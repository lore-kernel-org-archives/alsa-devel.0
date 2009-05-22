From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: Disabling HFL/R outputs in twl4030
Date: Fri, 22 May 2009 12:48:28 +0300
Message-ID: <200905221248.28656.peter.ujfalusi@nokia.com>
References: <2C7D3DF36ADFFC479B44490D912B616705F6AC2661@dlee07.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx03.nokia.com (smtp.nokia.com [192.100.122.230])
	by alsa0.perex.cz (Postfix) with ESMTP id 130341038E4
	for <alsa-devel@alsa-project.org>;
	Fri, 22 May 2009 11:48:41 +0200 (CEST)
In-Reply-To: <2C7D3DF36ADFFC479B44490D912B616705F6AC2661@dlee07.ent.ti.com>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "ext Lopez Cruz, Misael" <x0052729@ti.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Friday 22 May 2009 11:44:14 ext Lopez Cruz, Misael wrote:
> It seems that there is no way to disable handsfree L/R outputs for
> twl4030 codec. That means that:
> - handsfree amplifiers are turned-on even if we are not interested
>   in routing through handsfree
> - if the selected input of the handsfree mux is an active DAC
>   (streaming) sound will be produced on hf outputs and the only way
>   to silence them is routing from a different DAC, which doesn't
>   seem like the right solution

Yes, I have also noticed this. Before the voice codec_dai integration it wa=
s =

possible to mute the HFL/R by setting it to Voice. Now with the voice =

codec_dai it is impossible to disable the HFL/R.

I guess ASoC does not have support for per codec_dai DAPM routing, or let's =

put it differently: binding DAPM controls to specific codec_dai.

>
> Currently, handsfree amplifiers are turned-on when the HandsfreeL/R
> muxes are powered by the framework. I was thinking in adding a
> dapm switch to select whether or not handsfree amplifiers should
> be powered, but the switch probably is not the correct approach to
> handle this situation. Maybe a regular kcontrol could be the answer.

It has to be DAPM switch for muting the HFL and the HFR.
In order to execute the pop removal on the HF outputs the bits in the HF =

registers has to be configured in a specific order (REF_EN, RAMP_EN, LOOP_E=
N =

and HB_EN)

The DAPM switch should not change any register bits, but should have variab=
le =

in the twl4030_priv struct to change.

I have the re-written HFL/R pop removal thing without the DAPM mute switch.=
 I =

still need to test it on different HWs, but at least it does look promising=
 at =

the moment.

>
> -Misa

-- =

P=E9ter
