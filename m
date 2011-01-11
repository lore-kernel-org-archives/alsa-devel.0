From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: UCM updates and fixes
Date: Tue, 11 Jan 2011 17:08:02 +0000
Message-ID: <1294765682.3338.24.camel@odin>
References: <1292969520-18047-1-git-send-email-lrg@slimlogic.co.uk>
	<1294764191.3338.18.camel@odin>
	<alpine.LNX.2.00.1101111743420.28150@eeebox2.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f65.google.com (mail-ww0-f65.google.com [74.125.82.65])
	by alsa0.perex.cz (Postfix) with ESMTP id 3220D103A40
	for <alsa-devel@alsa-project.org>; Tue, 11 Jan 2011 18:08:07 +0100 (CET)
Received: by wwb39 with SMTP id 39so6910887wwb.8
	for <alsa-devel@alsa-project.org>; Tue, 11 Jan 2011 09:08:06 -0800 (PST)
In-Reply-To: <alpine.LNX.2.00.1101111743420.28150@eeebox2.perex-int.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Tue, 2011-01-11 at 17:46 +0100, Jaroslav Kysela wrote:
> On Tue, 11 Jan 2011, Liam Girdwood wrote:
> 
> > On Tue, 2010-12-21 at 22:11 +0000, Liam Girdwood wrote:
> >> Jarolsav,
> >>
> >> This fixes the remaining issues I can currently see in the alsa-lib
> >> ucm branch. It also includes a patch to execute commands, although I
> >> dont know if this is what you had in mind for exec.
> >>
> >> I've also done quite a bit of testing now. What is your merge plan for
> >> UCM ? We really need UCM merged soon as there are many users who
> >> depend on it.
> >>
> >
> > Have you had a chance to look over this patch series yet ?
> 
> Your patches are in my branch. Thank you. I'm actually thinking about more 
> inline functions in use-case.h header file like snd_use_case_card_list() to help 
> application developers. But I'm having mixed feelings about this right 
> now. What do you think?

My feelings are we go for a release now and make the relevant functions
inline later. We currently have a lot of folks needing UCM upstream now
to delay much longer.

I have one more small fix pending from Samsung, will send shortly. 

Thanks

Liam

-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
