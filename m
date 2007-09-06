From: Markus Korber <korbse@gmx.at>
Subject: Re: period_size and relation to number of samples
Date: Thu, 06 Sep 2007 16:30:17 +0200
Message-ID: <46E00EF9.2070607@gmx.at>
References: <6zps0wwday.fsf@odpc25.int.ondemand.co.at>
	<s5hsl5r6gwk.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by alsa0.perex.cz (Postfix) with SMTP id 0702110396D
	for <alsa-devel@alsa-project.org>;
	Thu,  6 Sep 2007 16:30:18 +0200 (CEST)
In-Reply-To: <s5hsl5r6gwk.wl%tiwai@suse.de>
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
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Takashi Iwai schrieb:
> At Thu, 06 Sep 2007 07:52:37 +0200,
> Markus Korber wrote:
>> [...]
>> Now, what is an application allowed to send and what not?  For example,
>> could an application only send 1024 l/r samples and is the driver
>> responsible for buffering the data?  Or must it obey the announced
>> period_size and *always* provide 2048 l/r samples?
> 
> No, as mentioned, the app is free to send any size in general.  When
> the period size is filled up, basically it's supposed to be playable.
> But, the procedure "fill the whole buffer then start" is the most
> robust way.  
> 
> The period size is the minimal chunk size that controls the poll
> frequency.  So, it's natural to send in this size.  It's no
> requirement but a common use case.

Thus, is it possible to buffer the data in ALSA before sending them to 
the driver, in such a way, that the driver always receives period_size 
samples, regardless of what the application sends to ALSA?  And how 
would I configure ALSA for such a setup?

Regards,
Markus Korber
