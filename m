From: "Alexander Beregalov" <a.beregalov@gmail.com>
Subject: Re:
	=?utf-8?b?0J7RgtCy0LXRgjogW1BBVENIIDAxLzI0XSBzb3Vu?=
	=?utf-8?q?d/pci=3A_coding_style_fixes=3A_ac97?=
Date: Wed, 10 Sep 2008 21:20:49 +0400
Message-ID: <a4423d670809101020o3a01fb63oe8b8fb8898711e97@mail.gmail.com>
References: <20080909014502.GE6211@orion> <s5hvdx5cy3k.wl%tiwai@suse.de>
	<a4423d670809090815t1a8cbeb4ubf6fe85cd6fe97bb@mail.gmail.com>
	<s5hfxo8gqqm.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from yx-out-1718.google.com (yx-out-1718.google.com [74.125.44.154])
	by alsa0.perex.cz (Postfix) with ESMTP id CBE3F243F3
	for <alsa-devel@alsa-project.org>;
	Wed, 10 Sep 2008 19:20:50 +0200 (CEST)
Received: by yx-out-1718.google.com with SMTP id 36so1464939yxh.2
	for <alsa-devel@alsa-project.org>; Wed, 10 Sep 2008 10:20:49 -0700 (PDT)
In-Reply-To: <s5hfxo8gqqm.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

2008/9/10 Takashi Iwai <tiwai@suse.de>:
> One thing I noticed that spaces around open parentheses aren't always
> fixed, e.g. in sound/pci/cs46xx/*.  Could you fix them?
It is hard to make regexp to fix it and do not touch comments,
but perhaps it is not so hard, I will fix it.
>
> BTW, I'll likely postpone some (or most) of these patches until
> shortly before the final push to the upstream, because these spacing
> changes break all other upcoming patches.  That is, this can be even
> worse than nothing in such a case.
> So, applying this at the last would be a better option.
Ok, I can wait till the merge window and then rewrite them on top of
your master tree
and send them to you again. Is it a possible way?
>
>
> thanks,
>
> Takashi
>
