From: "Daniel Sabo" <danielsabo@gmail.com>
Subject: Audigy LS driver
Date: Sun, 25 Nov 2007 12:20:48 -0800
Message-ID: <ece7e2ab0711251220p3f003daao819d44999e23451e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nz-out-0506.google.com (nz-out-0506.google.com [64.233.162.232])
	by alsa0.perex.cz (Postfix) with ESMTP id D761F24604
	for <alsa-devel@alsa-project.org>; Sun, 25 Nov 2007 21:20:50 +0100 (CET)
Received: by nz-out-0506.google.com with SMTP id m22so137035nzf
	for <alsa-devel@alsa-project.org>; Sun, 25 Nov 2007 12:20:49 -0800 (PST)
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

Hi,
I'm interested in helping with the ca0106 driver. My understanding is
that the dmix and multi plugins can't be used with each other, which
means that right now it not possible to have a dmixed surround sound
device with this card.

The driver has 4 stereo devices on it (one for each DSP on the
board?), would it be possible for me to merge devices 0,1, and 2 into
a single 6 channel device?

I have some experience with driver development doing ARM SoC stuff,
but this is my first time messing with a linux driver.

Thanks,
- Daniel Sabo
