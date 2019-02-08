From: Phil Burk <philburk@google.com>
Subject: Re: [PATCH 0/2 v4] ALSA: pcm: anonymous dup
	implementation
Date: Fri, 8 Feb 2019 07:57:29 -0800
Message-ID: <CACL=Q7wKoDJoi_0SSgDPEa957W1Go1cMnq-fLHy=0X1EczJX6A@mail.gmail.com>
References: <20190204093910.23878-1-perex@perex.cz>
 <CACL=Q7wpCJiiHoWE7FrArpm0DFYKUkLdPkUg+uh9=oOMPWWWMA@mail.gmail.com>
 <860bd8b7-2ba1-2cc8-52e2-dacedd58eb05@perex.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-it1-f196.google.com (mail-it1-f196.google.com
 [209.85.166.196])
 by alsa0.perex.cz (Postfix) with ESMTP id 398262674C9
 for <alsa-devel@alsa-project.org>; Fri,  8 Feb 2019 16:57:42 +0100 (CET)
Received: by mail-it1-f196.google.com with SMTP id q78so9042337itc.0
 for <alsa-devel@alsa-project.org>; Fri, 08 Feb 2019 07:57:42 -0800 (PST)
In-Reply-To: <860bd8b7-2ba1-2cc8-52e2-dacedd58eb05@perex.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: ALSA development <alsa-devel@alsa-project.org>, Baolin Wang <baolin.wang@linaro.org>, Takashi Iwai <tiwai@suse.de>, Zach Riggle <riggle@google.com>, Mark Brown <broonie@kernel.org>, Leo Yan <leo.yan@linaro.org>
List-Id: alsa-devel@alsa-project.org

> (except the else comment which I don't understand - it's just
copy-n-paste of the origin).

OK. No problem. I see that was already there.

Thanks for fixing the indentation change.

Phil Burk


On Thu, Feb 7, 2019 at 9:53 AM Jaroslav Kysela <perex@perex.cz> wrote:

> Dne 7.2.2019 v 18:41 Phil Burk napsal(a):
> > Thanks for these patches for tinyalsa.  Looks great!
> >
> > I made a few minor comments on the code layout.
> >
> https://github.com/perexg/tinyalsa/commit/f62b953f37693e8426ee4c20e53baae757ba1026
> > Can you see them?
>
> Yes, I updated the anondup branch with the suggested changes (except the
> else comment which I don't understand - it's just copy-n-paste of the
> origin).
>
>                                         Thanks,
>                                                 Jaroslav
>
> --
> Jaroslav Kysela <perex@perex.cz>
> Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
>
