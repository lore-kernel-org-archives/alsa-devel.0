From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Extra Emu10k1 documentation that may be helpful
Date: Tue, 15 Mar 2005 09:29:40 +0100 (MET)
Message-ID: <Pine.HPX.4.33n.0503150917550.186-100000@studcom.urz.uni-halle.de>
References: <42361B9E.2080604@sbcglobal.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
In-Reply-To: <42361B9E.2080604@sbcglobal.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: James <whitetigerx7@sbcglobal.net>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

James wrote:
> echo "Defining Pmidi Default Sequencer Port: /usr/bin/pmidi -p 65:0"
> /usr/bin/pmidi -p 65:0 &

What is this supposed to do?  pmidi will just play the specifified
files (none in this case) to port 65:0, and then exit.

To set the default port, set the ALSA_OUTPUT_PORTS environment
variable.


HTH
Clemens



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
