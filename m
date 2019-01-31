From: Phil Burk <philburk@google.com>
Subject: Re: [PATCH 0/2] ALSA: pcm: implement the anonymous dup
	v3
Date: Thu, 31 Jan 2019 11:35:56 -0800
Message-ID: <CACL=Q7y==PFTdknurbg-yZPoBjYh6n5Lduyy32Us1HepeVU-bg@mail.gmail.com>
References: <20190130124139.10439-1-perex@perex.cz>
 <20190130223237.GK2804@sirena.org.uk>
 <s5hsgx9ckrf.wl-tiwai@suse.de> <20190131122624.GA20797@sirena.org.uk>
 <ae257dec-72b9-654c-6366-486e3d7ff836@perex.cz>
 <CACL=Q7ykqDEsaJzcxVexaaNCukw4yiNNQSGZLON=fXbJ7AH-9g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-it1-f194.google.com (mail-it1-f194.google.com
 [209.85.166.194])
 by alsa0.perex.cz (Postfix) with ESMTP id 16DB4266FA5
 for <alsa-devel@alsa-project.org>; Thu, 31 Jan 2019 20:36:09 +0100 (CET)
Received: by mail-it1-f194.google.com with SMTP id z7so5528776iti.0
 for <alsa-devel@alsa-project.org>; Thu, 31 Jan 2019 11:36:09 -0800 (PST)
In-Reply-To: <CACL=Q7ykqDEsaJzcxVexaaNCukw4yiNNQSGZLON=fXbJ7AH-9g@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>, Zach Riggle <riggle@google.com>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA development <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Baolin Wang <baolin.wang@linaro.org>, Leo Yan <leo.yan@linaro.org>
List-Id: alsa-devel@alsa-project.org

Mark and Zach and I talked.

Zach said that "dmabuf" is not a hard requirement. Another "anon_inode"
would probably be OK as long as the app cannot turn on any permissions
besides PCM access. Our security team will just need to review the changes.

So I think you should proceed with the "anon_inode:snd-pcm" if you think
that will be more secure. Thanks for proposing this.

Zach has some notes in his initial review of Jaroslav's code. Zach?

One thing Zach mentioned is that the API should only allow *removing*
permissions and not adding permissions.

What permissions would be set on the FD given to the app?

Also Mark mentioned that the FD app would have PCM access and "close"
permission. What flag allows close? What else is permitted under that flag?
Or is close permission  just a generic "FD" permission unrelated to ALSA?

Thanks for all your work on this. Sorry if I caused alarm. I just wanted to
make sure we could use the solution you provide.

Phil Burk
