From: Daniel Stodden <dns@somacoma.net>
Subject: Intel HDA volume low
Date: Sun, 08 Mar 2009 04:23:26 -0700
Message-ID: <1236511406.21390.15.camel@ramone.van.xensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from vs137225.vserver.de
	(static-ip-62-75-137-225.inaddr.intergenia.de [62.75.137.225])
	by alsa0.perex.cz (Postfix) with ESMTP id 63D812433F
	for <alsa-devel@alsa-project.org>; Sun,  8 Mar 2009 12:23:31 +0100 (CET)
Received: from [192.168.1.128] (S0106000e08cec998.vc.shawcable.net
	[96.49.210.198]) (Authenticated sender: dns)
	by vs137225.vserver.de (Postfix) with ESMTP id EFCC68A70070
	for <alsa-devel@alsa-project.org>; Sun,  8 Mar 2009 12:23:28 +0100 (CET)
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


Hi.

I've got a Lenovo Thinkpad T400 with snd_hda_intel:

00:1b.0 Audio device: Intel Corporation 82801I (ICH9 Family) HD Audio
Controller (rev 03)
Subsystem: Lenovo Device 20f2

I think this is the same chip which recently quirks entries to work
around docking issues on the Thinkpad x200.

The codec is identified as a conexant CX20561 (Hermosa).

Running Ubuntu 8.10 with 2.6.27, the Volume is extremely low. Quality
seems okay, but setting Master and PCM outputs to 100% is barely
audible. There's a bunch of similar reports on the Internet. I could not
find any workaround but Window users usually report the volume should be
fine.

I tried 2.6.28 but to no avail. Will verify against latest git.

Could someone help me fix this? I don't actually know much about the
hardware in question, but would also willing to poke a little around in
patch_conexant.c, if that could help identifying the issue. Provided
someone someone around here has advice on what to try out.

Cheers,
Daniell
