From: Abramo Bagnara <abramo@alsa-project.org>
Subject: Re: another control API issue
Date: Wed, 08 May 2002 16:00:41 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3CD92F89.4D5711B9@alsa-project.org>
References: <200205081306.g48D6VD04392@post2.fast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from smtp1.libero.it (smtp1.libero.it [193.70.192.51])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id QAA07460
	for <alsa-devel@alsa-project.org>; Wed, 8 May 2002 16:01:00 +0200
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Paul Davis <pbd@op.net>
Cc: alsa-devel@alsa-project.org, Jaroslav Kysela <perex@perex.cz>
List-Id: alsa-devel@alsa-project.org

Paul Davis wrote:
> 
> >I expected something similar. Don't you think that to have a FLOAT type
> >is a better choice (more card independent, more accessible, more
> >representative, etc.).
> 
> Well, that was my initial thought. Then I remembered that we can't
> have floating point code in the kernel, and its therefore unsafe to
> even use this data type (an interrupt in kernel mode doesn't result in
> an FP register restore, and we may have run another task in the
> meantime that used the FP registers before we get back to our code).
> 
> In this particular case, even if it was safe to store the value in a
> float, the actual float value has to be computed with FP math, which
> is definitely not available in the kernel. so it wouldn't help much
> here.
> 
> Sound right?

Not fully. You can use FPU in kernel space with some attention (disable
preemption and save/restore FPU state for critical area).

-- 
Abramo Bagnara                       mailto:abramo@alsa-project.org

Opera Unica                          Phone: +39.546.656023
Via Emilia Interna, 140
48014 Castel Bolognese (RA) - Italy

ALSA project               http://www.alsa-project.org
It sounds good!

_______________________________________________________________

Have big pipes? SourceForge.net is looking for download mirrors. We supply
the hardware. You get the recognition. Email Us: bandwidth@sourceforge.net
