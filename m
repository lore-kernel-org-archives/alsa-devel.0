From: Jean-Yves Avenard <jyavenard@gmail.com>
Subject: Re: 1ca3d59d5a3e762fb1c002bcd912914bc858b430 broke
 passthrough [Was: Re: ALSA 1.0.25 broke AC3 passthrough?]
Date: Wed, 15 Feb 2012 13:09:04 +1100
Message-ID: <CANpj82Ktb8BZiOA50HuR5r0n6NpHk+Y5Bt0uU+mk=01q4VdAPg@mail.gmail.com>
References: <CANpj82JKFx1YXgaY3HZyTSyCZs83ZdvEtYGAbNJPdb6q7qN7kg@mail.gmail.com>
	<4F37BBDD.1090207@iki.fi>
	<CANpj82J+MmYNGbOqmFMCA587sCiUZfjRqDfesfmOG616478SqQ@mail.gmail.com>
	<s5h39ae3lhk.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gy0-f179.google.com (mail-gy0-f179.google.com
	[209.85.160.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 7B708243E0
	for <alsa-devel@alsa-project.org>; Wed, 15 Feb 2012 03:09:05 +0100 (CET)
Received: by ghbg19 with SMTP id g19so439291ghb.38
	for <alsa-devel@alsa-project.org>; Tue, 14 Feb 2012 18:09:04 -0800 (PST)
In-Reply-To: <s5h39ae3lhk.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Anssi Hannula <anssi.hannula@iki.fi>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, Stephen Warren <swarren@nvidia.com>
List-Id: alsa-devel@alsa-project.org

Hi

On 14 February 2012 00:34, Takashi Iwai <tiwai@suse.de> wrote:

> The problem of Nvidia HDMI and the buffer-alignment was already fixed
> in the upstream code. =A0Nvidia HDMI is known to be broken with the
> arbitrary alignment, so it's disabled automatically.

Is the issue believed to be related to nvidia hdmi only ?

I just got the report from a user stating that he had issue playing
audio on his Dell Vostro 200, which is pure intel

> Maybe little people are actually using the released alsa-driver any
> longer.

If they are like me, to get the latest stable version of alsa, they go
to alsa-project.org and download whatever is there. Today that's
1.0.25 and IMHO, that bug is a massive blocker.. I hope it will be
updated soon.

Jean-Yves
