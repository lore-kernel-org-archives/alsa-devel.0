From: "Mike Frysinger" <vapier.adi@gmail.com>
Subject: Re: [PATCH] ALSA: have snd_BUG_ON() always refer to
	arguments
Date: Fri, 7 Nov 2008 02:09:04 -0500
Message-ID: <8bd0f97a0811062309m4029f612k4d3fe380e6d124df@mail.gmail.com>
References: <1226023521-10037-1-git-send-email-vapier@gentoo.org>
	<s5hod0sqcmt.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gx0-f19.google.com (mail-gx0-f19.google.com
	[209.85.217.19])
	by alsa0.perex.cz (Postfix) with ESMTP id 4E74C10388F
	for <alsa-devel@alsa-project.org>; Fri,  7 Nov 2008 08:09:06 +0100 (CET)
Received: by gxk12 with SMTP id 12so1022232gxk.8
	for <alsa-devel@alsa-project.org>; Thu, 06 Nov 2008 23:09:05 -0800 (PST)
In-Reply-To: <s5hod0sqcmt.wl%tiwai@suse.de>
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

On Fri, Nov 7, 2008 at 01:22, Takashi Iwai wrote:
> At Thu,  6 Nov 2008 21:05:21 -0500,
> Mike Frysinger wrote:
>> The snd_BUG_ON() macro should always expand its argument even if we're
>> forcing it to false.  This kills off unused warnings that did not exist
>> before the snd_assert() -> snd_BUG_ON() conversion.
>
> Andrew already change this differently.  Check with the latest version.

what are you defining as "latest version" ?  i'm looking in torvalds
linux-2.6.git.

> And which warning did you get actually?

a few codecs define local vars which only get used in snd_BUG_ON() ...
so if snd_BUG_ON() doesnt utilize cond, gcc whines that the var is
unused.
-mike
