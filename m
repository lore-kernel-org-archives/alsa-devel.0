From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Re: Bug#245668: kernel-source-2.6.5: intel8x0: IEC958
 output not working anymore
Date: Fri, 03 Sep 2004 14:43:38 +0200 (METDST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0409031438540.16124-100000__2828.60286902196$1094217568$gmane$org@studcom.urz.uni-halle.de>
References: <20040829215501.GI17837@stro.at>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mailgate2.uni-halle.de (mailgate2.urz.uni-halle.de [141.48.3.8])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id DDE2E2C0
	for <alsa-devel@alsa-project.org>; Fri,  3 Sep 2004 14:43:51 +0200 (MEST)
In-reply-to: <20040829215501.GI17837@stro.at>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Roland Stigge <stigge@antcom.de>
Cc: maks attems <debian@sternwelten.at>, 245668@bugs.debian.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

maks attems wrote:
> intel8x0: IEC958 digital output (S/PDIF) is said not work
> since kernel 2.6.4.

Roland Stigge wrote:
> lsmod:
> snd_intel8x0           34824  0
> i810_audio             33812  0

Don't load the ALSA and OSS drivers at the same time.


Does "aplay something.wav" work?
Does "aplay -D spdif something.wav" work?
If not, what happens?


Clemens



-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
