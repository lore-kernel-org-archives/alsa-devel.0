From: Dylan Reid <dgreid@chromium.org>
Subject: Re: Jack detection on HDA vs SoC
Date: Sun, 5 Feb 2012 23:56:40 -0800
Message-ID: <CAEUnVG6rJ4WpNuFy1h=P_CfgYEH3FA4dCucLsU5J2=TebZ1_Qw@mail.gmail.com>
References: <CAEUnVG4AGOk4tTC+KKiY_HgXNZs2wx5dD_mOy0vsaYP-ag24jA@mail.gmail.com>
	<20120204132029.GA7438@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f179.google.com (mail-wi0-f179.google.com
	[209.85.212.179])
	by alsa0.perex.cz (Postfix) with ESMTP id BE97524464
	for <alsa-devel@alsa-project.org>; Mon,  6 Feb 2012 08:57:00 +0100 (CET)
Received: by wibhj6 with SMTP id hj6so4441502wib.38
	for <alsa-devel@alsa-project.org>; Sun, 05 Feb 2012 23:57:00 -0800 (PST)
In-Reply-To: <20120204132029.GA7438@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sat, Feb 4, 2012 at 5:20 AM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Fri, Feb 03, 2012 at 06:01:41PM -0800, Dylan Reid wrote:
>
> You're more likely to get responses to mails if you CC maintainers.
>
>> Is there a plan for the soc code to use the control-based method?
>
> Not exactly. =A0I'm expecting that the new interface will be integrated
> into the generic ALSA jack support rather than done as a custom thing in
> the HDA drivers which will mean that anything supporting accessory
> detect will get support, including ASoC. =A0This stuff should really be
> handled in the core rather than in individual drivers, there's also
> extcon which we'll need to integrate with.
>
>> Is there a consensus on whether new drivers should auto-switch or not?
>
> For embedded systems they definitely should not, it's frequently
> inappropriate (the most common case is things like ringtones which many
> userspaces think should always play to speaker so people can hear them
> even if they have removed their headphones). =A0I think the consensus was
> to move the PC audio to supporting runtime switching between the two
> modes so that if PulseAudio or whatever userspace sound manager is there
> wants to it can take control and do the switching for cases like the
> above.

Thanks for the responses Mark. A control that can disable auto switching
sounds like a good solution to me.  Certainly better than checking for x86 =
or
arm.  I see a couple of drivers already doing this, so I can follow their l=
ead.
