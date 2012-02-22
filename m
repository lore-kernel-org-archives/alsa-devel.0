From: Daniel Mack <zonque@gmail.com>
Subject: Re: [PATCH 0/6] snd-usb endpoint rework, version 6
Date: Wed, 22 Feb 2012 19:50:41 +0100
Message-ID: <4F453901.8040201@gmail.com>
References: <CAE-xCyPcVH-+JKg9m1oNy234LuFDXHSCPz3iaoWQ0Q02YV4JFw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f51.google.com (mail-bk0-f51.google.com
	[209.85.214.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 395A0104120
	for <alsa-devel@alsa-project.org>; Wed, 22 Feb 2012 19:50:45 +0100 (CET)
Received: by bkcjc3 with SMTP id jc3so421127bkc.38
	for <alsa-devel@alsa-project.org>; Wed, 22 Feb 2012 10:50:45 -0800 (PST)
In-Reply-To: <CAE-xCyPcVH-+JKg9m1oNy234LuFDXHSCPz3iaoWQ0Q02YV4JFw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: =?ISO-8859-1?Q?Aur=E9lien_Leblond?= <blablack@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Grant Diffey <gdiffey@gmail.com>, Clemens Ladisch <clemens@ladisch.de>, Felix Homann <linuxaudio@showlabor.de>
List-Id: alsa-devel@alsa-project.org

On 13.02.2012 21:41, Aur=E9lien Leblond wrote:
> Hello everyone,
> =

> My laptop has been in reparation for a while and I just got it back
> now, so I have been out of sync with any update on the snd-usb module,
> the support of the M-Audio Fast Track Ultra, and I now need to
> re-setup my laptop.
> =

> As far as I can see, the kernel 3.2.5 doesn't have the update of Alsa
> 1.0.25, so the first thing I did was to compile those two separately
> (compile first the kernel without any sound support, then compile and
> install 1.0.25), but the midi was then not working on the M-Audio FTU,
> the Roland UA-25Ex and my E-Mu USB keyboard. All modules are probed,
> no messages in dmesg, but jack doesn't see any alsa midi driver.
> In addition, I cannot make out if Daniel's changes are part of this
> release of Alsa!
> =

> My next step was to get a git version of the kernel, add Takashi's
> branch and Daniel's one on top of it (process I used to do 2 months
> ago), but I get a conflicting error when pulling/merging Daniel's
> patch, so I guess it is not in sync with the latest kernel anymore...
> =

> So my questions are:
> - Did I do something wrong with the kernel 3.2.5/alsa 1.0.25 that
> broke the USB Midi or is it a bug? I ran through the mailing list but
> couldn't see anything mentionned about USB Midi. As far as I can tell,
> I have all the necessary modules.
> - What is the status of Daniel's work on the snd-usb module? Again I
> ran through the changelog of alsa 1.0.25 but couldn't make out if it
> was integrated or not.

Sorry for the silence on this topic. I've been distracted by work that
isn't even remotely kernel related during the last weeks, so I lost
track on this. I'll catch up again soon, and review the reports from
around christmas last year, rebase the series and resubmit.

Again, sorry for the delay.

Daniel
