From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Cannot play .au file with CVS Audigy2 driver
Date: Thu, 17 Mar 2005 14:30:45 +0100 (MET)
Message-ID: <Pine.HPX.4.33n.0503171429020.7260-100000@studcom.urz.uni-halle.de>
References: <20050313001355.76730.qmail@web52901.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
In-Reply-To: <20050313001355.76730.qmail@web52901.mail.yahoo.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Chris Rankin <rankincj@yahoo.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Chris Rankin wrote:
> $ aplay monk.au
> Playing Sparc Audio 'monk.au' : Mu-Law, Rate 8000 Hz, Mono
> aplay: set_params:857: Sample format non available

Did you redefine the "default" device?

The default "default" definition uses plughw:0 which automatically
converts sample formats.  If you redefine this with hw:X instead,
these conversions aren't available anymore.


HTH
Clemens



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
