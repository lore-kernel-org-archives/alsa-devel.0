From: Daniel Mack <zonque@gmail.com>
Subject: Re: [PATCH 1/3] ALSA: snd-usb: Accept UAC2 FORMAT_TYPE
 descriptors with bLength > 6
Date: Sat, 6 Aug 2011 10:29:10 +0200
Message-ID: <CACTFLAMcJr61wN5wPJu41q1-RkytFK_hVr8nUoqDA2tbxLkMKQ@mail.gmail.com>
References: <1312466188-3428-1-git-send-email-zonque@gmail.com>
	<1312466188-3428-2-git-send-email-zonque@gmail.com>
	<s5h1ux1l18a.wl%tiwai@suse.de> <4E3AAA06.3020204@ladisch.de>
	<CACTFLAN70my5TZmGvvU+547hhdq75Zvia+gi3Xpz-1BNfchkwg@mail.gmail.com>
	<s5hwretjlpt.wl%tiwai@suse.de>
	<CACTFLAOE3rLMxQudckLjCmSKt4srPvVEceNEF=pttys9QEsjvA@mail.gmail.com>
	<s5h7h6rar0r.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pz0-f43.google.com (mail-pz0-f43.google.com
	[209.85.210.43]) by alsa0.perex.cz (Postfix) with ESMTP id 0820D24332
	for <alsa-devel@alsa-project.org>;
	Sat,  6 Aug 2011 10:29:11 +0200 (CEST)
Received: by pzk1 with SMTP id 1so4499454pzk.2
	for <alsa-devel@alsa-project.org>; Sat, 06 Aug 2011 01:29:10 -0700 (PDT)
In-Reply-To: <s5h7h6rar0r.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

On Aug 6, 2011 10:22 AM, "Takashi Iwai" <tiwai@suse.de> wrote:
>
> At Sat, 6 Aug 2011 09:26:11 +0200,
> Daniel Mack wrote:
> >
> > On Thu, Aug 4, 2011 at 4:27 PM, Takashi Iwai <tiwai@suse.de> wrote:
> > > They'll be included in the next pull request to 3.1 (maybe after merge
> > > window).
> >
> > As they fix real bugs, don't you think it would be justified to go in
> > for 3.0? Also given that -rc1 isn't even released yet?
>
> 3.0 was finished.  The upcoming release is 3.1-rc1, but I don't want
> to bother Linus too much during his vacation, unless a critical
> regression (i.e. not "normal" bug) fix appears.

Tss, sorry. Early-morning confusion on my side of course.

Daniel
