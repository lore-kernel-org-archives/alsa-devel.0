From: Metathronius Galabant <m.galabant@googlemail.com>
Subject: Frame-based access (via mmap) and cross-device
	synchronisation
Date: Mon, 20 Jul 2009 16:03:06 +0200
Message-ID: <1b270aae0907200703l50ddd108se3ad0f6801113540@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f226.google.com (mail-fx0-f226.google.com
	[209.85.220.226])
	by alsa0.perex.cz (Postfix) with ESMTP id AB068103805
	for <alsa-devel@alsa-project.org>;
	Mon, 20 Jul 2009 16:03:07 +0200 (CEST)
Received: by fxm26 with SMTP id 26so2153179fxm.32
	for <alsa-devel@alsa-project.org>; Mon, 20 Jul 2009 07:03:06 -0700 (PDT)
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

Hi all,

I could not find any examples, plus the alsa documentation and the
pcm.c example on mmap-style access is rather slim.
Consider the following setting:

I have 2 seperate HW devices that are NOT clock sync'ed; their period
is set to 10ms, and the total SW buffer is set to 20ms (= classic
double buffering) or 40ms.
Now I need to read from the 1st device and write to the 2nd device -
and read from the 2nd device and write to the 1st device.

Now, to synchronise - because their clocks do drift - I'd like to have
the following semantics:

At any given time x0, x1, ... xn I'd like to take some kind of
"snapshot" of both devices, ask them "how many frame do you have?".
This MUST NOT be restricted to the period, but it should be like
device1 has 80 frames, device2 only has 78 frames. In short I would
need pure frame-based access at any given time.
I will then manually discard or duplicate frames to keep both streams happy.

How do I achieve this kind of access method via alsa?

Any help is welcome. Thanks!
M.
