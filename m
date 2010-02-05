From: Maxim Levitsky <maximlevitsky@gmail.com>
Subject: Re: RFC: workaround for 'azx_get_response timeout,
 switching to polling mode...'
Date: Fri, 05 Feb 2010 11:46:55 +0200
Message-ID: <1265363215.15383.28.camel@maxim-laptop>
References: <1265314817.19186.8.camel@maxim-laptop>
	<s5hljf8umlc.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f221.google.com (mail-bw0-f221.google.com
	[209.85.218.221])
	by alsa0.perex.cz (Postfix) with ESMTP id 3220524380
	for <alsa-devel@alsa-project.org>; Fri,  5 Feb 2010 10:47:00 +0100 (CET)
Received: by bwz21 with SMTP id 21so3013593bwz.4
	for <alsa-devel@alsa-project.org>; Fri, 05 Feb 2010 01:46:59 -0800 (PST)
In-Reply-To: <s5hljf8umlc.wl%tiwai@suse.de>
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

On Fri, 2010-02-05 at 09:13 +0100, Takashi Iwai wrote: 
> At Thu, 04 Feb 2010 22:20:17 +0200,
> Maxim Levitsky wrote:
> > 
> > Hi,
> > 
> > Although I thought that polling mode is harmless, it sometimes isn't.
> > I found out that after few dozens of hibernate cycles, the timeout would
> > happen again kicking out first MSI, and then whole RRIB (single_cmd).
> > 
> > However, I also found out that if I resend the command that caused the
> > timeout, it would complete normally.
> > Even futher, it is possible to poll for this command, and send next
> > normally. It just works.
> > So interrupts do work, but sometimes (very rarely) are missed. It might
> > be even a hardware bug.
> > 
> > The patch I send allows to delay switch to polling till we get 3 such
> > timeouts in a row.
> > 
> > I tested this approach for about 130 hibernate cycles.
> 
> Thanks!  Applied both patches now.
> 
> I changed snd_printd() to snd_printdd() since the former is enabled on
> vendor kernels often as default, and this can worry innocent users (I
> know from my experiences :) 

Thanks a lot!

Best regards,
Maxim Levitsky
