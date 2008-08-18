From: "Henry Ho" <yjho@richwave.com.tw>
Subject: Re: developing audio with ALSA
Date: Mon, 18 Aug 2008 17:15:02 +0800
Message-ID: <000e01c90112$e89e7e30$ba3ea8c0@Richwave.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from richwave.com.tw (richwave.richwave.com.tw [60.248.29.39])
	by alsa0.perex.cz (Postfix) with ESMTP id E3F40103803
	for <alsa-devel@alsa-project.org>;
	Mon, 18 Aug 2008 11:17:07 +0200 (CEST)
Received: from nbhoyj ([192.168.62.186])
	by richwave.com.tw (8.13.1/8.12.8) with SMTP id m7I9BSq1016153
	for <alsa-devel@alsa-project.org>; Mon, 18 Aug 2008 17:11:29 +0800
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

Hi

After reading the cross-compilation instruction in INSTALL file, 
I already successfully configured the alsa-lib-2.0.17. I also 
successfully made the library. Adding --prefix=xxx during 
configuration can set the output directory to xxx.

I also modify my Makefile for application, including the search 
path of libasound.so.2.***. Now I can successfully make it.

However, when I run my application on the target, I got the following 
error message:

******************************************************************************************
./pcm: error while loading shared libraries: libasound.so.2: cannot open 
shared object file: No such file or directory
******************************************************************************************

I have put libasound.so.2.0.0 in /tmp of the target. I also modified 
/etc/ld.so.conf, adding /tmp in ld.so.conf file. However, I cannot 
find ldconfig on the target. Is anyone can tell me how to solve it?
Should I rebuild a busybox with this command?

Henry


=====================================================================================================================================
The privileged confidential information  contained in this email is intended for use only by the addressees as indicated by the original sender of this email. If you are not the addressee indicated in this email or are not responsible for delivery of the email to such a person, please kindly reply to the sender indicating this fact and delete all copies of it from your computer and network server immediately. Your cooperation is highly appreciated. It is advised that any unauthorized use of confidential information of RichWave is strictly prohibited; and any information in this email irrelevant to the official business of RichWave shall be deemed as neither given nor endorsed by RichWave. 
