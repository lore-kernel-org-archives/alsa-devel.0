From: Jiri Slaby <jirislaby@gmail.com>
Subject: Re: HDA: no sound [was: mmotm 2010-10-20-15-01
	uploaded]
Date: Thu, 21 Oct 2010 09:57:16 +0200
Message-ID: <4CBFF25C.2080908@gmail.com>
References: <201010202233.o9KMXNoL008303@imap1.linux-foundation.org>	<4CBFEE94.7020103@gmail.com>
	<s5hlj5sc7do.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51])
	by alsa0.perex.cz (Postfix) with ESMTP id E23A4103804
	for <alsa-devel@alsa-project.org>;
	Thu, 21 Oct 2010 09:57:19 +0200 (CEST)
Received: by fxm14 with SMTP id 14so3599316fxm.38
	for <alsa-devel@alsa-project.org>; Thu, 21 Oct 2010 00:57:19 -0700 (PDT)
In-Reply-To: <s5hlj5sc7do.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, mm-commits@vger.kernel.org, clemens@ladisch.de, linux-kernel@vger.kernel.org, akpm@linux-foundation.org
List-Id: alsa-devel@alsa-project.org

On 10/21/2010 09:49 AM, Takashi Iwai wrote:
> At Thu, 21 Oct 2010 09:41:08 +0200,
> Jiri Slaby wrote:
>> alsa-info:
>> http://www.alsa-project.org/db/?f=a7a09703bcc8c43386c87a984e513ce35fc91ca4
> 
> I see the Front volume is set to zero.  Try to raise it.

I set all the values to ~ 70 and then tried with pure alsa. It basically
works.

BUT, when I run pulse and it suspends the device (or whatever), all the
levels get down to 0 back again. When I raise it and run mplayer, it
gets to 0 immediately. If I raise it gets to 0 when mplayer finishes and
pulse writes 'protocol-native.c: Connection died.'. It never raises
automatically. And if I raise it during playback, nothing plays at all.

regards,
-- 
js
