From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: intel 8x0 went silent in 2.6.11
Date: Fri, 04 Mar 2005 16:06:06 -0500
Message-ID: <1109970367.6710.28.camel@mindpipe>
References: <4227085C.7060104@drzeus.cx><4227085C.7060104@drzeus.cx>
	 <29495f1d05030309455a990c5b@mail.gmail.com>  <4228C6D9.8010701@tmr.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
In-Reply-To: <4228C6D9.8010701@tmr.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Nish Aravamudan <nish.aravamudan@gmail.com>, Pierre Ossman <drzeus-list@drzeus.cx>, LKML <linux-kernel@vger.kernel.org>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Fri, 2005-03-04 at 15:36 -0500, Bill Davidsen wrote:
> Nish Aravamudan wrote:
> > On Thu, 03 Mar 2005 13:51:40 +0100, Pierre Ossman <drzeus-list@drzeus.cx> wrote:
> > 
> >>I just upgraded to Linux 2.6.11 and the soundcard on my machine went
> >>silent. All volume controls are correct and there are no errors
> >>reported. But no sound coming from the speakers. And here's the kicker,
> >>the headphones work fine!
> >>2.6.10 still works so the bug appeared in one of the patches in between.
> >>The sound card is the one integrated into intels mobile ICH4 chipset.
> > 
> > 
> > There was some discussion of this on LKML a while ago. Are you sure
> > you have disabled "Headphone Jack Sense" and "Line Jack Sense" in
> > alsamixer?
> 
> Is there some option to alsamixer to get those to show up? There's no 
> such entry in the default display (FC3 w/ kernel.org 2.6.1[01]).
> 

Does switching the view with F3 (Playback), F4 (Capture), F5 (All) and
scrolling all the way right help?

If that fails, does "amixer" list them?

Lee



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
