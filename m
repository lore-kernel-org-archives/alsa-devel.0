From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [RFC don't apply] ASoC: Add support for optional
 auxiliary dailess codecs
Date: Fri, 26 Nov 2010 15:35:48 +0200
Message-ID: <20101126153548.a5a5f3c6.jhnikula@gmail.com>
References: <1290700058-9270-1-git-send-email-jhnikula@gmail.com>
	<20101125213145.GB25162@opensource.wolfsonmicro.com>
	<20101126092524.ea7cf74d.jhnikula@gmail.com>
	<201011261419.42933.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com
	[209.85.215.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 3B79F103D14
	for <alsa-devel@alsa-project.org>; Fri, 26 Nov 2010 14:35:22 +0100 (CET)
Received: by ewy19 with SMTP id 19so960199ewy.38
	for <alsa-devel@alsa-project.org>; Fri, 26 Nov 2010 05:35:22 -0800 (PST)
In-Reply-To: <201011261419.42933.peter.ujfalusi@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Fri, 26 Nov 2010 14:19:42 +0200
Peter Ujfalusi <peter.ujfalusi@nokia.com> wrote:

> We could as well see these things as components on the audio path.
> A standard CODEC would have DAI + DAPM (analog/digital routings, amps) + gain 
> controls.
> In case of an external amplifier we only have the DAPM part + gain control.
> 
> If a component has DAI, than the normal PCM operations would apply to them, if 
> the component does not have DAI, than those are not applicable.
> I'm not sure, but I think we do have some level of separation of DAPM and PCM 
> operations, right? So why not to utilize, and extend that route?
> All component drivers would use the same registration, core would knows which 
> component has DAI, and which does not. Machine driver could specify a list of 
> components, provides the DAPM connection between the components.
> 
> If DAPM core knows which widget belongs to which component, than I see no real 
> problem with this method. The DAPM would work just fine. The PCM operatins would 
> only apply to component with DAI.
> 
Actually these are already well separated in current ASoC. Like my RFC
patch didn't not need touch soc-dapm.c at all and efectively other
changes were around codec probing/removal and by not registering the
PCM.

> > If I counted correctly we have currently only three amplifier drivers:
> > tpa6130a2.c, wm2000.c and wm9090.c so separation doesn't sound worth of
> > trouble at this point as the core serves well those cases also.
> 
> One more: max9877, if I recall correctly that was the first amp driver?
> 
Yeah, true. Looks like wm9090.c doesn't need any conversion after we
are able to register dailess codecs but those three can be then
converted to use standard probing mechanism and let them register itself
own widgets and controls. I.e. machine drivers don't need to call those
tailored _add_controls functions.


-- 
Jarkko
