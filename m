From: "Mike Frysinger" <vapier.adi@gmail.com>
Subject: Re: [PATCH] ALSA: have snd_BUG_ON() always refer to
	arguments
Date: Fri, 7 Nov 2008 05:03:10 -0500
Message-ID: <8bd0f97a0811070203w15f3a524le82f15310dab29c5@mail.gmail.com>
References: <1226023521-10037-1-git-send-email-vapier@gentoo.org>
	<s5hk5bgqa61.wl%tiwai@suse.de>
	<8bd0f97a0811062329l26f8338ahbb62bab9e8284c36@mail.gmail.com>
	<s5hbpwsq92z.wl%tiwai@suse.de>
	<8bd0f97a0811062357y52ff0107yee74c0a2ff010019@mail.gmail.com>
	<s5h7i7gq7xz.wl%tiwai@suse.de>
	<8bd0f97a0811070005r6a9fb1e1s9fd88bd264ef8ae2@mail.gmail.com>
	<s5h4p2kq71k.wl%tiwai@suse.de>
	<8bd0f97a0811070130w540f8110l978c8910fad924e0@mail.gmail.com>
	<s5hr65nq2p5.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rv-out-0708.google.com (rv-out-0708.google.com [209.85.198.243])
	by alsa0.perex.cz (Postfix) with ESMTP id 5906124341
	for <alsa-devel@alsa-project.org>; Fri,  7 Nov 2008 11:03:11 +0100 (CET)
Received: by rv-out-0708.google.com with SMTP id f25so986991rvb.32
	for <alsa-devel@alsa-project.org>; Fri, 07 Nov 2008 02:03:10 -0800 (PST)
In-Reply-To: <s5hr65nq2p5.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Mike Frysinger <vapier@gentoo.org>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Fri, Nov 7, 2008 at 04:56, Takashi Iwai wrote:
> At Fri, 7 Nov 2008 04:30:43 -0500, Mike Frysinger wrote:
>> we arent talking about assert() here nor are we talking about assert()
>> behavior, but i would say it was a poor decision.  the fact that it's
>> called snd_BUG_ON() instead of snd_WARN_ON() is also a bit broken imo.
>>  BUG() kills the kernel while WARN() complains, and snd_BUG_ON() is
>> clearly in the latter category.
>
> Right, that's a bit confusing.  It came because we had already
> snd_BUG() macro.  I took snd_BUG_ON() from the analogy of snd_BUG().
>
>> that said, you could just define snd_BUG_ON() in terms of WARN_ON()
>> all the time:
>
> Hm, this looks a good alternative, too.
> Though, this was already fixed on my git tree in another way...

np.  if it's fixed now, i'm happy.  maybe keep in mind my suggestion
if someone else complains about the current code not working for them
:).

thanks for your help.
-mike
