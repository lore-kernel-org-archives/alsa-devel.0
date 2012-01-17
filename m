From: Wayne Tams <wayne.tams@gmail.com>
Subject: Unable to see ADC output data with ADAV801
Date: Tue, 17 Jan 2012 12:29:03 +0000
Message-ID: <CAN=k24=OeT10vuo1Z5gLXtjw5zV_Cd7Uxmmf20KRgeEf2A2doQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ee0-f51.google.com (mail-ee0-f51.google.com [74.125.83.51])
	by alsa0.perex.cz (Postfix) with ESMTP id EF4B4245E2
	for <alsa-devel@alsa-project.org>; Tue, 17 Jan 2012 13:29:25 +0100 (CET)
Received: by eeke52 with SMTP id e52so168066eek.38
	for <alsa-devel@alsa-project.org>; Tue, 17 Jan 2012 04:29:24 -0800 (PST)
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

Hi,

I am attempting to add ADAV801 codec support to my 2.6.35 kernel to be
used with an ARM processor. I can see that there is a mainlined
adav80x.c driver that appears at kernel version 3.1, I have had a
quick look at back-porting the driver but this looks as though it
could get quite messy.

However, I did come across an older ADAV801 driver which looks a lot
simpler, but I cannot find it in previous mainlined kernel versions,
http://www.spinics.net/lists/alsa-devel/msg36465.html, so I thought I
would use this as a basis for my own driver.

>From what I understand from the datasheet and the way the older driver
has configured the registers on the ADAV801 I should be able to see
some data on the record outputs, however this is not the case. Could
anyone confirm whether or not this driver dated August 2010 is OK to
use? Or perhaps some advice on areas to look at that may be preventing
the CODEC from manipulating and outputting the digital conversion.

Best regards

Wayne
