From: Ryan Pavlik <rpav@nwlink.com>
Subject: Re: latency with mtpav
Date: Mon, 23 Jun 2003 10:39:32 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030623103932.312a1891.rpav@nwlink.com>
References: <1056373664.15797.11.camel@littlewolf2.littlewolf>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1056373664.15797.11.camel@littlewolf2.littlewolf>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On 23 Jun 2003 23:07:44 +1000
Allan Klinbail <allank@labyrinth.net.au> wrote:

<snip> 
> In trying to test various applications with sync I have observed some
> serious latency problems with the mtpav driver.
> 
> Using ardour I found some serious latency when starting a recording
> (about half a beat at 163.7 BPM (sorry the calculations escape me trying
> to work out the exact latency here))
> 
> Has any9one else experienced this or can come up with a resolution for
> this.. 
<snip>

It may be the fact that the application in question is using the RTC,
and the clock just doesn't align with that tempo.  Wild guess.  (MIDI
apps or JACK usually run it at 1024 ticks/second, so figure how that
would align with 163.7 ticks/s.)

I haven't had any latency problems with the unit or the driver itself.
Once, I was using the RTC as a timer as well, and the most I'd be off
would be 1-4ms, and that's just because my box is kinda slow.

-- 
Ryan Pavlik <rpav@users.sf.net>

"Another *perfectly* calculated space-time
 splice-n-splice. Now to get back to... wait a second.
 I forgot to carry the TWO!" - 8BT


-------------------------------------------------------
This SF.Net email is sponsored by: INetU
Attention Web Developers & Consultants: Become An INetU Hosting Partner.
Refer Dedicated Servers. We Manage Them. You Get 10% Monthly Commission!
INetU Dedicated Managed Hosting http://www.inetu.net/partner/index.php
