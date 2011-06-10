From: ashwanik <ashwani.kumar@freesystems.biz>
Subject: snd_pcm_link:Function not implemented
Date: Fri, 10 Jun 2011 12:12:33 +0530
Message-ID: <4DF1BCD9.4090303@freesystems.biz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.freesystems.biz (unknown [124.30.7.148])
	by alsa0.perex.cz (Postfix) with ESMTP id 1DFA2244F5
	for <alsa-devel@alsa-project.org>;
	Fri, 10 Jun 2011 08:42:43 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mail.freesystems.biz (Postfix) with ESMTP id CE1D52163C7
	for <alsa-devel@alsa-project.org>; Fri, 10 Jun 2011 12:15:04 +0530 (IST)
Received: from mail.freesystems.biz ([127.0.0.1])
	by localhost (mail.freesystems.biz [127.0.0.1]) (amavisd-new,
	port 10024)
	with ESMTP id fvdK6bWpmzbU for <alsa-devel@alsa-project.org>;
	Fri, 10 Jun 2011 12:14:57 +0530 (IST)
Received: from [192.168.115.248] (localhost [127.0.0.1])
	by mail.freesystems.biz (Postfix) with ESMTP id 984F02163BF
	for <alsa-devel@alsa-project.org>; Fri, 10 Jun 2011 12:14:57 +0530 (IST)
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

Hi All,

I have download and compile latency.c application from 
http://www.alsa-project.org/alsa-doc/alsa-lib/_2test_2latency_8c-example.html.  
This application is  working fine on  Linux PC.
But when I am using this application on my omap4 board(using 
ubuntu10.10) is not working.

I am getting"Streams link error: Function not implemented" error. I 
debug the application and found this error coming from the 
*snd_pcm_link* function.
I am using ALSA Driver Version 1.0.23.


please find pointers.

Thanks in Advance
Ashwani
