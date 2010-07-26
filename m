From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [Fwd: Re: [pulseaudio-discuss] pulseaudio debug
	mode]
Date: Mon, 26 Jul 2010 21:20:58 +0800
Message-ID: <AANLkTinGRA-riu4QiZdrVEb4MDerTNh_Xv=Fk0YFiAco@mail.gmail.com>
References: <1280097015.29696.8.camel@localhost.localdomain>
	<AANLkTimj3W_tgi-+Qqgz-J31u-daOqJ8a2E74qEUzy8U@mail.gmail.com>
	<1280107804.29411.1.camel@localhost.localdomain>
	<AANLkTimoBu3baCYdDWoBQkATrXhG2R2ExYvWybKy1WK_@mail.gmail.com>
	<1280113577.19933.2.camel@localhost.localdomain>
	<AANLkTi=aGfUBy-cF_DoOJVz+XbSc+vUrcKjxtVR6NR=_@mail.gmail.com>
	<i2jkcu$c2o$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
	[209.85.212.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 20546103862
	for <alsa-devel@alsa-project.org>;
	Mon, 26 Jul 2010 15:20:59 +0200 (CEST)
Received: by vws20 with SMTP id 20so2751839vws.38
	for <alsa-devel@alsa-project.org>; Mon, 26 Jul 2010 06:20:59 -0700 (PDT)
In-Reply-To: <i2jkcu$c2o$1@dough.gmane.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2010/7/26 Colin Guthrie <gmane@colin.guthr.ie>

> 'Twas brillig, and Raymond Yau at 26/07/10 04:22 did gyre and gimble:
> > But I have another question ,
> >
> > did update manager stop pulseaudio server when the update manager want to
> > update pulseaudio package ?
> >
> > Actually I don't notice yum -y update stop the PA server if it updated
> > pulseaudio package (install new pulseaudio and remove old pulseaudio
> > package) and restart PA server on Fedora 10
>
> PA is *not* restarted when a new version is installed and I suspect this
> does not happen on Fedora either (but I could be wrong).
>
> The reason is that PA is a per-user daemon, not a system service. If
> three users were logged in, then each of their PA servers would need to
> be killed and restarted but due to console-kit, only the active user
> would get access to the devices which could cause enumeration issues etc.
>
> It could maybe be handled better, but doing so would be rather complex.
>
> Col
>

Yes , I know that PA is not a system service

how do you setup PA for three users logged in with each of  their PA server
running even when you have three sound cards since you will need to hack the
udev rule to exclude the other two sound cards ?

I  got "Too many inputs per sink" error on PA server during software
install/remove on last week when I run pulseaudio on a terminal.

No much info in the server log, the most common PA clients were "tooltips
popup"  when I move the mouse cursor across the different part/icon on the
system bar

Is there any limit on the the number of PA clients connected to PA server ?
