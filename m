From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: snd-via82xx on EPIA-M - 0 analog subsections not
	ready
Date: Thu, 23 Jun 2005 15:44:29 -0400
Message-ID: <1119555870.13259.26.camel__38340.7787456692$1119555684$gmane$org@mindpipe>
References: <20050623184321.GA7728@fingerbrecher>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-user-admin@lists.sourceforge.net>
In-Reply-To: <20050623184321.GA7728@fingerbrecher>
Sender: alsa-user-admin@lists.sourceforge.net
Errors-To: alsa-user-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-user@lists.sourceforge.net>
List-Help: <mailto:alsa-user-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-user>
To: Sebastian Henschel <sebastian@mali.geekcorps.org>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>, alsa-user@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Thu, 2005-06-23 at 18:43 +0000, Sebastian Henschel wrote:
> hi list,
> 
> i am working on a machine with an EPIA-M mainboard and the ICEensemble
> VT1616i sound chip (see attached lspci -v).

Thanks, this is an excellent bug report.  It sounds like a not quite
fully supported device.

On a related topic, it seems like a lot of users waste hours and hours
changing settings before they even consider that they might have a
hardware variation we have not seen before.

Since these problems will not go away until every vendor gives us full
hardware specs, aka when hell freezes over, it would probably help to
add to those printks ('Unknown codec', etc) some text to the effect that
it's possibly an unknown device and they should contact alsa-devel ASAP.
Other subsystems do things like this and it works, everyone knows to
check dmesg, and they will do what you tell them to ;-)

I'll see if I can identify the specific errors that could indicate an
unknown device, or anything other situation where something very strange
has happened and we want the user to contact us with the details.  Any
suggestions?

Lee





-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
