From: Raymond Toy <rtoy@google.com>
Subject: Getting the actual HW sample rate
Date: Wed, 7 Sep 2011 14:24:07 -0700
Message-ID: <CAE3TgXHC+C6xBxD_A_qZUm8TtN0V3GBo7kKLxDkasOZ50WDH=Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out.google.com (smtp-out.google.com [74.125.121.67])
	by alsa0.perex.cz (Postfix) with ESMTP id C088924715
	for <alsa-devel@alsa-project.org>;
	Wed,  7 Sep 2011 23:24:09 +0200 (CEST)
Received: from hpaq7.eem.corp.google.com (hpaq7.eem.corp.google.com
	[172.25.149.7]) by smtp-out.google.com with ESMTP id p87LO99I013704
	for <alsa-devel@alsa-project.org>; Wed, 7 Sep 2011 14:24:09 -0700
Received: from yie16 (yie16.prod.google.com [10.243.66.16])
	by hpaq7.eem.corp.google.com with ESMTP id p87LNCPT032760
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
	for <alsa-devel@alsa-project.org>; Wed, 7 Sep 2011 14:24:08 -0700
Received: by yie16 with SMTP id 16so148802yie.1
	for <alsa-devel@alsa-project.org>; Wed, 07 Sep 2011 14:24:07 -0700 (PDT)
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

I know that
http://www.mail-archive.com/alsa-user@lists.sourceforge.net/msg24794.htmlgives
code to get the available sample rates (among other things).  However,
my quest is to get the actual HW sample rate.  This code is quite helpful.
 I know that if a sound is already playing, I can look at
/proc/asound/card0/pcm0p/sub0/hw_params to see what the HW sample rate is.
 But is there a way to get this using ALSA?

In my application, we want to know the actual HW rate so that we can do the
sample rate conversion ourselves upfront and therefore we want to avoid yet
another sample rate conversion when playing out the audio.  (The application
can synthesize audio and we can select the sample rate for the synthesis.)

Thanks,

Ray
