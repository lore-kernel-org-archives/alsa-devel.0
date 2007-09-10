From: Rene Herman <rene.herman@gmail.com>
Subject: Re: [PATCH] cs4231-lib: improved waiting after
 mce_down (2nd rev)
Date: Tue, 11 Sep 2007 00:43:42 +0200
Message-ID: <46E5C89E.4010607@gmail.com>
References: <20070909221131.06372eb2.krzysztof.h1@gmail.com>	<s5hbqcaqkb8.wl%tiwai@suse.de>
	<20070911004010.b9114b3e.krzysztof.h1@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq2.groni1.gr.home.nl (smtpq2.groni1.gr.home.nl
	[213.51.130.201])
	by alsa0.perex.cz (Postfix) with ESMTP id 18E7D103803
	for <alsa-devel@alsa-project.org>;
	Tue, 11 Sep 2007 00:50:42 +0200 (CEST)
In-Reply-To: <20070911004010.b9114b3e.krzysztof.h1@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Krzysztof Helt <krzysztof.h1@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, Alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 09/11/2007 12:40 AM, Krzysztof Helt wrote:

> This patch replaces long msleeps in waiting loops
> with schedule_timeout() calls.

Hope you'll not detest me for getting on your case so much, but...

First, yes, attachments are good as far as I'm concerned, but could you make 
them plain text attachments? They are now Base64 which means that at least 
with my "casual mailer" (Thunderbird) I need to save the patch and can only 
then look at it.

Second -- not schedule_timeout_interruptible? A plain schedule_timeout won't 
work, as you first need to __set_current_state or it will not schedule. That 
is, schedule_timeout_interruptible or _uniterruptible and with the latter, 
the loop wouldn't make much sense anymore as it's just going to sleep for 
the full 250 ms directly.

Rene.
