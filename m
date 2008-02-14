From: "Pharaoh ." <pharaoh137@gmail.com>
Subject: ALSA MIDI interface - plugin
Date: Thu, 14 Feb 2008 20:54:28 +0530
Message-ID: <61445c750802140724h1585b495pcc546e2b082e086a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wr-out-0506.google.com (wr-out-0506.google.com [64.233.184.228])
	by alsa0.perex.cz (Postfix) with ESMTP id 7D64724543
	for <alsa-devel@alsa-project.org>; Thu, 14 Feb 2008 16:24:30 +0100 (CET)
Received: by wr-out-0506.google.com with SMTP id 60so692819wri.8
	for <alsa-devel@alsa-project.org>; Thu, 14 Feb 2008 07:24:29 -0800 (PST)
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

Hi

I am writing an user space ALSA i/o type PCM plugin for my board. I chose
this
rather unconventional approach for supporting ALSA apps since the the the
driver
which communicates with DSP using shared memory is in userspace and for some
constraints the driver communication driver will always be in userspace. My
audio
plugin uses calls of the coomunication driver and talks to DSP. I already
have
a working plugin in place. I use it like following,

#aplay -D my_plugin test.wav

and it works.

Now, I have to support rawmidi interface also. Is it possible to write a
userspace
plugin for making MIDI work? Where can I get sample code etc?

-pharaoh.
