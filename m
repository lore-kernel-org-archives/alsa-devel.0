From: pl bossart <bossart.nospam@gmail.com>
Subject: Re: snd_hda_intel error
Date: Tue, 7 Dec 2010 08:08:55 -0600
Message-ID: <AANLkTikThHiVi7uW37+Y4hbqkeE3WB54sYsc9OHyCAb=@mail.gmail.com>
References: <AANLkTik8eGoD1WfJvLZtzWQ-6W=WkjxtQHjJsZ4WN9DX@mail.gmail.com>
	<AANLkTimUryfsGeiuiATCeBoeFjKqYkJYabqR6+Fj1u5x@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-iw0-f179.google.com (mail-iw0-f179.google.com
	[209.85.214.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 4E973103A73
	for <alsa-devel@alsa-project.org>; Tue,  7 Dec 2010 15:08:56 +0100 (CET)
Received: by iwn41 with SMTP id 41so1306771iwn.38
	for <alsa-devel@alsa-project.org>; Tue, 07 Dec 2010 06:08:55 -0800 (PST)
In-Reply-To: <AANLkTimUryfsGeiuiATCeBoeFjKqYkJYabqR6+Fj1u5x@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jack Byer <ftn768@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sat, Dec 4, 2010 at 7:38 AM, Jack Byer <ftn768@gmail.com> wrote:
> I neglected to include this line from dmesg
>
> hda-intel: IRQ timing workaround is activated for card #1. Suggest a
> bigger bdl_pos_adj.
>
> I don''t know if that is related or not.

No it's not. I provided a fix for this bug in alsa-lib.
http://git.alsa-project.org/?p=alsa-lib.git;a=commit;h=aba87e509898ec9ddb3e319267d7c267409ff100
You can implement a work-around by using hardware devices in your
mixer profile instead of front:
-Pierre
