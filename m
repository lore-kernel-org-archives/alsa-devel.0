From: =?ISO-8859-1?Q?Damien_Th=E9bault?= <damien.thebault@gmail.com>
Subject: HDMI out with Zepto Nox A14, help for a patch
Date: Thu, 29 Jul 2010 13:27:02 +0200
Message-ID: <AANLkTi=JVQxf+Mm=UqeonejfuJiRX_562PU=38-Lh0L8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qy0-f179.google.com (mail-qy0-f179.google.com
	[209.85.216.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 23B8D24368
	for <alsa-devel@alsa-project.org>;
	Thu, 29 Jul 2010 13:27:04 +0200 (CEST)
Received: by qyk8 with SMTP id 8so105359qyk.17
	for <alsa-devel@alsa-project.org>; Thu, 29 Jul 2010 04:27:03 -0700 (PDT)
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

My laptop is a Zepto Nox A14, with an ALC 262 audio chip.
HDMI is connected through an NVIDIA GeForce 9600 graphic card.

After some investigation, it appears that to output HDMI audio, I have
to use the sound card which has a digital out for HDMI connected to
the graphic card (there is no nvhdmi thing).
I noticed with hda_analyser that there are two digital audio out
nodes, the first one is the default ALC 262 one (S/PDIF). With the
default configuration, when I enable what's called "HDMI" it's S/PDIF
that is enabled (and I can see the red light on the mini-TOSLINK jack
when it's enabled).
So I was thinking that the second digital out was for the real HDMI.

I went into patch_realtek.c and used the id of the second digital out
(0x10) instead of ALC_262_DIGOUT_NID (0x06) in
alc262_parse_auto_config.
That allowed me to have a alsa device hw:0,3 connected to the digital
out 0x10 instead of having it on 0x06.
Then I had to enable the linked pin too, because otherwise I didn't
have any sound. The pin connected to the digital out 0x10 is 0x11 (the
one connected to 0x06 is 0x1e).

So in the end, I'm able to have HDMI sound! Now here are my questions:

 - how can I add this with SND_PCI_QUIRK?
I think that I have to find the IDs of my setup (PCI ID?) and then
create a preset. How can I find this ID on my system?
There is a dig_out_nid field in the preset so I would use 0x10 instead
of ALC262_DIGOUT_NID (0x06).
I don't know how to change the pin from 0x1e to 0x11, is it automatic?

 - doing this will disable my S/PDIF output, is it possible to juste
have both outputs available?

Thanks!
-- 
Damien Thebault
