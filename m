From: "Alex Ander" <alibobar@gmail.com>
Subject: problems with 2 outputs on snd-hda-intel
Date: Mon, 29 Dec 2008 15:48:46 +0100
Message-ID: <9c73ddb90812290648i15a72642v749cbdd834e84425@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gx0-f16.google.com (mail-gx0-f16.google.com
	[209.85.217.16]) by alsa0.perex.cz (Postfix) with ESMTP id 9409324365
	for <alsa-devel@alsa-project.org>; Mon, 29 Dec 2008 15:48:47 +0100 (CET)
Received: by gxk9 with SMTP id 9so3288110gxk.8
	for <alsa-devel@alsa-project.org>; Mon, 29 Dec 2008 06:48:46 -0800 (PST)
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

My configuration:
http://www.alsa-project.org/db/?f=e33841b3aa560b031a3723ecf2e2c5040d2c1a16


Ever since I came back from the holidays I've been having this problem:


My laptop has 3 jacks: 2 line out and 1 line in that can be switched to out.

But, I can only get sound over the laptop-speakers and the line-in switched
to out.
The speaker stops playing when a jack is connected to one of the two outs,
but I don't get any sound over these outputs.

I have checked all mixer-settings in alsamixer, nothing works (except
switching the mic to lineout, which doesn't fix the other 2 outs)


As you can see in alsa-info I have forced a model-type to the module, I have
found this on
http://www.mjmwired.net/kernel/Documentation/sound/alsa/ALSA-Configuration.txt

I have tried all 4 modules listed at line 1015 (which should correspond to
the SigmaTel STAC9228) of which 3stack seems to be the one set by default
(with empty /etc/modprobe.conf) and is the only one that works with the
mic-as-output option.


I can give more info if you need it.
