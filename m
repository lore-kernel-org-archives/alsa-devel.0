From: "Ning Zhang" <ning.zhang06@gmail.com>
Subject: Non standard sound card
Date: Sat, 10 Nov 2007 21:47:27 +0800
Message-ID: <48a1cba90711100547l5170fbf6tf8c0d0ad596cf2a2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.176])
	by alsa0.perex.cz (Postfix) with ESMTP id 6A27624768
	for <alsa-devel@alsa-project.org>; Sat, 10 Nov 2007 14:47:50 +0100 (CET)
Received: by wa-out-1112.google.com with SMTP id m33so1072522wag
	for <alsa-devel@alsa-project.org>; Sat, 10 Nov 2007 05:47:27 -0800 (PST)
Content-Disposition: inline
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

Hi Dear,

I am a fresh man in this community. Now I plan to develope a sound driver
for my embedded platform.

The problem is that my audio chip is a DSP ,not a standard codec chip. The
MCU communicates with this DSP via a shared ram. So at first , I have
to make the DSP as a platform_device and use the  platform_driver_register()
to register the DSP , right?  Then I can use alsa driver API to develop the
sound card.
Is my understanding right? Thanks.

Where can I find some information about ALSA architecture?

David.
