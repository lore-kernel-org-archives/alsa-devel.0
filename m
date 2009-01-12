From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: Re: RFC: snd_card_create() function
Date: Mon, 12 Jan 2009 17:08:28 +0100
Message-ID: <20090112170828.50154e1f.krzysztof.h1@poczta.fm>
References: <s5h63kkd23c.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp239.poczta.interia.pl (smtp239.poczta.interia.pl
	[217.74.64.239])
	by alsa0.perex.cz (Postfix) with ESMTP id 5F21D1037ED
	for <alsa-devel@alsa-project.org>; Mon, 12 Jan 2009 17:05:50 +0100 (CET)
In-Reply-To: <s5h63kkd23c.wl%tiwai@suse.de>
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

On Mon, 12 Jan 2009 15:35:19 +0100
Takashi Iwai <tiwai@suse.de> wrote:

> Hi,
> 
> so far, we use snd_card_new() function to create a card instance.
> A known problem regarding this API is that it doesn't return a proper
> error code, thus the probe callback always returns -ENOMEM (or
> whatever the driver defines) no matter which error occurred actually.
> A typical case is the card slot conflict.  Even in such a case, it
> returns -ENOMEM, which may mislead the user.

Another approach is PTR_ERR macro used already in the kernel
(see include/linux/err.h).
It encodes the error code in the returned pointer value. There
are already hndy macros/inlines to get this code, test error, etc.

Regards,
Krzysztof

----------------------------------------------------------------------
Speak Up. Angielski szybko i skutecznie. 3 miesiace nauki gratis.
Sprawdz. >> http://link.interia.pl/f2019
