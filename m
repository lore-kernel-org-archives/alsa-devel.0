From: Abramo Bagnara <abramo@alsa-project.org>
Subject: Re: another control API issue
Date: Wed, 08 May 2002 16:13:52 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3CD932A0.7080402@alsa-project.org>
References: <200205081405.QAA07519@alsa.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from smtp1.libero.it (smtp1.libero.it [193.70.192.51])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id QAA07634
	for <alsa-devel@alsa-project.org>; Wed, 8 May 2002 16:14:33 +0200
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
>>>Sound right?
>>
>>Not fully. You can use FPU in kernel space with some attention (disable
>>preemption and save/restore FPU state for critical area).
> 
> 
> Sure, you can do this, but if anyone from lkml gets a look at it, it
> won't last very long :)
> 

An alternative is to cope with ieee754 without FPU. I cannot know about 
your specific case, but I guess it would be easy.


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
