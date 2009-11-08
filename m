From: Jonathan Leonard <jonathan.adams.leonard@gmail.com>
Subject: RME HDSPe AIO
Date: Sun, 8 Nov 2009 11:38:08 -0800
Message-ID: <1401522d0911081138i2ebf7aa8h4467a135c93a526@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f209.google.com (mail-fx0-f209.google.com
	[209.85.220.209])
	by alsa0.perex.cz (Postfix) with ESMTP id 12E83103811
	for <alsa-devel@alsa-project.org>; Sun,  8 Nov 2009 20:38:11 +0100 (CET)
Received: by fxm1 with SMTP id 1so2708781fxm.32
	for <alsa-devel@alsa-project.org>; Sun, 08 Nov 2009 11:38:09 -0800 (PST)
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

Hello, I am writing in regards to the RME HDSPe AIO card and its support in
ALSA.  The card itself in 64studio is recognized incorrectly as HDSP MADI
rev d4.

Running lspci -nn shows this line for the device:

02:00.0 Multimedia audio controller [0401]: Xilinx Corporation RME
Hammerfall DSP MADI [10ee:3fc6] (rev d4)

ALSA in 64studio 3.0 beta 3 loads snd-hdspm incorrectly when it should be
loading snd-hdsp.

I have reviewed pcitables and pci.ids on this distro, and also the public
pci reference and the above device id is currently assigned to:

Multimedia audio controller: Xilinx Corporation RME Hammerfall DSP MADI (rev
d4)

The AIO is purported to be very similar to the 9632 and should be using the
snd-hdsp module.

I would like to use this card in ALSA, and have begun reviewing the guide
for making ALSA drivers, but am not sure how exactly to fix the matter since
the manufacturer has not incremented the id, or they have not assigned the
same id as a 9632.  This device is recognized and functioning perfectly on
the XP partition.

Besides my individual circumstance I wonder if ALSA should not be
accomodating this great card somehow.

Let me know if I can help by contacting RME developers for info or
otherwise.

Thank you,

jonathan adams leonard
