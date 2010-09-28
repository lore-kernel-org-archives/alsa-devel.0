From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Problem with VIA VT1708S and git versions of
	alsa-driver.
Date: Tue, 28 Sep 2010 08:00:42 +0800
Message-ID: <AANLkTi=UTy8tdLqL-90UJOXtU=Ks1+ZZrGV2nCbw=xjD@mail.gmail.com>
References: <AANLkTikaYCybUxW7dE3tizYZztT8pVo6Jeg-mh=e0NqZ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com
	[209.85.215.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 81E931037FB
	for <alsa-devel@alsa-project.org>;
	Tue, 28 Sep 2010 02:00:43 +0200 (CEST)
Received: by ewy21 with SMTP id 21so1609751ewy.38
	for <alsa-devel@alsa-project.org>; Mon, 27 Sep 2010 17:00:42 -0700 (PDT)
In-Reply-To: <AANLkTikaYCybUxW7dE3tizYZztT8pVo6Jeg-mh=e0NqZ@mail.gmail.com>
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

2010/9/25 Mark Goldstein <goldstein.mark@gmail.com>

> Hello,
>
> Recently I'm having some strange issues with my VIA VT1708S on-board
> sound card. The description might be a bit long, so I'll give a brief
> summary first.
>
> I have ASUS P5QL/EPU motherboard with VT1708S 8-channel HDA Codec.
> There are 3 OSs installed on this machine: openSUSE 11.1 (my main
> system), openSUSE 11.3, Kubuntu 10.04.
> Audio worked fine until some updates at the beginning of September.
> Since then I have 2 different issues.
>
> 1).On 11.1 - Line In control seems inactive, instead Front Mic control
> controls the level from Line In jack. Front Mic is constanly disabled.
> alsaconf does not show hda-intel in the list of detected cards.
> Latest version it happened with is git20100925.
> When I compiled stable 1.0.23 sources, everything started working as
> expected again.
> I reported this issue on bugtrack:
> https://bugtrack.alsa-project.org/alsa-bug/view.php?id=5133
>
> 2) On oS 11.3 I start experiencing problems recording audio either
> from Mic or from Line.
> After some experiments I found out that the Capture1 control is
> somehow broken. Mute switch is reversed. When it is unmuted, there is
> no audio recorded. When it is muted, recording works. The same
> happened to at least one more user of openSUSE, see the thread "How to
> investigate the problem with MIC" on alsa-user mailing list.
> I've also added my comments to issue
> https://bugtrack.alsa-project.org/alsa-bug/view.php?id=5130 but now I
> think it is different issue.
> Even when I have audio recorded normally when Capture1 is muted, I
> still have very distorted voice from Mic in Skype. It worked fine
> before the problem started.
>
> More details:
> On oS 11.1 I had my audio working fine after updating to 1.0.23
> versions of alsa driver. I'm using opensuse/multimedia: repository
> that provides binary rpm of alsa-driver git snapshots.
> I have only one current kernel 2.6.27.48 on 11.1.
> On oS 11.3 audio worked right out of the box, since it uses kernels
> with alsa-driver 1.0.23. I have 2-3 kernels installed at the same time
> - normal 2.6.34 from official repository and 2.6.35 from kernel build
> service.
>
> I'm not sure when exactly the problems started, but definitely at the
> beginning of September.
>
> I've initially saw that on oS 11.1 I can't hear the audio from my TV
> card connected to Line In. Then I noticed that Mic does not work in
> Skype on both 11.1 and 11.3, while it still works on Kubuntu. When I
> unmuted Front Mic on 11.1 I've suddenly found that it actually enabled
> Line In.
> I think now that something went bad with card detecting. Probably on
> 11.1 with latest git versions my card is not properly detected and
> some "defaults" are used.
>
> I'm attaching here 2 outputs of alsa-info.sh -
>  11.1_stable captured with alsa-driver compiled from stable 1.0.23 sources.
>  11.1_git25 captured with driver compiled with git20100925 version
> from opensuse/multimedia: repository.
>
> For me the problem with 11.1 is resolved, but probably it's worth
> checking why latest version from git behave this way.
>
> I'll continue with 11.3 investigation later on.
>
> Regards,
> --
> Mark Goldstein
>
>
In theory, a motherboard with 6 audio jacks at back panel does not need
retasking pink and blue jacks as output pins , it seem to me that the
"smart5.1" switch is redundant for your motherboard.

it seem this patch may has side effect on those via codec since they need to
differentate the front mic and mic at rear panel for retasking

http://git.alsa-project.org/?p=alsa-kernel.git;a=commitdiff;h=bbe959733a719ecffda8ecd7d4b9631a2745e8b4;hp=6650d30dfe1cf9ef6e639bd898d3b2f637f4bf3b
