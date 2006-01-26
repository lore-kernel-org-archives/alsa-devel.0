From: John Rigg <ad@sound-man.co.uk>
Subject: Re: Some problems with two 1010LTs (pcm_multi & jackd)
Date: Thu, 26 Jan 2006 19:10:57 +0000
Message-ID: <20060126191057.GA3802@localhost.localdomain>
References: <43D8D6E9.80902@findus.dhs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail3.uklinux.net (mail3.uklinux.net [80.84.72.33])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 9FB8A194
	for <alsa-devel@alsa-project.org>; Thu, 26 Jan 2006 19:59:52 +0100 (MET)
Content-Disposition: inline
In-Reply-To: <43D8D6E9.80902@findus.dhs.org>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Petter =?iso-8859-1?Q?Sundl=F6f?= <petter.sundlof@findus.dhs.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Jan 26, 2006 at 03:04:25PM +0100, Petter Sundl=F6f wrote:
> # S/PDIF section. Comment out if not required.
>=20
> # S/PDIF first soundcard (capture)
>  	bindings.16.slave a
>  	bindings.16.channel 8
>  	bindings.17.slave a
>  	bindings.17.channel 9
>    =20
> # S/PDIF second soundcard (capture)
>  	bindings.18.slave b
>  	bindings.18.channel 8
>  	bindings.19.slave b
>  	bindings.19.channel 9

> # S/PDIF section. Comment out if not required.
>=20
> # S/PDIF first soundcard (playback)
>  	bindings.16.slave a
>  	bindings.16.channel 8
>  	bindings.17.slave a
>  	bindings.17.channel 9
>    =20
> # S/PDIF second soundcard (playback)
>  	bindings.18.slave b
>  	bindings.18.channel 8
>  	bindings.19.slave b
>  	bindings.19.channel 9

One more thing - I'm not sure if the S/PDIFs are working yet on 1010LT.
Try commenting these sections out in .asoundrc.

John


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
