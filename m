From: Roland Stigge <stigge@antcom.de>
Subject: Re: Re: Bug#245668: kernel-source-2.6.5: intel8x0:
	IEC958 output not working anymore
Date: Fri, 03 Sep 2004 16:00:09 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1094220009.4139.3.camel__3719.25809090516$1094222298$gmane$org@atari.stigge.org>
References: <Pine.HPX.4.33n.0409031438540.16124-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from stigge.org (pD9E7EEC6.dip.t-dialin.net [217.231.238.198])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 41C642B6
	for <alsa-devel@alsa-project.org>; Fri,  3 Sep 2004 16:00:11 +0200 (MEST)
In-Reply-To: <Pine.HPX.4.33n.0409031438540.16124-100000@studcom.urz.uni-halle.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Clemens Ladisch <clemens@ladisch.de>
Cc: maks attems <debian@sternwelten.at>, 245668@bugs.debian.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

On Fri, 2004-09-03 at 14:43, Clemens Ladisch wrote:
> > intel8x0: IEC958 digital output (S/PDIF) is said not work
> > since kernel 2.6.4.
> 
> > lsmod:
> > snd_intel8x0           34824  0
> > i810_audio             33812  0
> 
> Don't load the ALSA and OSS drivers at the same time.

I don't. This is fixed in the current Debian setup. But the problem in
question persists.

> Does "aplay something.wav" work?
> Does "aplay -D spdif something.wav" work?
> If not, what happens?

$ aplay pub/mi1.wav
Playing WAVE 'pub/mi1.wav' : Signed 16 bit Little Endian, Rate 44100 Hz,
Mono
$ aplay -D spdif pub/mi1.wav
Playing WAVE 'pub/mi1.wav' : Signed 16 bit Little Endian, Rate 44100 Hz,
Mono
aplay: set_params:837: Channels count non available
$

The first invocation plays the file, the second returns immediately with
the above message.

bye,
  Roland



-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
