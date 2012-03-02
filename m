From: rohith R <rohith.ubuntu@gmail.com>
Subject: tlv320aic3104
Date: Fri, 2 Mar 2012 11:14:10 +1030
Message-ID: <CAJnYUCSQgdpJRKCb0PnWofkvS3QoC+4qF3DEC9D_=qf1ps59=A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lpp01m010-f51.google.com (mail-lpp01m010-f51.google.com
	[209.85.215.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 88F25103CD3
	for <alsa-devel@alsa-project.org>; Fri,  2 Mar 2012 01:44:11 +0100 (CET)
Received: by laap9 with SMTP id p9so1469379laa.38
	for <alsa-devel@alsa-project.org>; Thu, 01 Mar 2012 16:44:11 -0800 (PST)
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

Beginner query.
I'm modifying the codec driver for tlv320aic3104 and wanted to control
inputs to a mixer.One of them being page 0/register 17.
It basically has input level control(0-0x8) and then 0xf(which is off) and
the values in-between 0x8-0xf as invalid.
How to give the input to mixer?As a switch or volume/bias control and what
is the most likely macro to be used.
DAPM_SINGLE?

--rohith
