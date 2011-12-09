From: =?ISO-8859-1?Q?Aur=E9lien_Leblond?= <blablack@gmail.com>
Subject: Re: [PATCH 0/5] RFC v2 for snd-usb endpoint logic
	rework
Date: Fri, 9 Dec 2011 21:00:51 +0000
Message-ID: <CAE-xCyPo_6Ace_j0uz07Md6av++F+C49qDWKTmi=r8PmHGDKXg@mail.gmail.com>
References: <1321646744-13656-1-git-send-email-zonque@gmail.com>
	<4EC6BB43.1070503@gmail.com>
	<CAE-xCyPZ5T50CFvcV59rop7+Lkkzp0m+6L+SZv2r47EJw6AiTQ@mail.gmail.com>
	<4EE1122E.7000806@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vx0-f179.google.com (mail-vx0-f179.google.com
	[209.85.220.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 7188C103835
	for <alsa-devel@alsa-project.org>; Fri,  9 Dec 2011 22:00:53 +0100 (CET)
Received: by vcbfl15 with SMTP id fl15so2709512vcb.38
	for <alsa-devel@alsa-project.org>; Fri, 09 Dec 2011 13:00:51 -0800 (PST)
In-Reply-To: <4EE1122E.7000806@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Daniel,

Compiled and running!
So far so good! I haven't pushed the jack parameters more than I would
usually though... I'm still at 16ms latency (Frame/period: 256 ;
Sample Rate: 48000 ; Periods Buffer: 3).
That was the minimum I could go with the previous driver, so I'll try
to push it a bit tomorrow and see how it goes.
Is there any particular testing you would like to see done?

Another thing, in your previous post, you asked to try the driver with
other sound card.
I have an Edirol UA-25Ex that never worked on this machine (I have the
dredded EHCI USB port, it's the reason why I bought the FTU in the
first place).
The error I used to get while starting Jack in Full Duplex with this
sound card was
"Cannot submit datapipe for urb 0, error -28: not enough bandwidth"

But, "apparently".......now it works!
I tried it not later than last week with Kernel 3.0 and it still wasn't wor=
king.

But with 3.2 and your patch, (and after running the FTU on the very
same USB port), I got the UA-25Ex to work in full duplex for the first
time ever.

I don't know if it is due to the new version of the kernel, or your
patch, or something else, but this is huge because a lot of people
used to have this problem with EHCI and USB 1 sound cards.
(or may be it was simply fixed between 3.0 and 3.2 and I simply missed it!).

So the second question is: what do you think?
Any info you would like to see posted here? (dmesg trace....anything else?).

Anyway, thanks a lot for everything :)

Aur=E9lien

On Thu, Dec 8, 2011 at 7:38 PM, Daniel Mack <zonque@gmail.com> wrote:
> Hi Aur=E9lien,
>
> On 12/08/2011 08:33 PM, Aur=E9lien Leblond wrote:
>> I finally got some time to test this driver!
>> I'm not sure I understand where to get Takashi's sound tree.
>>
>> I tried to apply your patch against a clone of
>> git://git.alsa-project.org/alsa-kmirror.git alsa-kmirror, but then
>> GitCompile failed.
>>
>> I then tried to use
>> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git , but
>> I'm not even sure what I'm pulling to be honest...
>>
>> Would you mind just guiding me on how to prepare the source code?
>
> No problem :)
>
> Clone Linus' tree:
>
> =A0git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>
> Make a local branch and pull in Takashi's tree:
>
> =A0cd linux
> =A0git checkout -b alsa
> =A0git pull git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git
> master
>
> Make another branch on top of that
>
> =A0git checkout -b usbaudio
>
> Then apply my patch(es). For the next round, just kill the local
> usbaudio branch again and start over:
>
> =A0git reset --hard
> =A0git checkout alsa
> =A0git branch -D usbaudio
> =A0git checkout -b usbaudio
>
> Then apply the next round :)
>
>> Thanks in advance, and thanks for all the work you have already done!
>
> No problem. I'm planning to continue work on this these days. It's just
> that I'm constantly distracted by other things :-/
>
> Daniel
