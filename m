From: Allan Klinbail <allank@labyrinth.net.au>
Subject: Re: latency with mtpav
Date: 30 Jun 2003 18:58:20 +1000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1056963500.15798.123.camel@littlewolf2.littlewolf>
References: <1056373664.15797.11.camel@littlewolf2.littlewolf>
	 <20030623103932.312a1891.rpav@nwlink.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20030623103932.312a1891.rpav@nwlink.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Ryan Pavlik <rpav@nwlink.com>
Cc: Alsa-dev <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

How do I ensure my app is using the RTC timer?


On Tue, 2003-06-24 at 03:39, Ryan Pavlik wrote:
> On 23 Jun 2003 23:07:44 +1000
> Allan Klinbail <allank@labyrinth.net.au> wrote:
> 
> <snip> 
> > In trying to test various applications with sync I have observed some
> > serious latency problems with the mtpav driver.
> > 
> > Using ardour I found some serious latency when starting a recording
> > (about half a beat at 163.7 BPM (sorry the calculations escape me trying
> > to work out the exact latency here))
> > 
> > Has any9one else experienced this or can come up with a resolution for
> > this.. 
> <snip>
> 
> It may be the fact that the application in question is using the RTC,
> and the clock just doesn't align with that tempo.  Wild guess.  (MIDI
> apps or JACK usually run it at 1024 ticks/second, so figure how that
> would align with 163.7 ticks/s.)
> 
> I haven't had any latency problems with the unit or the driver itself.
> Once, I was using the RTC as a timer as well, and the most I'd be off
> would be 1-4ms, and that's just because my box is kinda slow.
-- 
Allan Klinbail <allank@labyrinth.net.au>



-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100006ave/direct;at.asp_061203_01/01
