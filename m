From: Daniel Chen <seven.steps@gmail.com>
Subject: Re: [PATCH] ALSA: hda: Use 3stack quirk for some
	broken Dell models
Date: Wed, 11 Nov 2009 01:33:46 -0500
Message-ID: <604760770911102233k3ab08275oc1ed83dbeaa4d403@mail.gmail.com>
References: <730569.68030.qm@web112605.mail.gq1.yahoo.com>
	<s5h639pcuqt.wl%tiwai@suse.de>
	<604760770911050845i16421726h8fd3d230544332b8@mail.gmail.com>
	<s5h7hu4lwyl.wl%tiwai@suse.de>
	<604760770911050956p36db309et9373f92c59505b25@mail.gmail.com>
	<s5hmy2zu06b.wl%tiwai@suse.de>
	<604760770911060949o690c79b1tb157beaf5b1681a1@mail.gmail.com>
	<s5hmy2y5xnq.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pw0-f53.google.com (mail-pw0-f53.google.com
	[209.85.160.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 668341038C8
	for <alsa-devel@alsa-project.org>; Wed, 11 Nov 2009 07:33:47 +0100 (CET)
Received: by pwj11 with SMTP id 11so1070219pwj.32
	for <alsa-devel@alsa-project.org>; Tue, 10 Nov 2009 22:33:46 -0800 (PST)
In-Reply-To: <s5hmy2y5xnq.wl%tiwai@suse.de>
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

On Sat, Nov 7, 2009 at 7:26 AM, Takashi Iwai <tiwai@suse.de> wrote:
> OK, then for debugging I'd need either alsa-info.sh output, or the
> codec#* contents after loaded with probe_only=1 option.
> The previous codec file wasn't enough because it doesn't contain the
> original pin-default values.

The original reporter has confirmed that the 20091012 stable snapshot
fixes the jacksense issue. Sorry for the noise!
