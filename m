From: Jerome Marchand <jmarchan@redhat.com>
Subject: Re: Should snd_card_free() check for null pointer?
Date: Wed, 10 Feb 2016 02:41:38 -0500 (EST)
Message-ID: <1378691295.23400498.1455090098781.JavaMail.zimbra@redhat.com>
References: <56B9F7F8.1000605@redhat.com> <s5hlh6tk0o8.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx3-phx2.redhat.com (mx3-phx2.redhat.com [209.132.183.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 6C919260603
 for <alsa-devel@alsa-project.org>; Wed, 10 Feb 2016 08:41:42 +0100 (CET)
In-Reply-To: <s5hlh6tk0o8.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

----- Original Message -----
> From: "Takashi Iwai" <tiwai@suse.de>
> To: "Jerome Marchand" <jmarchan@redhat.com>
> Cc: "Jaroslav Kysela" <perex@perex.cz>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
> Sent: Tuesday, February 9, 2016 10:56:39 PM
> Subject: Re: Should snd_card_free() check for null pointer?
> 
> On Tue, 09 Feb 2016 15:30:16 +0100,
> Jerome Marchand wrote:
> > 
> > Hi,
> > 
> > Before commit f24640648186b (ALSA: Use standard device refcount for card
> > accounting), snd_card_free() would return -EINVAL on a null pointer. Now
> > it ends up in a null pointer dereference. There is at least one driver
> > that can call snd_card_free() with null argument: saa7134_alsa. It can
> > easily be triggered by just inserting and removing the module (no need
> > to have the hardware).
> > I don't think that is a rule, but it seems that the standard behavior of
> > *_free() functions is to check for null pointer. What do you think?
> 
> Well, I have a mixed feeling about this.  Allowing NULL sometimes
> makes the code easier.  OTOH, caling snd_card_free() with NULL is
> really an unexpected situation, and if a driver does it, most likely
> it does something weird.
> 
> So, at this moment, I would fix the caller side.  But, it's not a
> final call, just my gut feeling.

I have no strong opinion either way and I have a patch that fixes saa7134
driver ready to be sent if that is your preference.

Thanks,
Jerome

> 
> 
> thanks,
> 
> Takashi
> 
