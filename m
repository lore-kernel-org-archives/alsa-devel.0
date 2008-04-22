From: Reuben Martin <reuben.m@gmail.com>
Subject: Re: Alsa Callbacks and C++ classes
Date: Mon, 21 Apr 2008 19:49:54 -0500
Message-ID: <200804211949.54682.reuben.m@gmail.com>
References: <200804202128.25675.reuben.m@gmail.com>
	<s5hskxfb3tu.wl%tiwai@suse.de>
Reply-To: Reuben Martin <reuben.m@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.251])
	by alsa0.perex.cz (Postfix) with ESMTP id 1490624499
	for <alsa-devel@alsa-project.org>;
	Tue, 22 Apr 2008 02:49:50 +0200 (CEST)
Received: by an-out-0708.google.com with SMTP id c36so560001ana.80
	for <alsa-devel@alsa-project.org>; Mon, 21 Apr 2008 17:49:45 -0700 (PDT)
In-Reply-To: <s5hskxfb3tu.wl%tiwai@suse.de>
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

Back on Monday 21 April 2008, Takashi Iwai was like:
> At Sun, 20 Apr 2008 21:28:25 -0500,
>
> Reuben Martin wrote:
> > Hello all,
> >
> > I have an AES32 sound card that I am trying to write a general control
> > interface for using qt4. I'm wanting to register callbacks so that the
> > interface will reflect changes made by other apps. Now I'm not entirely
> > up to speed on the API, but from what I can gather, the callback can be
> > registered to call a regular function, or to change a public class
> > variable.
> >
> > Since I decided to use qt4, everything is in classes. Is there any way to
> > have the callback trigger a public class function? I guess I don't
> > understand why you would want to use a public variable instead. Wouldn't
> > you have to set up a means within the class to continually pole the
> > variable to see if it has been changed? Or can the option to call a
> > regular function be used to call a public class function as well?
>
> Well, which callback do you have in your mind?  A bit more
> specificically please...

Sorry about that. The callbacks I was referring to are mixer callbacks, 
specifically snd_mixer_set_callback and snd_mixer_set_callback_private.

I wrote "public" in my original post, when I meant "private". And now that I'm 
looking at it I think I may have misunderstood what 
snd_mixer_set_callback_private was for.

Anyway, I'm just wondering if it's possible (while maintaining sanity) to 
interface one of these mixer callbacks with a class public function. Or if 
there is a better means to get feedback when changes are made to one of the 
simple mixer elements.

Thanks,
-Reuben
