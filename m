From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: El Cheapo: Works, but some open questions still.
Date: Wed, 08 Dec 2004 19:31:13 -0500
Message-ID: <1102552274.12304.13.camel@krustophenia.net>
References: <Pine.HPX.4.33n.0412081916280.21064-100000@studcom.urz.uni-halle.de>
	 <1102551671.5645.0.camel@el.cheapo>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-user-admin@lists.sourceforge.net>
In-Reply-To: <1102551671.5645.0.camel@el.cheapo>
Sender: alsa-user-admin@lists.sourceforge.net
Errors-To: alsa-user-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-user@lists.sourceforge.net>
List-Help: <mailto:alsa-user-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-user>
To: Timo Sivula <timo.sivula@luukku.com>
Cc: Clemens Ladisch <clemens@ladisch.de>, alsa-user@lists.sourceforge.net, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Thu, 2004-12-09 at 08:21 +0800, Timo Sivula wrote: 
> > I'm just guessing, but brobably the driver takes too long starting
> > each device so that the buffer positions are too different.
> 
> I am using a 2G celeron. Would an upgrade to a P4 help this?

No.  You need to get into the driver and figure out what's going on.
Add some printk()s to the driver to measure the delay in starting the
devices.

Lee



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
