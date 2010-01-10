From: drago01 <drago01@gmail.com>
Subject: Re: HP 6930p mute button/led out of sync;
	fixed by suspend/resume 	cycle
Date: Sun, 10 Jan 2010 15:34:02 +0100
Message-ID: <f6ca9fed1001100634y5a25fd13w9d113b28104ddb31@mail.gmail.com>
References: <f6ca9fed1001100631i46e97d01j17ec5ff4b34cbfd0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f212.google.com (mail-fx0-f212.google.com
	[209.85.220.212])
	by alsa0.perex.cz (Postfix) with ESMTP id 4DBDE246C8
	for <alsa-devel@alsa-project.org>; Sun, 10 Jan 2010 15:34:03 +0100 (CET)
Received: by fxm4 with SMTP id 4so65842085fxm.32
	for <alsa-devel@alsa-project.org>; Sun, 10 Jan 2010 06:34:02 -0800 (PST)
In-Reply-To: <f6ca9fed1001100631i46e97d01j17ec5ff4b34cbfd0@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

On Sun, Jan 10, 2010 at 3:31 PM, drago01 <drago01@gmail.com> wrote:
> Hi,
>
> I experience an odd issue with my HP6930p laptop.
>
> After boot pressing the mute button/led causes the audio to be muted
> but the sate is not reflected in software (i.e the mixer does not show
> the control as muted).
> However pressing after a suspend/resume cycle it works as expected.
> The hardware mute button/led and the software control are in sync
> (pressing the hw button toggles the mixer to mute/unmute; muting the
> software mixer results into the led turning red).
>
> This was with 2.6.31.9 and 2.6.32.1; also installing alsa-drivers from
> source does not change this.
>
> It seems something is not initialized correctly during boot up but is
> done on resume, any pointers on how to debug this?
>

(Resending to correct list)
