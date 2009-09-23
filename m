From: =?UTF-8?B?T3phbiDDh2HEn2xheWFu?= <ozan@pardus.org.tr>
Subject: No sound after returning from suspend-to-ram
Date: Wed, 23 Sep 2009 21:20:19 +0300
Message-ID: <4ABA66E3.7090202@pardus.org.tr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lider.pardus.org.tr (lider.uludag.org.tr [193.140.100.216])
	by alsa0.perex.cz (Postfix) with ESMTP id B2B7D103890
	for <alsa-devel@alsa-project.org>;
	Wed, 23 Sep 2009 20:20:21 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

Hi,

A user complains that after returning from suspend-to-ram, he isn't able
to get any sound from his laptop until rebooting. I delayed reporting
this one because I once thought that it may be related to Pulseaudio or
some kind of mixer level problem but now I tried to suspect the kernel
and the drivers as well.

This is 2.6.30.5 with alsa-* 1.0.21a. I have dmesg and alsa-info outputs
before and after s2ram:

dmesg before s2ram:
  http://bugs.pardus.org.tr/attachment.cgi?id=4454

alsa-info before s2ram:
  http://bugs.pardus.org.tr/attachment.cgi?id=4455

dmesg after s2ram:
  http://bugs.pardus.org.tr/attachment.cgi?id=4456

alsa-info after s2ram:
  http://bugs.pardus.org.tr/attachment.cgi?id=4457


Note that a traceback is dumped in dmesg during resume. Maybe it will
give a clue about the problem, dunno.


And there's something like

hda_codec: invalid CONNECT_LIST verb 12[2]:2100

in regular dmesg output, i wonder what does that mean too.

Any ideas?
Thanks,

Ozan Caglayan
