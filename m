From: Viral Mehta <viral.mehta@einfochips.com>
Subject: ALSA layer in Linux 2.6.18 and OSS
Date: Mon, 16 Feb 2009 13:24:54 +0530
Message-ID: <49991BCE.40400@einfochips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ahmedabad.einfochips.com (india.einfochips.com [203.88.139.151])
	by alsa0.perex.cz (Postfix) with ESMTP id B087224407
	for <alsa-devel@alsa-project.org>; Mon, 16 Feb 2009 09:01:47 +0100 (CET)
Received: from unknown (HELO [192.168.14.27]) (viral.mehta@[192.168.14.27])
	(envelope-sender <viral.mehta@einfochips.com>)
	by ahmedabad.einfochips.com (qmail-ldap-1.03) with SMTP
	for <alsa-devel@alsa-project.org>; 16 Feb 2009 07:56:50 -0000
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

I am trying to make an application that does Audio playback and record. 
I have configured Kernel and Re-built it.
I want to use only ALSA features. I have said "Yes" to all ALSA related 
options and "No" to all OSS related things.

When I booted my kernel, I found that there was no "/dev/dsp" device and 
so my application was not able to run. The application opens "/dev/dsp" 
device first and then does other things.

Next time, when I enabled few of the OSS options in kernel's config 
file. I was able to run my application. My question is I do not want OSS 
at all. I just need ALSA then in that case what I am doing wrong.

Thanks,
Viral


-- 
_____________________________________________________________________
Disclaimer: This e-mail message and all attachments transmitted with it
are intended solely for the use of the addressee and may contain legally
privileged and confidential information. If the reader of this message
is not the intended recipient, or an employee or agent responsible for
delivering this message to the intended recipient, you are hereby
notified that any dissemination, distribution, copying, or other use of
this message or its attachments is strictly prohibited. If you have
received this message in error, please notify the sender immediately by
replying to this message and please delete it from your computer. Any
views expressed in this message are those of the individual sender
unless otherwise stated.Company has taken enough precautions to prevent
the spread of viruses. However the company accepts no liability for any
damage caused by any virus transmitted by this email.
__________________________________________________________________________
