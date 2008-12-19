From: Udo van den Heuvel <udovdh@xs4all.nl>
Subject: Re: ice1712 error
Date: Fri, 19 Dec 2008 18:18:53 +0100
Message-ID: <494BD77D.4000401@xs4all.nl>
References: <494BC00A.9080202@xs4all.nl>	<s5hocz8uq0t.wl%tiwai@suse.de>	<494BC52B.8020605@xs4all.nl>	<s5hljucuouu.wl%tiwai@suse.de>	<494BCA18.3080508@xs4all.nl>
	<s5h8wqcumjn.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-vbr19.xs4all.nl (smtp-vbr19.xs4all.nl [194.109.24.39])
	by alsa0.perex.cz (Postfix) with ESMTP id 9F0D82446D
	for <alsa-devel@alsa-project.org>; Fri, 19 Dec 2008 18:18:54 +0100 (CET)
In-Reply-To: <s5h8wqcumjn.wl%tiwai@suse.de>
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

Takashi Iwai wrote:
>>> You should figure out which function returns -ENOMEM error in the
>>> probe callback.
>> How can I do that?
>> Please let me know which file I need to modify.
>> I can build a test-kernel and see waht happens then.
> 
> Well, my bet is snd_card_new().  It returns NULL when something is
> wrong, and the driver returns -ENOMEM no matter which error was.
> Usually when this happens you'll have some error messages
> (e.g. "cannot find the slot...") or so.

snd_card_new gives me the error.
(I put some printk's at the right spots.)

So what's the next step?

Kind regards,
Udo
