From: Mark Goldstein <goldstein.mark@gmail.com>
Subject: Re: Problem with VIA VT1708S and git versions of
	alsa-driver.
Date: Tue, 28 Sep 2010 13:32:57 +0200
Message-ID: <AANLkTinYcRqMwH2FSUjXiOxZg4x09q673FL9m15YvXEa@mail.gmail.com>
References: <AANLkTikaYCybUxW7dE3tizYZztT8pVo6Jeg-mh=e0NqZ@mail.gmail.com>
	<AANLkTi=UTy8tdLqL-90UJOXtU=Ks1+ZZrGV2nCbw=xjD@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-iw0-f179.google.com (mail-iw0-f179.google.com
	[209.85.214.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 74037103803
	for <alsa-devel@alsa-project.org>;
	Tue, 28 Sep 2010 13:33:20 +0200 (CEST)
Received: by iwn4 with SMTP id 4so997554iwn.38
	for <alsa-devel@alsa-project.org>; Tue, 28 Sep 2010 04:33:19 -0700 (PDT)
In-Reply-To: <AANLkTi=UTy8tdLqL-90UJOXtU=Ks1+ZZrGV2nCbw=xjD@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi,

On Tue, Sep 28, 2010 at 2:00 AM, Raymond Yau
<superquad.vortex2@gmail.com> wrote:
> 2010/9/25 Mark Goldstein <goldstein.mark@gmail.com>
>
>> Hello,
>>
>> Recently I'm having some strange issues with my VIA VT1708S on-board
>> sound card. The description might be a bit long, so I'll give a brief
>> summary first.
>>
>> I have ASUS P5QL/EPU motherboard with VT1708S 8-channel HDA Codec.
>> There are 3 OSs installed on this machine: openSUSE 11.1 (my main
>> system), openSUSE 11.3, Kubuntu 10.04.
>> Audio worked fine until some updates at the beginning of September.
>> Since then I have 2 different issues.
>>
>> 1).On 11.1 - Line In control seems inactive, instead Front Mic control
>> controls the level from Line In jack. Front Mic is constanly disabled.
>> alsaconf does not show hda-intel in the list of detected cards.
>> Latest version it happened with is git20100925.
>> When I compiled stable 1.0.23 sources, everything started working as
>> expected again.
>> I reported this issue on bugtrack:
>> https://bugtrack.alsa-project.org/alsa-bug/view.php?id=3D5133
>>
>> 2) On oS 11.3 I start experiencing problems recording audio either
>> from Mic or from Line.
>> After some experiments I found out that the Capture1 control is
>> somehow broken. Mute switch is reversed. When it is unmuted, there is
>> no audio recorded. When it is muted, recording works. The same
>> happened to at least one more user of openSUSE, see the thread "How to
>> investigate the problem with MIC" on alsa-user mailing list.
>> I've also added my comments to issue
>> https://bugtrack.alsa-project.org/alsa-bug/view.php?id=3D5130 but now I
>> think it is different issue.
>> Even when I have audio recorded normally when Capture1 is muted, I
>> still have very distorted voice from Mic in Skype. It worked fine
>> before the problem started.
>>
>> More details:
>> On oS 11.1 I had my audio working fine after updating to 1.0.23
>> versions of alsa driver. I'm using opensuse/multimedia: repository
>> that provides binary rpm of alsa-driver git snapshots.
>> I have only one current kernel 2.6.27.48 on 11.1.
>> On oS 11.3 audio worked right out of the box, since it uses kernels
>> with alsa-driver 1.0.23. I have 2-3 kernels installed at the same time
>> - normal 2.6.34 from official repository and 2.6.35 from kernel build
>> service.
>>
>> I'm not sure when exactly the problems started, but definitely at the
>> beginning of September.
>>
>> I've initially saw that on oS 11.1 I can't hear the audio from my TV
>> card connected to Line In. Then I noticed that Mic does not work in
>> Skype on both 11.1 and 11.3, while it still works on Kubuntu. When I
>> unmuted Front Mic on 11.1 I've suddenly found that it actually enabled
>> Line In.
>> I think now that something went bad with card detecting. Probably on
>> 11.1 with latest git versions my card is not properly detected and
>> some "defaults" are used.
>>
>> I'm attaching here 2 outputs of alsa-info.sh -
>> =A011.1_stable captured with alsa-driver compiled from stable 1.0.23 sou=
rces.
>> =A011.1_git25 captured with driver compiled with git20100925 version
>> from opensuse/multimedia: repository.
>>
>> For me the problem with 11.1 is resolved, but probably it's worth
>> checking why latest version from git behave this way.
>>
>> I'll continue with 11.3 investigation later on.
>>
>> Regards,
>> --
>> Mark Goldstein
>>
>>
> In theory, a motherboard with 6 audio jacks at back panel does not need
> retasking pink and blue jacks as output pins , it seem to me that the
> "smart5.1" switch is redundant for your motherboard.
>
> it seem this patch may has side effect on those via codec since they need=
 to
> differentate the front mic and mic at rear panel for retasking
>
> http://git.alsa-project.org/?p=3Dalsa-kernel.git;a=3Dcommitdiff;h=3Dbbe95=
9733a719ecffda8ecd7d4b9631a2745e8b4;hp=3D6650d30dfe1cf9ef6e639bd898d3b2f637=
f4bf3b

Looks like a possibility.

What bothers me is the fact that with git version the card is not
detected properly (on oS 11.1). I missed this detail in my report just
because I did not try alsaconf after the problem first occurred.
That is, alsaconf does not show it in the list of cards.
So I guess that the sound driver uses some defaults (it does indicate
the this is hda-intel) that just does not match the actual codec.
While when I use stable 1.0.23 version card is detected by alsaconf
and works correctly.

>From the other side, the problem on oS 11.3 looks very different.
I did not update driver there, just installed additional kernel that
also has alsa 1.0.23.

How it could lead to "Capture1" switch "reversing"? And now when I
found it out and set it to "mute", Mic works correctly with recording
SW and produces distorted audio in Skype in exactly the same
configuration where it worked perfectly a couple of weeks ago.

Regards,
-- =

Mark Goldstein
