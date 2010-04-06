From: ANISH KUMAR <anish.singh@samsung.com>
Subject: Re: Help! Need to switch between normal speaker and BT
 headset dynamically
Date: Tue, 06 Apr 2010 11:37:02 +0000 (GMT)
Message-ID: <27215555.734641270553822178.JavaMail.weblogic@epml05>
Reply-To: anish.singh@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	by alsa0.perex.cz (Postfix) with ESMTP id EBDEA10388A
	for <alsa-devel@alsa-project.org>;
	Tue,  6 Apr 2010 13:37:08 +0200 (CEST)
Received: from ep_ms13_bk (mailout4.samsung.com [203.254.224.34])
	by mailout1.samsung.com
	(iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
	with ESMTP id <0L0G00EDODLQUM@mailout1.samsung.com> for
	alsa-devel@alsa-project.org; Tue, 06 Apr 2010 20:37:02 +0900 (KST)
Received: from ep_spt04 (ms13.samsung.com [203.254.225.109])
	by ms13.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14
	2004)) with ESMTP id <0L0G00K33DLQQX@ms13.samsung.com> for
	alsa-devel@alsa-project.org; Tue, 06 Apr 2010 20:37:02 +0900 (KST)
Content-return: prohibited
MIME-version: 1.0
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: maniyar@samsung.com, gmane@colin.guthr.ie
List-Id: alsa-devel@alsa-project.org

As my question is related to the query what pradeep is asking and mark brown also suggested to me to use PA.
I have some additional questions regarding PA which i would like to clarify before starting:

1.Does PA have good resampler code if my hardware doesn't support resampling?

I have a system where we are using ALSA as the base and on top(application side) of it there is a thread running which 
is pumping data and this thread is started by java code.Combination of LINUX+JAVA.
This thread can perform these tasks:
1.Resampling for some rates.
2.Talking to PV framework to get the decoded PCM data and pumping audio data to alsa.
3.Routing support using asound.conf file.
Can i replace this thread with PA by writing some wrapper over PA??
What extra features PA is going to provide additionally if i start using PA other than what is listed above??As i know 
PA is kind of sound deamon which my thread is not.

Is there any good resampler code which i can use without any licensing problem  and which can be 
easily integrated???
