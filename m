From: Robin Getz <rgetz@blackfin.uclinux.org>
Subject: Re: dmix without mmap support in soundcard driver
Date: Fri, 11 Jan 2008 13:53:31 -0500
Message-ID: <200801111353.31815.rgetz@blackfin.uclinux.org>
References: <BAY110-W2718CB754898850E2E81F3C9520@phx.gbl>
	<200801082258.15166.rgetz@blackfin.uclinux.org>
	<1200063696.7074.18.camel@md40100b.ft>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nwd2mail10.analog.com (nwd2mail10.analog.com [137.71.25.55])
	by alsa0.perex.cz (Postfix) with ESMTP id 49E432462C
	for <alsa-devel@alsa-project.org>; Fri, 11 Jan 2008 19:53:09 +0100 (CET)
In-Reply-To: <1200063696.7074.18.camel@md40100b.ft>
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
To: Joachim Foerster <mls.JOFT@gmx.de>
Cc: cailinhua <xcahua@hotmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri 11 Jan 2008 10:01, Joachim Foerster pondered:
> > My only question is - if you allow a mmaped intermediate buffer, how
> > does the  driver notice when ALSA writes into this buffer?
> 
> It's the ack() callback. ALSA writes/reads something into/from the
> intermediate buffer and calls the driver's ack() callback - if there is
> any. In the ack() callback the driver should call one of the
> snd_pcm_indirect_*_transfer() functions. There, the difference between
> current and last seen appl_ptr gives the "new position" of the PCM Layer
> in your intermediate buffer (where it will write/read next time).

OK - thanks.

>From just thinking about it - won't this will cause problems for things that 
need to understand where the audio device is in the PCM stream (like AEC, and 
lip-sync)? Since now everything from userspace is in reference to the 
position in the intermediate buffer - rather than what is actually coming out 
the DACs?
