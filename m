From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Oops with emu10k1 multichannel device - possible
	bug
Date: Sat, 19 Feb 2005 14:31:27 -0500
Message-ID: <1108841487.10705.12.camel@krustophenia.net>
References: <1108764903.5278.3.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
In-Reply-To: <1108764903.5278.3.camel@krustophenia.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Fri, 2005-02-18 at 17:15 -0500, Lee Revell wrote:
> Testing ALSA CVS on a new machine using the emu10k1 multichannel device
> produced this Oops.  I am investigating.  Although the multichannel
> patch was very well tested, until further notice the device should be
> considered buggy.

I don't think this is anything to worry about.  It only happened the
first time I loaded the new ALSA modules, I think I had unloaded ALSA
1.0.5 previously.  I have been unable to reproduce it despite running
JACK at very low latencies and doing "dbench 64" for hours.

Lee



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
