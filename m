From: Torsten Mohr <tmohr@s.netic.de>
Subject: Re: Docu:: Alsa Audio API:: A minimal capture program
Date: Mon, 9 Feb 2004 18:18:33 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200402091818.33864.tmohr@s.netic.de>
References: <Pine.HPX.4.33n.0401281614420.11576-100000@studcom.urz.uni-halle.de> <200402090119.00259.tmohr@s.netic.de> <Pine.LNX.4.58.0402090845210.2168@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.58.0402090845210.2168@pnote.perex-int.cz>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,

> You've made this stupid bug:
>
> data = (unsigned char *)calloc(SAMPLES*4, 0);
>
> should be:
>
> data = (unsigned char *)calloc(periodsize*4, 1);


thank you so very much for that hint, that was the problem.


Best regards,
Torsten.



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
