From: Clemens Ladisch <clemens@ladisch.de>
Subject: [Please apply patch] Re: au88x0 - Replace spdif frequency
 control by IEC958 control
Date: Mon, 21 Feb 2005 16:22:19 +0100 (MET)
Message-ID: <Pine.HPX.4.33n.0502211620130.24184-100000@studcom.urz.uni-halle.de>
References: <1108990563.3315.27.camel@localhost>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
In-Reply-To: <1108990563.3315.27.camel@localhost>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Raymond <rayau@netvigator.com>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Raymond wrote:
> 1) What is the difference between Consumer mode and Professional mode ?

A different set of status bits.  See, for example, ALSA's asoundef.h,
but it doesn't have many explanations.

The main difference is that only consumer mode has the copyright bit
so that devices can automatically disable copying.


HTH
Clemens



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
