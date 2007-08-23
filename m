From: stan <stanl@cox.net>
Subject: Re: Unable to open plughw:0,0 from user program.
Date: Thu, 23 Aug 2007 15:31:36 -0700
Message-ID: <46CE0AC8.7050408@cox.net>
References: <46CDD5A8.3000006@cox.net>
	<s5hlkc2yrax.wl%tiwai@suse.de>	<46CDF600.6030509@cox.net>	<75b66ecd0708231429p41ede740q73d34461d00fa130@mail.gmail.com>	<46CE0123.2030707@cox.net>
	<75b66ecd0708231513r2e416d09rff2bacd860761fec@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fed1rmmtao102.cox.net (fed1rmmtao102.cox.net [68.230.241.44])
	by alsa0.perex.cz (Postfix) with ESMTP id AD1AA10382D
	for <alsa-devel@alsa-project.org>;
	Fri, 24 Aug 2007 00:31:38 +0200 (CEST)
In-Reply-To: <75b66ecd0708231513r2e416d09rff2bacd860761fec@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Lee Revell <rlrevell@joe-job.com>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA Developers <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Lee Revell wrote:
> On 8/23/07, stan <stanl@cox.net> wrote:
>   
>> And it must be my problem.  It must have been started by default because
>> I didn't start it.  I'll see if I can configure it to share the sound
>> card or disable it.
>>     
>
> I would disable it, as you have seen, sound server is not necessary to
> share the soundcard anymore - alsa-lib/dmix handles it.
>
> Lee
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
>   
That makes sense, I'll get rid of it.
