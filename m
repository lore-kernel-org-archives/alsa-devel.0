From: "Adrian McMenamin" <adrianmcmenamin@gmail.com>
Subject: Re: [PATCH] ALSA AICA sound on SEGA Dreamcast - fix
	behaviour in poor resource conditions
Date: Fri, 6 Jul 2007 11:09:00 +0100
Message-ID: <92a12cdb0707060309x6fe997nc3112d5545d73ef5@mail.gmail.com>
References: <92a12cdb0707051507r7ab1516blb7ea755d89c25efa@mail.gmail.com>
	<s5h3b016fzx.wl%tiwai@suse.de>
	<92a12cdb0707060246p407f19depe16c59ac43eb0d96@mail.gmail.com>
	<s5hvecx4zz5.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.181])
	by alsa0.perex.cz (Postfix) with ESMTP id 12F75245A0
	for <alsa-devel@alsa-project.org>;
	Fri,  6 Jul 2007 12:09:02 +0200 (CEST)
Received: by wa-out-1112.google.com with SMTP id m33so203346wag
	for <alsa-devel@alsa-project.org>; Fri, 06 Jul 2007 03:09:00 -0700 (PDT)
In-Reply-To: <s5hvecx4zz5.wl%tiwai@suse.de>
Content-Disposition: inline
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
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On 06/07/07, Takashi Iwai <tiwai@suse.de> wrote:
> I guess you shoud call del_timer() there at least.  Otherwise the
> timer handler (aica_period_elapsed()) might be called even if the
> stream is not really running.
>

Fair enough. I'll fix that and repost later.

> The below is some coding style fixes, BTW.  I'm not sure whether
> queue_work() is intended in the block if "if (dma_check == 0)" or
> not.
>

It's just an aberrant indent - I think there was an independent block
there in earlier code, it got removed but the tab stayed :)
