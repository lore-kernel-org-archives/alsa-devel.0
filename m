From: Thomas Stenhaug <thomas.stenhaug@gmail.com>
Subject: Bug: Mic problem, mostly noise, almost no signal,
	AD1988B on an Asus 	P5B
Date: Mon, 16 Feb 2009 00:10:03 +0100
Message-ID: <f96756290902151510n170f6eaaw14311378fe1db608@mail.gmail.com>
References: <f96756290902151506n2b956961ibf0e74192c74bbb7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f19.google.com (mail-ew0-f19.google.com
	[209.85.219.19]) by alsa0.perex.cz (Postfix) with ESMTP id C50E62451D
	for <alsa-devel@alsa-project.org>; Mon, 16 Feb 2009 00:10:04 +0100 (CET)
Received: by ewy12 with SMTP id 12so1914737ewy.8
	for <alsa-devel@alsa-project.org>; Sun, 15 Feb 2009 15:10:04 -0800 (PST)
In-Reply-To: <f96756290902151506n2b956961ibf0e74192c74bbb7@mail.gmail.com>
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

Current settings and info here:
http://www.alsa-project.org/db/?f=021ee315857ae0928de665f1f0924cc84c609576

When I record with these settings, I get a /lot/ of static, and discernible
signal when I tap the microphone on my desktop, or scream into it.
The static gets better when I reduce the capture level, but the signal is
still barely discernible.

The microphone works in the same jack when the computer is running Windows.
 I've also tried a different mic, with the same results.

Playback works flawlessly.

I have seen some posts with people having problems that sound similar, and
some of them seems to be resolved by enabling Mic bias.  However, I don't
have a control called that when I look at alsamixer.
My system is running Debian Etch.  When I started working on this problem, I
used the packages from the "testing" (Etch) repository.  I then pulled in
alsa-base and alsa-utils from the "experimental" repository, and compiled
the 1.0.18a drivers.  This changed nothing in the recordings, nor did any
new controls appear in alsamixer.

I added "snd-hda-intel: model=6stack-dig" to /etc/modprobe.db/alsa-base, and
there was no change in the visible controls.

Regards,


Thomas
