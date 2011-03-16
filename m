From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [PATCH 1/2 v2] ALSA: Add snd_ctl_update() to
 dynamically update a control
Date: Wed, 16 Mar 2011 16:05:01 +0800
Message-ID: <AANLkTikYQ1G7wB9DapU-np_y0TJzY_cQEpvP-4UOmCpf@mail.gmail.com>
References: <1300192269-20435-1-git-send-email-dp@opensource.wolfsonmicro.com>
	<4D7F7516.7050009@ladisch.de>
	<20110315162728.GA27777@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51])
	by alsa0.perex.cz (Postfix) with ESMTP id DA24D1038DE
	for <alsa-devel@alsa-project.org>; Wed, 16 Mar 2011 09:05:03 +0100 (CET)
Received: by fxm6 with SMTP id 6so1310950fxm.38
	for <alsa-devel@alsa-project.org>; Wed, 16 Mar 2011 01:05:02 -0700 (PDT)
In-Reply-To: <20110315162728.GA27777@opensource.wolfsonmicro.com>
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

2011/3/16 Dimitris Papastamos <dp@opensource.wolfsonmicro.com>

> On Tue, Mar 15, 2011 at 03:17:58PM +0100, Clemens Ladisch wrote:
>
>
> > > A separate patch needs to be made to make ALSA Mixer cope with this.
> >
> > What happens?
>
> It doesn't break or anything hopefully.  It will probably need support for
> handling the update of the controls (without exiting and starting it
> again).  I've only tested it against alsa-utils 1.0.20 and it worked
> fine with a few changes (updating the controls on the fly).
>
>
It depend on how the driver update control, since snd_mixer_selem just
combine "volume" and "switch" controls of same name into a single selem

if the driver just change the name of volume control, I guess alsamixer
still need to reload the mixer
