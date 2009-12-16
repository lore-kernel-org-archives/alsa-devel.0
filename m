From: =?UTF-8?Q?Fr=C3=A9d=C3=A9ric_Bri=C3=A8re?= <fbriere@fbriere.net>
Subject: 2.6.30-rc8 skipping regression also affects cmipci
Date: Wed, 16 Dec 2009 21:17:37 +0000 (UTC)
Message-ID: <hgbiph$4kr$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lo.gmane.org (lo.gmane.org [80.91.229.12])
	by alsa0.perex.cz (Postfix) with ESMTP id 45C9B244C4
	for <alsa-devel@alsa-project.org>; Wed, 16 Dec 2009 22:20:08 +0100 (CET)
Received: from list by lo.gmane.org with local (Exim 4.50) id 1NL1Hx-0003K8-Dg
	for alsa-devel@alsa-project.org; Wed, 16 Dec 2009 22:20:05 +0100
Received: from 69-196-178-247.dsl.teksavvy.com ([69.196.178.247])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Wed, 16 Dec 2009 22:20:05 +0100
Received: from fbriere by 69-196-178-247.dsl.teksavvy.com with local (Gmexim
	0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Wed, 16 Dec 2009 22:20:05 +0100
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

Hi everybody,

I was only recently able to upgrade from 2.6.26 to 2.6.32 (long story).
In so doing, I noticed infrequent occurrences of audio skipping, which I
managed to bisect down to c87d973.  It would appear that this commit
also affects cmipci (CMI8738), albeit not as badly as it did for
intel8x0.  (I guess I'm the only person left on Earth still using a
stand-alone PCI sound card, which is why this was never reported.  <g>)

Here's a sample log output after turning xrun debugging on:

  [  171.555860] PCM: hw_ptr skipping! (pos=6341, delta=16383, period=1024, jdelta=0/85)
  [  181.114680] PCM: hw_ptr skipping! (pos=12529, delta=16370, period=1024, jdelta=0/85)
  [  181.114770] PCM: hw_ptr skipping! (pos=12534, delta=16375, period=1024, jdelta=0/85)
  [ 1713.774316] PCM: hw_ptr skipping! (pos=9456, delta=16369, period=1024, jdelta=0/85)
  [ 1713.774346] PCM: hw_ptr skipping! (pos=9458, delta=16371, period=1024, jdelta=0/85)
  [ 1713.774409] PCM: hw_ptr skipping! (pos=9461, delta=16374, period=1024, jdelta=0/85)
  [ 1713.774613] PCM: hw_ptr skipping! (pos=9470, delta=16383, period=1024, jdelta=0/85)
  [ 1831.092000] PCM: hw_ptr skipping! (pos=1712, delta=16373, period=1024, jdelta=0/85)
  [ 1953.347453] PCM: hw_ptr skipping! (pos=3723, delta=16316, period=1024, jdelta=0/84)
  [ 1953.347465] PCM: hw_ptr skipping! (pos=3724, delta=16317, period=1024, jdelta=0/84)
  [ 1953.347485] PCM: hw_ptr skipping! (pos=3725, delta=16318, period=1024, jdelta=0/84)


You'll notice that this occurs much less frequently than it did for
intel8x0.

However, I left MPlayer on pause for the night, and at some point the
kernel started spewing several syslog messages every couple of seconds:

  [25332.211286] PCM: hw_ptr skipping! [Q] (pos=4, delta=-1073740800, period=1024, jdelta=5/44744/0)
  [25332.232637] PCM: hw_ptr skipping! [Q] (pos=1029, delta=-1073739771, period=1024, jdelta=6/44749/0)
  [25332.253957] PCM: hw_ptr skipping! [Q] (pos=2053, delta=-1073738747, period=1024, jdelta=5/44755/0)
  [25332.275292] PCM: hw_ptr skipping! [Q] (pos=3077, delta=-1073737723, period=1024, jdelta=5/44760/0)
  [25332.296616] PCM: hw_ptr skipping! [Q] (pos=4101, delta=-1073736699, period=1024, jdelta=6/44765/0)
  [25332.317932] PCM: hw_ptr skipping! [Q] (pos=5125, delta=-1073735675, period=1024, jdelta=5/44771/0)
  [25332.339269] PCM: hw_ptr skipping! [Q] (pos=6149, delta=-1073734651, period=1024, jdelta=5/44776/0)
  [25332.360600] PCM: hw_ptr skipping! [Q] (pos=7173, delta=-1073733627, period=1024, jdelta=6/44781/0)
  [25332.381942] PCM: hw_ptr skipping! [Q] (pos=8197, delta=-1073732603, period=1024, jdelta=5/44787/0)
  [25332.403261] PCM: hw_ptr skipping! [Q] (pos=9221, delta=-1073731579, period=1024, jdelta=5/44792/0)
  [25337.244901] PCM: hw_ptr skipping! [Q] (pos=12293, delta=-1073728507, period=1024, jdelta=6/44808/0)
  [25337.266223] PCM: hw_ptr skipping! [Q] (pos=13317, delta=-1073727483, period=1024, jdelta=5/44813/0)


This kept going on until I quit MPlayer (which, as I said, was not
actually playing anything all this time).  Not that skipped silence is
much of an issue, but I thought this might add useful information.


Let me know if I can be of any help in resolving this.


-- 
If you want to travel around the world and be invited to speak at a lot
of different places, just write a Unix operating system.
		-- Linus Torvalds
