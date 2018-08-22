From: Riccardo Casagrande <riccardo.casagrande@multiconn.it>
Subject: ASOC driver I2C communication
Date: Wed, 22 Aug 2018 09:36:27 +0200
Message-ID: <8a068097af618615d2daeed0c5070cbf@multiconn.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.mmit.com.mt (mail.mmit.com.mt [176.56.128.31])
 by alsa0.perex.cz (Postfix) with ESMTP id 9F72126766C
 for <alsa-devel@alsa-project.org>; Wed, 22 Aug 2018 09:36:28 +0200 (CEST)
Received: from multiconn.it [10.101.1.251] ([127.0.0.1])
 by mail.mmit.com.mt (MM IT Mail Server v3.0) with ASMTP id MPF14447
 for <alsa-devel@alsa-project.org>; Wed, 22 Aug 2018 09:35:47 +0200
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


Hello all,


I've developed a driver+codec for a custom sound card. The problem is: the driver take control of the device  (The device is marked UU in i2cdetect command) and do not allow to communicate in the userspace with it via I2C. The device results to be always busy. I need to send some commands to the audio chip. Is there a way to use I2C in the userspace?


Thanks in advance.
Riccardo
