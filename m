From: "Krzysztof Helt" <krzysztof.h1@gmail.com>
Subject: Re: [PATCH] cs4231-lib: improved waiting after
	mce_down (2nd rev)
Date: Tue, 11 Sep 2007 10:39:48 +0200
Message-ID: <8c74410a0709110139j2adb84admb5123b6f4185f4e9@mail.gmail.com>
References: <20070909221131.06372eb2.krzysztof.h1@gmail.com>
	<s5hbqcaqkb8.wl%tiwai@suse.de>
	<20070911004010.b9114b3e.krzysztof.h1@gmail.com>
	<46E5C89E.4010607@gmail.com> <s5hejh6ktk8.wl%tiwai@suse.de>
	<s5hd4wqkt5a.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rv-out-0910.google.com (rv-out-0910.google.com [209.85.198.188])
	by alsa0.perex.cz (Postfix) with ESMTP id D32E9103871
	for <alsa-devel@alsa-project.org>;
	Tue, 11 Sep 2007 10:39:52 +0200 (CEST)
Received: by rv-out-0910.google.com with SMTP id k20so1212094rvb
	for <alsa-devel@alsa-project.org>; Tue, 11 Sep 2007 01:39:51 -0700 (PDT)
In-Reply-To: <s5hd4wqkt5a.wl%tiwai@suse.de>
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
Cc: Alsa-devel <alsa-devel@alsa-project.org>, Rene Herman <rene.herman@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 9/11/07, Takashi Iwai <tiwai@suse.de> wrote:
> At Tue, 11 Sep 2007 01:08:07 +0200,
> I wrote:
> >
> > Actually, the code with msleep() was basically OK.  If more finer
> > check is needed, it can simply use msleep(1).  The point is to use
> > timer_after_eq() instead of loop count for the precise timeouts.
>

The patch is ok. You may change this timer_after_eq and jiffies into
just number for the timeout (one pass will be 1ms) for simplicity (not
required).

The ad1848_lib have been using this broken method (schedule_timeout
with set_current_..). You can fix it as well or if the patch gets
applied, I can sync the ad1848_lib to use exactly the same waiting
loops. The ad1848 chip is slower then cs4231, so the granularity of
1ms hurts it less.

I want to have your patch applied as it is improvement (along with
Rene's patch) over the old code: it is simpler, less code and lower
(on average) delay on playback/record start.

Regards,
Krzysztof
