From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [RFC don't apply] ASoC: Add support for optional
	auxiliary dailess codecs
Date: Fri, 26 Nov 2010 14:19:42 +0200
Message-ID: <201011261419.42933.peter.ujfalusi@nokia.com>
References: <1290700058-9270-1-git-send-email-jhnikula@gmail.com>
	<20101125213145.GB25162@opensource.wolfsonmicro.com>
	<20101126092524.ea7cf74d.jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-sa01.nokia.com (smtp.nokia.com [147.243.1.47])
	by alsa0.perex.cz (Postfix) with ESMTP id 46D541037FF
	for <alsa-devel@alsa-project.org>; Fri, 26 Nov 2010 13:19:53 +0100 (CET)
In-Reply-To: <20101126092524.ea7cf74d.jhnikula@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Hi,

On Friday 26 November 2010 09:25:24 ext Jarkko Nikula wrote:
> And codecs can be used as an amplifer only by not connecting the DAI.
> Like if codec chip is cheaper or better available than amplifier or if
> multicodec package saves board space compared to separate codec and
> amplifier chips.

We could as well see these things as components on the audio path.
A standard CODEC would have DAI + DAPM (analog/digital routings, amps) + ga=
in =

controls.
In case of an external amplifier we only have the DAPM part + gain control.

If a component has DAI, than the normal PCM operations would apply to them,=
 if =

the component does not have DAI, than those are not applicable.
I'm not sure, but I think we do have some level of separation of DAPM and P=
CM =

operations, right? So why not to utilize, and extend that route?
All component drivers would use the same registration, core would knows whi=
ch =

component has DAI, and which does not. Machine driver could specify a list =
of =

components, provides the DAPM connection between the components.

If DAPM core knows which widget belongs to which component, than I see no r=
eal =

problem with this method. The DAPM would work just fine. The PCM operatins =
would =

only apply to component with DAI.

> If I counted correctly we have currently only three amplifier drivers:
> tpa6130a2.c, wm2000.c and wm9090.c so separation doesn't sound worth of
> trouble at this point as the core serves well those cases also.

One more: max9877, if I recall correctly that was the first amp driver?

-- =

P=E9ter
