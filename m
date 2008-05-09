From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: My issues with the ALSA API
Date: Fri, 9 May 2008 16:10:09 +0200 (CEST)
Message-ID: <Pine.LNX.4.61.0805091607250.18373@tm8103.perex-int.cz>
References: <20080409221512.GA4466@tango.0pointer.de>
	<Pine.LNX.4.61.0804100951180.13990@tm8103.perex-int.cz>
	<20080410152038.GD5852@tango.0pointer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id F190824342
	for <alsa-devel@alsa-project.org>;
	Fri,  9 May 2008 16:10:09 +0200 (CEST)
In-Reply-To: <20080410152038.GD5852@tango.0pointer.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Lennart Poettering <mznyfn@0pointer.de>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Thu, 10 Apr 2008, Lennart Poettering wrote:

> > buffer mananagement - I think we already discussed this - use sw_params or 
> > PCM timer to be updated when buffer position changes (interrupt was
> > processed), you can use poll() as well
> 
> I am doing this now. I'd still love to see an API for naked
> interrupts, though.

I've added snd_pcm_sw_params_set_period_event() function to ALSA API now. 
Actually, it uses PCM timer internally, but at least public API is defined 
so applications are not forced to use PCM timers explicitly. We can 
optimize this feature later.

					Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
