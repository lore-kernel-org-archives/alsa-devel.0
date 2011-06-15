From: Ashwani Kumar <ashwani.kumar@freesystems.biz>
Subject: Re:
	=?utf-8?q?snd=5Fpcm=5Flink_=3A_Function_not_implemen?=
	=?utf-8?q?ted?=
Date: Wed, 15 Jun 2011 05:50:29 +0000 (UTC)
Message-ID: <loom.20110615T074514-791@post.gmane.org>
References: <4DF1B8A7.3090408@freesystems.biz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lo.gmane.org (lo.gmane.org [80.91.229.12])
	by alsa0.perex.cz (Postfix) with ESMTP id 6F81124698
	for <alsa-devel@alsa-project.org>;
	Wed, 15 Jun 2011 08:10:11 +0200 (CEST)
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1QWjIj-0004sF-Vd
	for alsa-devel@alsa-project.org; Wed, 15 Jun 2011 08:10:06 +0200
Received: from 59.97.40.19 ([59.97.40.19])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Wed, 15 Jun 2011 08:10:05 +0200
Received: from ashwani.kumar by 59.97.40.19 with local (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Wed, 15 Jun 2011 08:10:05 +0200
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

ashwanik <ashwani.kumar <at> freesystems.biz> writes:

> 
> Hi All,
> 
> I have download and compile latency.c application from 
> http://www.alsa-project.org/alsa-doc/alsa-lib/_2test_2latency_8c-example.html.  
> This application is  working fine on  Linux PC.
> But when I am using this application on my omap4 board(using 
> ubuntu10.10) is not working.
> 
> I am getting"Streams link error: Function not implemented" error. I 
> debug the application and found this error coming from the 
> *snd_pcm_link* function.
> I am using ALSA Driver Version 1.0.23.
> 
> please find pointers.
> 
> Thanks in Advance
> Ashwani
> 
> 

Hi,
Bringing to Top ,anyone faced similar problem of "snd_pcm_link" returning error
val=-38 and prints "Streams link error: Function not implemented".

Thanks in advance

Regards
Ashwani.
