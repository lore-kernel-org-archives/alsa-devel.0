From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [Alsa-user] Trans.: intel8x0.c : missing define for
 disable midi
Date: Fri, 03 Sep 2004 14:19:33 +0200 (METDST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0409031416480.16124-100000@studcom.urz.uni-halle.de>
References: <1094124756.413704d49abd6@imp1-q.free.fr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <1094124756.413704d49abd6@imp1-q.free.fr>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: castet.matthieu@free.fr
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

castet.matthieu@free.fr wrote:
> And what about the fact of registering the lpc : since it is use by other driver
> (hw_random, 8xx_tco, ...), you sould only find the pci device but not register
> it !!!

Fixed now.  In a rather drastic way. :)


Clemens



-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
