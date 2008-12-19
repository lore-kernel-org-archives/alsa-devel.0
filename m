From: "Alex Austin" <circuitsoft.alex@gmail.com>
Subject: Re: somebody ever see ALSA applied in robotics ?
Date: Fri, 19 Dec 2008 16:23:34 -0500
Message-ID: <53baa24a0812191323u57af2b81k9c22ea355cc75a4d@mail.gmail.com>
References: <494C091F.1070405@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from yx-out-1718.google.com (yx-out-1718.google.com [74.125.44.154])
	by alsa0.perex.cz (Postfix) with ESMTP id D4E911037EB
	for <alsa-devel@alsa-project.org>; Fri, 19 Dec 2008 22:23:36 +0100 (CET)
Received: by yx-out-1718.google.com with SMTP id 36so412553yxh.2
	for <alsa-devel@alsa-project.org>; Fri, 19 Dec 2008 13:23:35 -0800 (PST)
In-Reply-To: <494C091F.1070405@gmail.com>
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
To: Ronald <raalst@gmail.com>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

You may be better off working with JACKd than straight-up ALSA.
Also, you may want to look into PureData for your app. I've never used it
though. Can anyone else chime in on this?

- Alex Austin
(651) 238-9273

"...and then I visited Wikipedia ...and the next 8 hours are a blur."


On Fri, Dec 19, 2008 at 3:50 PM, Ronald <raalst@gmail.com> wrote:

> Hi, all,
>
> I'm trying to develop a system which can determine the direction(s)
> sound comes from.
> In the end, it will be put in an R/c submarine, on a gumstix linux board
> (see  http://www.subcommittee.com for my hobby)
>
> But for now, I develop in air, with ubuntu.
> all I want is to record using both the mic channel and the  line in
> (where another 2 mics are attached with a small preamp),
> and I want to record while emitting a chirp, analyzing echo's.
> the concept has been shown to work. see for instance
> http://eddiem.com/projects/chirp/chirp.htm
>
> I am assuming that since all this goes via the same sound card, the same
> crystal is used, and samples from mic and line in are
> essentially synchronized (I only need it to be sync-ish for < 0,1 sec..)
>
> Now I have read a lot of ALSA tutorials and such like, but I'm lost.
> a lot is about humans consuming nice harmonics, sharing and mixing,
> which is not applicable to my case.
> I have the nagging feeling OSS is a better fit for my case, but OSS is
> apparently on a 60 day licence now.
>
> And, I am a newbie coder. no surprise there ;-)
>
> So, these are my questions :
>
> - Do I need to combine mic and line-in into one device using the
> config file ? do I get a 3 channel device then ? does a plug-in add
> latency ?
>
> - can I sync the transmission of a short chirp with the start of the
> recording on these 3 channels ? is starting them close after each other
> in the program OK, or is there possibly large latency caused *after* I
> call the API ? the "real" sync'ing will be the (first) recording of the
> chirp once it leaves the speaker, so it isn't critical, but I would like
> to know because it might save a few bytes useless samples.
>
> - Does anybody out there have any links, code snippets or general
> published info on how to apply ALSA to the robotics field ?
>
> Ps I have read the el-cheapo hack with multiple soundcards, and while a
> very good idea, I cannot use it in the boat later on..
>
> thanks for any input you might have.
>
> Regards,
> Ronald van Aalst
>
>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
