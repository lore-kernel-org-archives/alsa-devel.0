From: Daniel Chen <seven.steps@gmail.com>
Subject: Re: [PATCH] ALSA: hda: Add model quirk for Sony VAIO
	VGN-SZ650N
Date: Mon, 5 Apr 2010 06:29:09 -0400
Message-ID: <r2u604760771004050329qf37db62r1dd5b550d923ea8d@mail.gmail.com>
References: <y2h604760771004041225z65c88e47t71e063801d1950f6@mail.gmail.com>
	<s5hbpdygt3i.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pz0-f178.google.com (mail-pz0-f178.google.com
	[209.85.222.178])
	by alsa0.perex.cz (Postfix) with ESMTP id C6214103816
	for <alsa-devel@alsa-project.org>;
	Mon,  5 Apr 2010 12:29:11 +0200 (CEST)
Received: by pzk8 with SMTP id 8so166923pzk.16
	for <alsa-devel@alsa-project.org>; Mon, 05 Apr 2010 03:29:10 -0700 (PDT)
In-Reply-To: <s5hbpdygt3i.wl%tiwai@suse.de>
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
Cc: alsa-devel <alsa-devel@alsa-project.org>, stable@kernel.org
List-Id: alsa-devel@alsa-project.org

On Mon, Apr 5, 2010 at 5:13 AM, Takashi Iwai <tiwai@suse.de> wrote:
> Are you sure that this quirk really changes anything?
> I checked with hda-emu, but didn't see any difference.

Because I don't have the hardware locally to verify, I can only go
with what the reporter attests. It does seem odd, however, that this
model quirk is necessary. Are there any additional tests that he can
use to see differences between a live CD boot and HD install? I'll
request fresh runs so that we can see codec#0 across them.

-Dan
