From: Daniel Chen <seven.steps@gmail.com>
Subject: Re: [PATCH] ALSA: hda: Use 3stack quirk for some
	broken Dell models
Date: Fri, 6 Nov 2009 12:49:10 -0500
Message-ID: <604760770911060949o690c79b1tb157beaf5b1681a1@mail.gmail.com>
References: <730569.68030.qm@web112605.mail.gq1.yahoo.com>
	<s5h639pcuqt.wl%tiwai@suse.de>
	<604760770911050845i16421726h8fd3d230544332b8@mail.gmail.com>
	<s5h7hu4lwyl.wl%tiwai@suse.de>
	<604760770911050956p36db309et9373f92c59505b25@mail.gmail.com>
	<s5hmy2zu06b.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pw0-f53.google.com (mail-pw0-f53.google.com
	[209.85.160.53]) by alsa0.perex.cz (Postfix) with ESMTP id D5E22244EC
	for <alsa-devel@alsa-project.org>; Fri,  6 Nov 2009 18:49:11 +0100 (CET)
Received: by pwj16 with SMTP id 16so1721614pwj.32
	for <alsa-devel@alsa-project.org>; Fri, 06 Nov 2009 09:49:10 -0800 (PST)
In-Reply-To: <s5hmy2zu06b.wl%tiwai@suse.de>
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
Cc: crimsun@ubuntu.com, alsa-devel@alsa-project.org, Dan Chen <crimsunkg@yahoo.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Nov 6, 2009 at 10:45 AM, Takashi Iwai <tiwai@suse.de> wrote:
> So, do you mean that the decreasing volume still present?
> Or the headphone auto-muting still doesn't work?

Sorry for being unclear. For SSIDs 0x102801dd and 0x102801ed, the
volume-knob issue is resolved, i.e., volume no longer fades to an
inaudible level once hp are inserted.

The hp automuting only affects 0x102801f3 (as tested thus far), and it
remains reproducible.
