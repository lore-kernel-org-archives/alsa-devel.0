From: Valdis.Kletnieks@vt.edu
Subject: Re: Fix sequencer missing negative bound check
Date: Wed, 15 Mar 2006 22:07:20 -0500
Message-ID: <200603160307.k2G37KLX007666__37723.0738559321$1142478492$gmane$org@turing-police.cc.vt.edu>
References: <20060316011911.GA20384@eugeneteo.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1142478440_5420P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from turing-police.cc.vt.edu (turing-police.cc.vt.edu [128.173.14.107])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 43E5B20E
	for <alsa-devel@alsa-project.org>; Thu, 16 Mar 2006 04:07:30 +0100 (MET)
In-Reply-To: Your message of "Thu, 16 Mar 2006 09:19:11 +0800."
             <20060316011911.GA20384@eugeneteo.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Eugene Teo <eugene.teo@eugeneteo.net>
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

--==_Exmh_1142478440_5420P
Content-Type: text/plain; charset=us-ascii

On Thu, 16 Mar 2006 09:19:11 +0800, Eugene Teo said:
> dev is missing a negative bound check.
> 
> Signed-off-by: Eugene Teo <eugene.teo@eugeneteo.net>
> 
> --- linux-2.6/sound/oss/sequencer.c~	2006-03-15 10:05:45.000000000 +0800
> +++ linux-2.6/sound/oss/sequencer.c	2006-03-16 09:06:59.000000000 +0800
> @@ -713,7 +713,7 @@
>  	int i, l = 0;
>  	unsigned char  *buf = &event_rec[2];
>  
> -	if ((int) dev > max_synthdev)
> +	if (dev < 0 || dev >= max_synthdev)
>  		return;
>  	if (!(synth_open_mask & (1 << dev)))
>  		return;

Erm??

Looking at a bit more context for the function:

static void seq_sysex_message(unsigned char *event_rec)
{
        int dev = event_rec[1];
        int i, l = 0;
        unsigned char  *buf = &event_rec[2];

        if ((int) dev > max_synthdev)
                return;
        if (!(synth_open_mask & (1 << dev)))
                return;
        if (!synth_devs[dev])
                return;

that 'int dev' came out of an 'unsigned char *' - as such, I doubt you
can get a negative value.  If anything, it should be 'unsigned int dev'.

--==_Exmh_1142478440_5420P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFEGNZocC3lWbTT17ARAs6xAJ91+YwE3g7n/AMwsiqz5CRN4TWIygCgpJ23
1bS1NrCIQ6osl5v3o5owHNk=
=ahcq
-----END PGP SIGNATURE-----

--==_Exmh_1142478440_5420P--


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
