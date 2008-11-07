From: "Mike Frysinger" <vapier.adi@gmail.com>
Subject: Re: [PATCH] ALSA: have snd_BUG_ON() always refer to
	arguments
Date: Fri, 7 Nov 2008 02:57:40 -0500
Message-ID: <8bd0f97a0811062357y52ff0107yee74c0a2ff010019@mail.gmail.com>
References: <1226023521-10037-1-git-send-email-vapier@gentoo.org>
	<s5hod0sqcmt.wl%tiwai@suse.de>
	<8bd0f97a0811062309m4029f612k4d3fe380e6d124df@mail.gmail.com>
	<s5hk5bgqa61.wl%tiwai@suse.de>
	<8bd0f97a0811062329l26f8338ahbb62bab9e8284c36@mail.gmail.com>
	<s5hbpwsq92z.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gx0-f19.google.com (mail-gx0-f19.google.com
	[209.85.217.19])
	by alsa0.perex.cz (Postfix) with ESMTP id 267131038A7
	for <alsa-devel@alsa-project.org>; Fri,  7 Nov 2008 08:57:42 +0100 (CET)
Received: by gxk12 with SMTP id 12so1045073gxk.8
	for <alsa-devel@alsa-project.org>; Thu, 06 Nov 2008 23:57:41 -0800 (PST)
In-Reply-To: <s5hbpwsq92z.wl%tiwai@suse.de>
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

On Fri, Nov 7, 2008 at 02:38, Takashi Iwai wrote:
> At Fri, 7 Nov 2008 02:29:25 -0500, Mike Frysinger wrote:
>> it also breaks
>> valid C code if there were side effects in the (cond) as any other
>> macro which does not properly utilize every argument exactly once.
>
> BTW, what do you mean this exactly?

any potent statement.  such as assignment or pre/post increment/decrement or ...
-mike
