From: castet.matthieu@free.fr
Subject: Re: [Alsa-devel] Trans.: intel8x0.c : missing define for disable midi
Date: Thu,  2 Sep 2004 13:32:36 +0200
Sender: alsa-user-admin@lists.sourceforge.net
Message-ID: <1094124756.413704d49abd6@imp1-q.free.fr>
References: <Pine.HPX.4.33n.0409010941270.1582-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-user-admin@lists.sourceforge.net>
In-Reply-To: <Pine.HPX.4.33n.0409010941270.1582-100000@studcom.urz.uni-halle.de>
Errors-To: alsa-user-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-user@lists.sourceforge.net>
List-Help: <mailto:alsa-user-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-user>
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-user@lists.sourceforge.net, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Selon Clemens Ladisch <clemens@ladisch.de>:

> castet.matthieu@free.fr wrote:
> > this patch add a missing define if you want to remove midi support fo=
rm it.
>
> Applied, thanks!
>
And what about the fact of registering the lpc : since it is use by other=
 driver
(hw_random, 8xx_tco, ...), you sould only find the pci device but not reg=
ister
it !!!

>
> Clemens
>

Matthieu




-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
