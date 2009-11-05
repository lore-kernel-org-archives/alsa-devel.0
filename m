From: Daniel Chen <seven.steps@gmail.com>
Subject: Re: [PATCH] ALSA: hda: Use 3stack quirk for some
	broken Dell models
Date: Thu, 5 Nov 2009 12:56:43 -0500
Message-ID: <604760770911050956p36db309et9373f92c59505b25@mail.gmail.com>
References: <730569.68030.qm@web112605.mail.gq1.yahoo.com>
	<s5h639pcuqt.wl%tiwai@suse.de>
	<604760770911050845i16421726h8fd3d230544332b8@mail.gmail.com>
	<s5h7hu4lwyl.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pz0-f184.google.com (mail-pz0-f184.google.com
	[209.85.222.184])
	by alsa0.perex.cz (Postfix) with ESMTP id 2FC1010395F
	for <alsa-devel@alsa-project.org>; Thu,  5 Nov 2009 18:56:45 +0100 (CET)
Received: by pzk14 with SMTP id 14so142865pzk.23
	for <alsa-devel@alsa-project.org>; Thu, 05 Nov 2009 09:56:43 -0800 (PST)
In-Reply-To: <s5h7hu4lwyl.wl%tiwai@suse.de>
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

On Thu, Nov 5, 2009 at 12:09 PM, Takashi Iwai <tiwai@suse.de> wrote:
> Any chance to get alsa-info.sh output?
> The codec proc file isn't enough, e.g. missing PCI IDs.

Unfortunately there's no alsa-info.sh output, but the important bits
are as follows: SSIDs 0x102801dd and 0x102801ed are affected by the
volume-knob change.
