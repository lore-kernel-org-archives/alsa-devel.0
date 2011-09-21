From: Ilya Dmitrichenko <errordeveloper@gmail.com>
Subject: Using the timer
Date: Wed, 21 Sep 2011 13:55:23 +0100
Message-ID: <CAPhDKbFdHV_7QXw=jZtmD3nmV8O0KoiREzDQ3gH=wtvf=C_L+A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vw0-f49.google.com (mail-vw0-f49.google.com
	[209.85.212.49]) by alsa0.perex.cz (Postfix) with ESMTP id 65B8424C3D
	for <alsa-devel@alsa-project.org>;
	Wed, 21 Sep 2011 14:55:25 +0200 (CEST)
Received: by vws15 with SMTP id 15so168522vws.8
	for <alsa-devel@alsa-project.org>; Wed, 21 Sep 2011 05:55:23 -0700 (PDT)
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

I would like to utilise the hardware timer which is in the soundcard
in an application.

I suppose that I can somehow set snd-seq-timer to use a particular
device as master
and access that via sequencer API? The particular device that I have
is Hammerfall
HDSP (snd-hdsp).

Cheers,
-- 
Ilya
