From: Jussi Laako <jussi.laako@pp.inet.fi>
Subject: Re: Re: The obsolence of OSS, Was: big smile
Date: Wed, 25 Feb 2004 19:45:09 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1077731109.8866.38.camel@vaarlahti.uworld>
References: <Pine.LNX.4.58.0402241536450.1883@pnote.perex-int.cz>
	 <403BC832.4080404@gardena.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from rankki.sonarnerd.net (_postfix@dsl-hkigw3hb0.dial.inet.fi [80.222.39.176])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id SAA03943
	for <alsa-devel@alsa-project.org>; Wed, 25 Feb 2004 18:44:48 +0100
Received: from [192.168.74.3] (vaarlahti [192.168.74.3])
	by rankki.sonarnerd.net (Postfix) with ESMTP id 2472878D01
	for <alsa-devel@alsa-project.org>; Wed, 25 Feb 2004 19:44:43 +0200 (EET)
In-Reply-To: <403BC832.4080404@gardena.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, 2004-02-24 at 23:54, Benno Senoner wrote:

> far more advanced ???
> Ok I'd like see Ardour runnnig with multiple 24bit cards, all the 
> switches for hardware monitoring etc under OSS.

At least I can play sound from application A to S/PDIF output and
simultaneously record input channels 1&2 on my Delta1010.

ALSA deadlocks the machine, OSS works.

> Only a fool would write a new linux audio app that does not use ALSA, 
> especially apps that need MIDI.

Well, I'm a fool then. I support OSS, ALSA, Comedi
(http://www.comedi.org/) and Jack in my apps.

Only fool writes app which runs only on Linux, and ALSA is currently
Linux-only. I want my app to run on FreeBSD, Solaris and others also.

> Ok jackd will probably become the "audio interface" of choice, but jackd 
> using ALSA is more powerful than in the OSS case,
> (talking of pure PCM based apps, with PCM/MIDI apps the advantage is 
> even more apparent).

How's that for PCM?

> are demanding multimedia features like MIDI, support of highend cards, 
> jackd support etc.

OSS supports various "highend" cards, like Lynx Studio stuff.


I'm not saying that ALSA is bad, but just blindly bashing OSS isn't
doing any good for anyone.


-- 
Jussi Laako <jussi.laako@pp.inet.fi>



-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
