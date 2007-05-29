From: "Ivan N. Zlatev" <contact@i-nz.net>
Subject: Re: SigmaTel STAC9221 - Mux Amp-Out > 0x02 ==
	microphone not working
Date: Tue, 29 May 2007 16:20:33 +0100
Message-ID: <3db1ec7f0705290820y2de2fac6oaf3c17109b3ba7e2@mail.gmail.com>
References: <3db1ec7f0705271550n4e61e012l245f888ff34558c0@mail.gmail.com>
	<s5h7iqr1xda.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.241])
	by alsa0.perex.cz (Postfix) with ESMTP id 4FF0224388
	for <alsa-devel@alsa-project.org>;
	Tue, 29 May 2007 17:27:27 +0200 (CEST)
Received: by an-out-0708.google.com with SMTP id c36so572520ana
	for <alsa-devel@alsa-project.org>; Tue, 29 May 2007 08:27:26 -0700 (PDT)
In-Reply-To: <s5h7iqr1xda.wl%tiwai@suse.de>
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
To: alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

On 5/29/07, Takashi Iwai <tiwai@suse.de> wrote:
>
> And, does this volume have any influence on the quality of recorded
> sound at all?  If not, we should remove this control rather than
> keeping a dangerous thing...
>

Yes. This controls the microphone boost level (without boost the sound
recorded has *very* low volume). Also Windows shows  up a +20db
microphone boost slider on this machine.

-- 
Ivan N. Zlatev

Web: http://www.i-nZ.net
"It's all some kind of whacked out conspiracy."
