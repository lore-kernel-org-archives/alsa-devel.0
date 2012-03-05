From: Pavel Hofman <pavel.hofman@ivitera.com>
Subject: Re: [PATCH - aplay 1/1] aplay - option to dump
	HW	parameters
Date: Mon, 05 Mar 2012 16:06:42 +0100
Message-ID: <4F54D682.4040706@ivitera.com>
References: <1330720378-24855-1-git-send-email-pavel.hofman@ivitera.com>	<s5hfwdn6s90.wl%tiwai@suse.de>	<4F54D0FC.60103@ivitera.com>	<s5h4nu36qiv.wl%tiwai@suse.de>
	<s5h399n6qfz.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cable.insite.cz (static-84-242-75-189.net.upcbroadband.cz
	[84.242.75.189])
	by alsa0.perex.cz (Postfix) with ESMTP id 9F2A610434F
	for <alsa-devel@alsa-project.org>; Mon,  5 Mar 2012 16:06:42 +0100 (CET)
In-Reply-To: <s5h399n6qfz.wl%tiwai@suse.de>
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

>>
>> Yeah, it sounds more intuitive.  But, also it'd be better to describe
>> the exact information in the man page, i.e. it's a hw_params dump of
>> the preconfigured status.
> 
> On the second thought, "hardware" capabilities may be also misleading.
> For example, when your run it without -Dhw, it'll show the all
> possible values because of plug wrapper.
> 

I think the all possible values range is correct, it is what the plug
actually accepts. I will put more detail into the man page and send a
new patch.

Thanks,

Pavel.
