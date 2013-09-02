From: Ankit Agarwal <ankitgenius90@gmail.com>
Subject: =?windows-1252?q?alsa_crash_with_=93_ALSA_sound/usb/?=
	=?windows-1252?q?urb=2Ec=3A179_cannot_submit_urb_=28err_=3D_-27=29?=
	=?windows-1252?q?=94_on_imx6q_sabrelite?=
Date: Mon, 2 Sep 2013 16:21:04 +0530
Message-ID: <CAFT5LgLN2dWg9Pef5AHH9AFPv-1e_WAp=3J+LEdvYTCWjKXAhg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ob0-f176.google.com (mail-ob0-f176.google.com
 [209.85.214.176])
 by alsa0.perex.cz (Postfix) with ESMTP id 0C97726511F
 for <alsa-devel@alsa-project.org>; Mon,  2 Sep 2013 12:51:05 +0200 (CEST)
Received: by mail-ob0-f176.google.com with SMTP id uz19so4314148obc.7
 for <alsa-devel@alsa-project.org>; Mon, 02 Sep 2013 03:51:05 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

I am using alsa pcm player to listen to audio. The alsa pcm crashes with
the error: ALSA sound/usb/urb.c:179 cannot submit urb (err = -27). I am
able to hear the data initially but when other transaction begins on HID
report endpoint, alsa crashes with the mentioned error.

I am working on imx6q board with linux kernel-3.0.35. I am using Apple
device to get the digital audio.


-- 
Best Regards,
Ankit Agarwal
