From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: No mixer elems found
Date: Wed, 31 Mar 2004 07:38:13 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200403311238.i2VCcD33015334@dhin.linuxaudiosystems.com>
References: <6.0.0.22.0.20040331135721.0242fb48@pop.isti.cnr.it>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Wed, 31 Mar 2004 13:59:37 +0200."
             <6.0.0.22.0.20040331135721.0242fb48@pop.isti.cnr.it>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Vincenzo Di Salvo <Vincenzo.DiSalvo@isti.cnr.it>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>The problem is that I cannot get the mixer to have any "elements" (or=20
>"elems" as the alsamixer calls them) which thus makes the card un-openable=
>=20
>even with the alsamixer.

thats correct. the hdsp has no mixer that can be represented using
conventional mixer elements. there is nothing corresponding to any of
the controls that other cards tend to have (e.g. PCM volume, main
volume, capture source, etc)

if you want to control the mixer, use thomas charbonnel's hdspmixer,
which is a reimplementation of RME's TotalMix. it provides complete
control over the mixer. it is a standard part of ALSA.

--p


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
