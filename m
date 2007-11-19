From: Stas Sergeev <stsp@aknet.ru>
Subject: Re: rate plugin issue
Date: Tue, 20 Nov 2007 00:09:12 +0300
Message-ID: <4741FB78.8040302@aknet.ru>
References: <s5hwssnx58j.wl%tiwai@suse.de>	<4738A89D.9060601@aknet.ru>	<s5hmytihlvo.wl%tiwai@suse.de>	<473B561A.1050203@aknet.ru>	<s5h6404dmsi.wl%tiwai@suse.de>	<473F01E9.8070907@aknet.ru>
	<s5hir3ylce1.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.aknet.ru (mail.AKNET.ru [77.246.241.226])
	by alsa0.perex.cz (Postfix) with ESMTP id A3CFB24917
	for <alsa-devel@alsa-project.org>; Mon, 19 Nov 2007 22:08:13 +0100 (CET)
In-Reply-To: <s5hir3ylce1.wl%tiwai@suse.de>
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

Hi.

Takashi Iwai wrote:
> Changing period_size isn't allowed arbitrarilly because it's a
> hardware constraint.  OTOH, avail_min is the software parameter.
> So avail_min > period_size makes sense in some cases.
> In my patch I disallowed the case avail_min < period_size because it
> doesn't work *practically*.
OK, I see, thank you.
Now it seems the patch is still not applied.
Just to make sure, is it because you are still
waiting for the test-case, or just haven't got
around to apply it yet?
I am asking to make sure that I am not responsible
for the delay. :)
