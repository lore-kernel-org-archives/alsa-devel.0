From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: CVS: alsa-kernel/include initval.h,1.6,1.7
Date: Tue, 03 Dec 2002 09:03:53 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0212030851240.16539-100000@studcom.urz.uni-halle.de>
References: <E18IvsN-0004W8-00@sc8-pr-cvs1.sourceforge.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <E18IvsN-0004W8-00@sc8-pr-cvs1.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@users.sourceforge.net>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

It seems the fix for the get_id fix needs another fix. ;-)

Jaroslav Kysela wrote:
> --- initval.h	28 Nov 2002 13:54:34 -0000	1.6
> +++ initval.h	2 Dec 2002 19:04:56 -0000	1.7
> @@ -155,11 +155,14 @@
>  		...
>  		while (isalpha(*s) || isdigit(*s) || *s == '_')
>  			if (d != NULL)
> +				*d++ = *s;
> +			s++;
> +		if (d != NULL)
>  		...

Without braces, the s++ isn't part of the while loop.


Regards,
Clemens




-------------------------------------------------------
This SF.net email is sponsored by: Get the new Palm Tungsten T 
handheld. Power & Color in a compact size! 
http://ads.sourceforge.net/cgi-bin/redirect.pl?palm0002en
