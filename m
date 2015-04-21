From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Pop noise on startup when headphones are plugged
 in (Dell XPS13 9333)
Date: Tue, 21 Apr 2015 10:13:53 +0800
Message-ID: <CAN8cciZhM8tMboUTDU05A=GuACaGuzhx-szL85GfzSMGYzCVXA@mail.gmail.com>
References: <23057263.IjMh4t6SYF@xps13> <s5h618rwdc8.wl-tiwai@suse.de>
 <3004927.Zk5y6zPyn3@xps13>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ob0-f176.google.com (mail-ob0-f176.google.com
 [209.85.214.176])
 by alsa0.perex.cz (Postfix) with ESMTP id B16E5260696
 for <alsa-devel@alsa-project.org>; Tue, 21 Apr 2015 04:13:54 +0200 (CEST)
Received: by obfe9 with SMTP id e9so133703762obf.1
 for <alsa-devel@alsa-project.org>; Mon, 20 Apr 2015 19:13:53 -0700 (PDT)
In-Reply-To: <3004927.Zk5y6zPyn3@xps13>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Gabriele Mazzotta <gabriele.mzt@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

> > >
> > > Hi,
> > >
> > > I've recently found that commit a551d91473 ("ALSA: hda - Use regmap
for
> > > command verb caches, too") is somehow causing a pop noise on startup
> > > when headphones are plugged in, but I couldn't figure out the exact
> > > cause. Was this observed on other systems (mine is a Dell XPS13 9333,
> > > Realtek ALC3661)? Does anyone have any idea of what the cause might
be?
> >
> > Are you sure that the commit is the culprit?  There are lots of other
> > changes like the widget-based power saving.
>
> Quite sure. I did a bisection to get it. 5e56bcea5017 ("ALSA: hda -
> Allow driver to add vendor-specific verbs for regmap") is OK.
> Also, if I revert a551d91473 in the current linux-next tree, the
> startup noise goes away.
>
> > In anyway, please give alsa-info.sh output.
>
> http://www.alsa-project.org/db/?f=7d283ebf64ca750482ec5ed6174a1b860fa70631
>

Did you use headset or headphone since the capture source control is used
to determine the function of multi-role combo jack when the codec cannot
dinstingush headset, headphone and mic jack ?
