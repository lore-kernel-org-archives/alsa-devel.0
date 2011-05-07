From: preetam <preetamsashankreddy@gmail.com>
Subject: aplay throws error
Date: Sat, 07 May 2011 12:57:03 +0530
Message-ID: <4DC4F447.4040607@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pz0-f51.google.com (mail-pz0-f51.google.com
	[209.85.210.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 95B311037EC
	for <alsa-devel@alsa-project.org>;
	Sat,  7 May 2011 09:27:13 +0200 (CEST)
Received: by pzk26 with SMTP id 26so2061025pzk.38
	for <alsa-devel@alsa-project.org>; Sat, 07 May 2011 00:27:12 -0700 (PDT)
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

Hai,

My aplay throws the following error:

Playing WAVE 'Linkin Park - New divide.wav' : Signed 16 bit Little 
Endian, Rate 44100 Hz, Stereo
aplay: aplay.c:1029: set_params: Assertion `err >= 0' failed.
Aborted by signal Aborted...


I am using a pandaboard. Kernel is 2.6.35 from omap tree L27.11.1.

I am new to alsa and I have written an soc driver for this.
can anyone help me.

I can only trace the function calls to alloca. I am blank from here on.

Regards,
Preetam
