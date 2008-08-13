From: "Henry Ho" <yjho@richwave.com.tw>
Subject: developing audio with ALSA
Date: Wed, 13 Aug 2008 14:48:32 +0800
Message-ID: <000c01c8fd10$a09013c0$ba3ea8c0@Richwave.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from richwave.com.tw (richwave.richwave.com.tw [60.248.29.39])
	by alsa0.perex.cz (Postfix) with ESMTP id 40C2424441
	for <alsa-devel@alsa-project.org>;
	Wed, 13 Aug 2008 08:50:44 +0200 (CEST)
Received: from nbhoyj ([192.168.62.186])
	by richwave.com.tw (8.13.1/8.12.8) with SMTP id m7D6jHLU027135
	for <alsa-devel@alsa-project.org>; Wed, 13 Aug 2008 14:45:22 +0800
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

I'm developing audio application using ALSA library. My target platform is ARM 
platform baseboard. I use GNU toolchain cross compiler as you can see from 
the following message:

arm-none-linux-gnueabi-gcc -lasound -g -O2 -I./alsa-lib-1.0.17rc2/include -o pcm pcm.c
/usr/bin/../lib/gcc/arm-none-linux-gnueabi/4.2.0/../../../../arm-none-linux-gnueabi/bin/ld: cannot find -lasound
collect2: ld returned 1 exit status
make: *** [versatile] Error 1

I know that is because the linker cannot find the asound library. Should I cross compiling 
ALSA driver/lib/utils first?

Henry
=====================================================================================================================================
The privileged confidential information  contained in this email is intended for use only by the addressees as indicated by the original sender of this email. If you are not the addressee indicated in this email or are not responsible for delivery of the email to such a person, please kindly reply to the sender indicating this fact and delete all copies of it from your computer and network server immediately. Your cooperation is highly appreciated. It is advised that any unauthorized use of confidential information of RichWave is strictly prohibited; and any information in this email irrelevant to the official business of RichWave shall be deemed as neither given nor endorsed by RichWave. 
