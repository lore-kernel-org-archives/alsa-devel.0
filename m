From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [PATCH] Per Application Volume Control plugin for
	ALSA
Date: Mon, 18 Oct 2010 09:48:12 +0800
Message-ID: <AANLkTinhR6c0bF1T1or1t7SRZZsoj50ZJrWDDEAp-TMS@mail.gmail.com>
References: <AANLkTikq=9HHQgsdK6CJfNfdOnX5xkBgcLTLrS_Y7Fv8@mail.gmail.com>
	<AANLkTimZgTBaGyK=g5UTkHQ--e=Q5ZpONrrB-7wk8pOp@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com
	[209.85.215.51])
	by alsa0.perex.cz (Postfix) with ESMTP id ED1B71037F3
	for <alsa-devel@alsa-project.org>;
	Mon, 18 Oct 2010 03:48:15 +0200 (CEST)
Received: by ewy9 with SMTP id 9so289210ewy.38
	for <alsa-devel@alsa-project.org>; Sun, 17 Oct 2010 18:48:14 -0700 (PDT)
In-Reply-To: <AANLkTimZgTBaGyK=g5UTkHQ--e=Q5ZpONrrB-7wk8pOp@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2010/10/18 James Huk <huk256@gmail.com>

> Thanks for the answers, everyone.
> .
>
> @Raymond Yau:
>
> > does dmix allow an application open at least 16 voices ?
>
> I think dmix allows much more than that, if your PC can handle it.
>
>
Those hardware mixing sound implement the per voice volume control ( 16-64
voices by hardware ) using IFACE_PCM instead of IFACE_MIXER

http://git.alsa-project.org/?p=alsa-tools.git;a=blob;f=hwmixvolume/README

How dmix prevent clipping occur when it mix several voices ?
