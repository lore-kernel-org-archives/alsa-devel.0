From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: ALSA changes in 2.6.23-rc6 for Intel HDA
Date: Thu, 13 Sep 2007 15:20:07 -0400
Message-ID: <9e4733910709131220n62473a60v69a36d2e314bc920@mail.gmail.com>
References: <9e4733910709110958h5756a50fi7540fe9d654d1557@mail.gmail.com>
	<200709131916.47518.maximlevitsky@gmail.com>
	<9e4733910709131015y7c1d4238ue4ee97ef5bff1e29@mail.gmail.com>
	<200709132136.18387.maximlevitsky@gmail.com>
	<9e4733910709131209i3d6781e8pa60039fbb497dc6c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.177])
	by alsa0.perex.cz (Postfix) with ESMTP id D93D22438F
	for <alsa-devel@alsa-project.org>;
	Thu, 13 Sep 2007 21:20:08 +0200 (CEST)
Received: by wa-out-1112.google.com with SMTP id m33so725686wag
	for <alsa-devel@alsa-project.org>; Thu, 13 Sep 2007 12:20:07 -0700 (PDT)
In-Reply-To: <9e4733910709131209i3d6781e8pa60039fbb497dc6c@mail.gmail.com>
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
To: Maxim Levitsky <maximlevitsky@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 9/13/07, Jon Smirl <jonsmirl@gmail.com> wrote:
> On 9/13/07, Maxim Levitsky <maximlevitsky@gmail.com> wrote:
> > Can you tell me exact version of kernel that allowed you to set higher volume,
> > and can you test whenever you actually can set louder volumes on that kernel, maybe it has a bug
>
>
> I was working fine  2.6.23-rc4 for sure and I also believe  2.6.23-rc5 was ok.
>  2.6.23-rc6 is not ok.
>
> But I can't rule out that this has nothing to do with the kernel and
> instead it was cause by an auto update of some ubuntu package.
>
> It is the current system that is not working ok for me.
>
> I have my powered speakers set to full volume.
> I have PCM set to full volume.
> I have to set the front speakers to 36% before I can detect they are
> making sound.
> I still have full dynamic range if I set the front speakers to 100%.
>
> Here's a another clue. I have alsamixer running in a window. I change
> the volume control with the gnome panel applet. It is changing the
> volume for the Front Speaker column. Shouldn't it be changing the PCM
> column?
>
> If I set Front back to 79 and use PCM to control the volume things
> appear to be working like they used to. Did something cause the Gnome
> Volume Control Applet to start controlling a different column?

I see now that there is a preference in the Gnome Volume Control
applet and in System/Preferences/Sound for setting which channel is
controlled. In both cases nothing was selected on my system. It seems
that the default when nothing is selected is to control the Front
Speaker channel.

I've set both of these to PCM and now things are working like there were before.

This behavior correlates with what I believe was the name of the PCM
channel changing from 'pcm' to 'PCM'. The selection boxes still wanted
to use the old name which wasn't a choice anymore.

-- 
Jon Smirl
jonsmirl@gmail.com
