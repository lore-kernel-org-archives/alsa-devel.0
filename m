From: "Eric Miao" <eric.y.miao@gmail.com>
Subject: Re: [PATCH 5/5] Separate common pxa2xx-pcm code
Date: Mon, 8 Sep 2008 18:07:19 +0800
Message-ID: <f17812d70809080307m5b938b15sc696eff57799bbc8@mail.gmail.com>
References: <20080908085339.GA31573@doriath.ww600.siemens.net>
	<1220864773-31745-1-git-send-email-dbaryshkov@gmail.com>
	<1220864773-31745-2-git-send-email-dbaryshkov@gmail.com>
	<1220864773-31745-3-git-send-email-dbaryshkov@gmail.com>
	<1220864773-31745-4-git-send-email-dbaryshkov@gmail.com>
	<1220864773-31745-5-git-send-email-dbaryshkov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gx0-f17.google.com (mail-gx0-f17.google.com
	[209.85.217.17]) by alsa0.perex.cz (Postfix) with ESMTP id DF2D524579
	for <alsa-devel@alsa-project.org>;
	Mon,  8 Sep 2008 12:07:20 +0200 (CEST)
Received: by gxk10 with SMTP id 10so7256950gxk.8
	for <alsa-devel@alsa-project.org>; Mon, 08 Sep 2008 03:07:19 -0700 (PDT)
In-Reply-To: <1220864773-31745-5-git-send-email-dbaryshkov@gmail.com>
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
To: Dmitry Baryshkov <dbaryshkov@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, Sep 8, 2008 at 5:06 PM, Dmitry Baryshkov <dbaryshkov@gmail.com> wrote:
> ASoC and non-ASoC drivers for PCM DMA on PXA share lot's of common code.
> Move it to pxa2xx-lib.
>

I guess you didn't try 'git format-patch -M' here, which is able to recognize
most of the code movement, thus making code review a bit easier.

This is also true for one of the previous patches.
