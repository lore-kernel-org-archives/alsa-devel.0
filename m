From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: OSS driver removal, 2nd round
Date: Mon, 03 Jul 2006 21:52:59 +1000
Message-ID: <1151927579.13828.6.camel@localhost.localdomain>
References: <20060629192128.GE19712@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 019D121B
	for <alsa-devel@alsa-project.org>;
	Mon,  3 Jul 2006 13:53:08 +0200 (MEST)
In-Reply-To: <20060629192128.GE19712@stusta.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Adrian Bunk <bunk@stusta.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, perex@suse.cz, Olaf Hering <olh@suse.de>
List-Id: alsa-devel@alsa-project.org


> DMASOUND_PMAC
> - Olaf Hering regarding regressions in SND_POWERMAC:
>   Some tumbler models work only after one plug/unplug cycle of
>   the headphone. early powerbooks report/handle the mute settings
>   incorrectly. there are likely more bugs.

dmasound_pmac is crippled with bugs too... We should look at reported
bug reports on snd-powermac (and snd-aoa which replaces the later for
recent machines) and kill dmasound-pmac. I'm ok with that. snd-aoa is
the only one to be properly maintained anyway, we'll add support for
older machines to it over time and hopefully, it's a much saner codebase
in the first place so handling weird machines regressions will be
easier.

Ben.



Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
