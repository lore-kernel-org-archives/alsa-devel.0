From: Heikki Lindholm <holindho@cs.helsinki.fi>
Subject: Re: alsa timestamps
Date: Mon, 19 Nov 2007 14:54:16 +0200
Message-ID: <47418778.20609@cs.helsinki.fi>
References: <47413D60.9000404@cs.helsinki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from emh01.mail.saunalahti.fi (emh01.mail.saunalahti.fi
	[62.142.5.107]) by alsa0.perex.cz (Postfix) with ESMTP id E1A4E2488F
	for <alsa-devel@alsa-project.org>; Mon, 19 Nov 2007 13:54:19 +0100 (CET)
Received: from saunalahti-vams (vs3-11.mail.saunalahti.fi [62.142.5.95])
	by emh01-2.mail.saunalahti.fi (Postfix) with SMTP id 44ABF1BBBE
	for <alsa-devel@alsa-project.org>; Mon, 19 Nov 2007 14:54:19 +0200 (EET)
Received: from marumake.local (a88-112-236-112.elisa-laajakaista.fi
	[88.112.236.112])
	by emh06.mail.saunalahti.fi (Postfix) with ESMTP id 30AC6E536A
	for <alsa-devel@alsa-project.org>; Mon, 19 Nov 2007 14:54:18 +0200 (EET)
In-Reply-To: <47413D60.9000404@cs.helsinki.fi>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Heikki Lindholm kirjoitti:
> Hello list,
> 
> I took up some old dusty code of mine that uses snd_pcm_state followed 
> by snd_pcm_status_get_tstamp when in capture mode. The code used to 
> work, but now the returned timestamps are all zeroes. Is there some API 
> change done recently or is the whole timestamping deprecated or 
> something? I've tried with different drivers on ubuntu's alsa .14 and 
> gentoo's .14. I've also tried mmap'ed and r/w modes, and I'm setting the 
> TSTAMP_MMAP sw param.

I figured out that this doesn't happen when using hw:x,y devices. Is it 
a documented feature that some (software?) devices don't fill in timestamps?

-- Heikki Lindholm
