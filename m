From: "Pharaoh ." <pharaoh137@gmail.com>
Subject: Re: Steps get aplay and arecord working on an embedded
	board
Date: Fri, 22 Jun 2007 17:06:07 +0530
Message-ID: <61445c750706220436w1e525768h40baad5fc76b37d7@mail.gmail.com>
References: <61445c750706220411ted88f4bk4b321e5831acb4f8@mail.gmail.com>
	<8d6898730706220423m50b9f22bj5b974c7d3d79ebfd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nz-out-0506.google.com (nz-out-0506.google.com [64.233.162.229])
	by alsa0.perex.cz (Postfix) with ESMTP id 5C744244FE
	for <alsa-devel@alsa-project.org>;
	Fri, 22 Jun 2007 13:36:08 +0200 (CEST)
Received: by nz-out-0506.google.com with SMTP id j2so789507nzf
	for <alsa-devel@alsa-project.org>; Fri, 22 Jun 2007 04:36:07 -0700 (PDT)
In-Reply-To: <8d6898730706220423m50b9f22bj5b974c7d3d79ebfd@mail.gmail.com>
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
To: Nobin Mathew <nobin.mathew@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Thanks Nobin, but I have few queries:

1. /proc/asound is as expected.
2. I have set my default mixer settings in driver itself, so can I
bypass setting them once gain through mixer interface? Can I not use
mixer interface currently?
3. What does alsa.conf do? What about .asoundrc ? I am not familier
with these things and don't know how should I set them up if needed.
4. Basically, I have just configured and compiled the alsa-lib and
utils and got them on the board.

5.When I use aplay directly then it just hangs at the very first step
i.e. hangs after execv(aplay), strace showed it.



On 6/22/07, Nobin Mathew <nobin.mathew@gmail.com> wrote:
> First check the /proc/asound to see it is as expected.
>
> Then use amixer to  set the setting
> like enable playback/capture and set the volume etc.
>
> Now use aplay or arecord
>
> aplay/arecord --help will give more information
>
> Nobin
>
> On 6/22/07, Pharaoh . <pharaoh137@gmail.com> wrote:
> > Hi
> > I have to test my audio driver on an omap based board. I have got the lib
> and
> > utils on my board but dont know the exact steps to follow for using aplay
> etc.
> >
> > Can anyone point me to relevant documentation? Couldn't find any. Or just
> brief
> > outline about the steops to follow would be great help.
> >
> > -pharaoh
> > _______________________________________________
> > Alsa-devel mailing list
> > Alsa-devel@alsa-project.org
> > http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> >
>
