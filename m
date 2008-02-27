From: "William Juul" <william@juul.no>
Subject: new driver: channel alignment (was: 30mS interval
	problem)
Date: Wed, 27 Feb 2008 13:56:16 +0100
Message-ID: <2563ac9e0802270456q31e47995m4365a64e7574bbbf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.182])
	by alsa0.perex.cz (Postfix) with ESMTP id 5BD03103800
	for <alsa-devel@alsa-project.org>; Wed, 27 Feb 2008 13:56:17 +0100 (CET)
Received: by wa-out-1112.google.com with SMTP id m33so2666752wag.8
	for <alsa-devel@alsa-project.org>; Wed, 27 Feb 2008 04:56:16 -0800 (PST)
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

Hello

I am new to ALSA and trying to write a new driver for a ADC connected
with PCM to an AVR32 on a NGW100 reference card provided by Atmel.

I have the problem that different channels from the PCM stream comes
in different positions in the WAV file. For example when I disable all
but the first PCM channel on the ADC, I can see with an oscilloscope
that there is only data in the first timeslot on the PCM data stream.
But the data from this channel can occur in any of the 4 channels in
the WAV file. This is consistent throughout the one capture/file, but
in the next capture the data will occur in another channel in the
WAV-file.

How can I make sure that the data from one particular channel always
occur in a fixed position in the WAV file?

Best regards
William Juul
