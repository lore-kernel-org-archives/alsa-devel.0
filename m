From: Dmitry <dbaryshkov@gmail.com>
Subject: Re: [PATCH 5/5] Separate common pxa2xx-pcm code
Date: Mon, 8 Sep 2008 14:13:11 +0400
Message-ID: <bc64b4640809080313j4a672a2vd4963f841f78dabf@mail.gmail.com>
References: <20080908085339.GA31573@doriath.ww600.siemens.net>
	<1220864773-31745-1-git-send-email-dbaryshkov@gmail.com>
	<1220864773-31745-2-git-send-email-dbaryshkov@gmail.com>
	<1220864773-31745-3-git-send-email-dbaryshkov@gmail.com>
	<1220864773-31745-4-git-send-email-dbaryshkov@gmail.com>
	<1220864773-31745-5-git-send-email-dbaryshkov@gmail.com>
	<f17812d70809080307m5b938b15sc696eff57799bbc8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.244])
	by alsa0.perex.cz (Postfix) with ESMTP id 0AC0E103854
	for <alsa-devel@alsa-project.org>;
	Mon,  8 Sep 2008 12:13:12 +0200 (CEST)
Received: by an-out-0708.google.com with SMTP id d31so249205and.80
	for <alsa-devel@alsa-project.org>; Mon, 08 Sep 2008 03:13:11 -0700 (PDT)
In-Reply-To: <f17812d70809080307m5b938b15sc696eff57799bbc8@mail.gmail.com>
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
To: Eric Miao <eric.y.miao@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

2008/9/8 Eric Miao <eric.y.miao@gmail.com>:
> On Mon, Sep 8, 2008 at 5:06 PM, Dmitry Baryshkov <dbaryshkov@gmail.com> wrote:
>> ASoC and non-ASoC drivers for PCM DMA on PXA share lot's of common code.
>> Move it to pxa2xx-lib.
>>
>
> I guess you didn't try 'git format-patch -M' here, which is able to recognize
> most of the code movement, thus making code review a bit easier.
>
> This is also true for one of the previous patches.

Unfortunately it doesn't help too much in this case, imo.
Anyway, reposting in a minute.


-- 
With best wishes
Dmitry
