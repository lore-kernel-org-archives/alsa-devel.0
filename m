From: Matias Alejo Garcia <alsa@matiu.com.ar>
Subject: CS4205 SPDIF
Date: 07 Nov 2002 03:02:59 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1036656179.3629.21.camel@runner.matiu.com.ar>
References: <200211062150.WAA04935@alsa.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from gull.mail.pas.earthlink.net (gull.mail.pas.earthlink.net [207.217.120.84])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id JAA14883
	for <alsa-devel@alsa-project.org>; Thu, 7 Nov 2002 09:03:55 +0100
Received: from sdn-ap-006scfairp0233.dialsprint.net ([63.184.240.233] helo=runner.matiu.com.ar)
	by gull.mail.pas.earthlink.net with esmtp (Exim 3.33 #1)
	id 189hdi-0002PT-00
	for alsa-devel@alsa-project.org; Thu, 07 Nov 2002 00:03:46 -0800
In-Reply-To: <200211062150.WAA04935@alsa.alsa-project.org>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Alsa devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


Hi!

   I was able to use the SPDIF output of my Dell I8200 (CS4205 crappy
sound), by making the following small change in the alsa drivers:

===================================================================
RCS file: RCS/ac97_id.h,v
45c45,46
< #define AC97_ID_CS4205		0x43525958
---
> #define AC97_ID_CS4205		0x4352595B


Now, I have the IEC958 controls OK, and everything works, but, I still
wasn't able to output an AC3 stream into the SPDIF.

My card has no LFE, and REAR controls in the alsamixer. That is ok,
because the CS4205 is not a 5.1 sound card, at least in the 'analog'
sense.

If I try aplay -D plug:rear or aplay -D plug:lfe or aplay -D
plug:surround51 I get things like:
'aplay: set_params:764: Broken configuration for this PCM: no
configurations available'
which I think is ok. '-D plug:iec958' works.

BUT, what about sending a AC3 stream directly to the SPDIF?? How can I
do that??
I tried:
  ac3play --card 0,0 matrix.ac3
but I get nothing but noise. The same noise with
   mplayer -ao alsa9:iec958 -ac hwac3 -dvd 1

Mplayer tell me:
alsa-init: requested format: 48000 Hz, 2 channels, AC3
alsa-init: soundcard set to iec958:AES0=0x2,AES1=0x82,AES2=0x0,AES3=0x2

if I tried -channels 6, mplayer tried 'surround51' and I get other
error.

Any idea how can I try to do that??? Thank you very much!! 

Matias



-------------------------------------------------------
This sf.net email is sponsored by: See the NEW Palm 
Tungsten T handheld. Power & Color in a compact size!
http://ads.sourceforge.net/cgi-bin/redirect.pl?palm0001en
