From: John Ettedgui <john.ettedgui@gmail.com>
Subject: ALSA Multichannel through HDMI
Date: Thu, 7 Jan 2010 20:25:03 -0800
Message-ID: <eb9000ab1001072025l4145197ahc1abdfbfdc6f99fd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pz0-f192.google.com (mail-pz0-f192.google.com
	[209.85.222.192])
	by alsa0.perex.cz (Postfix) with ESMTP id 31D2E2453B
	for <alsa-devel@alsa-project.org>; Fri,  8 Jan 2010 05:25:05 +0100 (CET)
Received: by pzk30 with SMTP id 30so11487655pzk.24
	for <alsa-devel@alsa-project.org>; Thu, 07 Jan 2010 20:25:03 -0800 (PST)
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

Hello,

(since I did not get any feedback on the user ml, I'm trying it here, sorry...)

I am using the HDMI output of my radeonhd 4670 to get sound, but I
cannot get ALSA to work with (5.1) multichannel, it only outputs to the
front left and right speakers (checked by speaker-test).

I tried following this howto:
http://www.cse.ohio-state.edu/~bondhugu/alsamch.shtml
but it did not do much for me... and whenever I tried to add
slave.channels 6, I just could not use alsa anymore, it always
complained about this line...
I tried channels 6 as part of the slave.pcm{} too and got the same result...


What should I look into?
I tried with 2.6.32 and alsa-lib 1.0.21.a, and then 2.6.33-rc3 (stil
using alsa-driver 1.0.21 it seems) and alsa-lib 1.0.22 and no success.
I am using the radeonhd xorg driver to get HDMI audio.

I compiled alsa-driver 1.0.22.1 on top of a 2.6.32.2 kernel and the
result is still the same although this time I did not play with the
asound.conf file.

Pulse audio on top of alsa does give me a 5.0 setup or at least I can
hear that from the speaker-test.


Thank you,
John
