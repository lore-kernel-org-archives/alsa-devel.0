From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: usage of snd_seq_queue_status_get_real_time()
Date: Wed, 13 Apr 2005 10:10:09 +0200 (METDST)
Message-ID: <Pine.HPX.4.33n.0504131008050.437-100000@studcom.urz.uni-halle.de>
References: <425C1E54.1040705@pianodisc.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <425C1E54.1040705@pianodisc.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Steve deRosier <derosier@pianodisc.com>
Cc: Alsa-Devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Steve deRosier wrote:
> On repeated calls, it will return the same time value for a few
> calls in a row.  Does the status information only get updated
> every so often?

Yes, it's updated on every timer tick.

If you didn't change it, the default timer is the system timer which
runs at 100 Hz in Linux 2.4.x and at 1000 Hz in Linux 2.6.x.


HTH
Clemens



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
