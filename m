From: Roland Stigge <stigge@antcom.de>
Subject: Re: Re: Bug#245668: kernel-source-2.6.5:
	intel8x0:	IEC958 output not working anymore
Date: Sat, 04 Sep 2004 11:24:31 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1094289871.3331.10.camel@atari.stigge.org>
References: <Pine.HPX.4.33n.0409031438540.16124-100000@studcom.urz.uni-halle.de>
	 <1094220009.4139.3.camel@atari.stigge.org>  <s5hzn47whwn.wl@alsa2.suse.de>
	 <1094229580.4140.7.camel@atari.stigge.org>
	 <1094253132.6575.77.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from stigge.org (pD9E7EA5E.dip.t-dialin.net [217.231.234.94])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id B713F285
	for <alsa-devel@alsa-project.org>; Sat,  4 Sep 2004 11:24:33 +0200 (MEST)
In-Reply-To: <1094253132.6575.77.camel@krustophenia.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Takashi Iwai <tiwai@suse.de>, Clemens Ladisch <clemens@ladisch.de>, maks attems <debian@sternwelten.at>, 245668-close@bugs.debian.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Folks,

On Sat, 2004-09-04 at 01:12, Lee Revell wrote:
> On Fri, 2004-09-03 at 12:39, Roland Stigge wrote:
> > When I played around I noticed that gnome-alsamixer segfaults when I
> > _uncheck_ "IEC958" during the playback:
> 
> Looks like a bug in gnome-alsamixer.  This is not developed by the ALSA
> project, please file a bug report with your distro.

OK, I will do it.

> Does it work with regular alsamixer?

Yes, it works now. I have to enable both "IEC958" and "Analog to IEC958
Output" to get digital output from PCM.

Thank you all very much for your patience.

bye,
  Roland



-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
