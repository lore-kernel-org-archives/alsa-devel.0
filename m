From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Mixer volume/decibel mapping
Date: Thu, 20 May 2010 16:53:14 +0800
Message-ID: <AANLkTilKqn_X3FUdDmCqy3YKdYeT47oIGGaqUitzruDk@mail.gmail.com>
References: <201005191834.57919.vand2@gmx.de>
	<AANLkTimQtKql4p3UEs2Wh_tZ6YhzLGgl1q5G18A1y9Jk@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pz0-f189.google.com (mail-pz0-f189.google.com
	[209.85.222.189])
	by alsa0.perex.cz (Postfix) with ESMTP id A97942444A
	for <alsa-devel@alsa-project.org>;
	Thu, 20 May 2010 10:53:15 +0200 (CEST)
Received: by pzk27 with SMTP id 27so5698908pzk.2
	for <alsa-devel@alsa-project.org>; Thu, 20 May 2010 01:53:14 -0700 (PDT)
In-Reply-To: <AANLkTimQtKql4p3UEs2Wh_tZ6YhzLGgl1q5G18A1y9Jk@mail.gmail.com>
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

2010/5/20 James Courtier-Dutton <james.dutton@gmail.com>

> On 19 May 2010 17:34, Sebastian H. <vand2@gmx.de> wrote:
> >
> > Hello everyone
> >
> > I'm working on an ALSA-Mixer application for C++/Qt4 and stumbled over
> > volume and decibel mapping for sliders.
> > My question: Is there always an 1 to 1 mapping from volume to decibel and
> vice
> > versa or can there be decibel values in between two volume steps?
> >
>
> There should be a one to one mapping.
> If the hardware has 200 steps on the volume scale, and those 200 steps
> are published to the user.
> With the dB scale, there will still be the same 200 steps in the dB scale.
> The dB information simply helps the user interface convert each step
> into a dB value.
>

a stepping function is not continuous and this is why
snd_mixer_selem_set_playback_dB() cannot set decibel values in between two
volume steps
