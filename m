From: Josh Green <jgreen@users.sourceforge.net>
Subject: Re: [linux-audio-dev] SBLive again
Date: 19 May 2003 19:19:26 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1053397166.8187.8.camel@SillyPuddy>
References: <3EC7A0C2.8060507@gmx.de> <20030519130245.GB6003@loco.zait.wlan>
	 <1053384516.7951.8.camel@SillyPuddy>
	 <200305201142.05828.lists@n12turbo.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200305201142.05828.lists@n12turbo.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: LAD <linux-audio-dev@music.columbia.edu>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

I'm CC'ing the ALSA devel list, perhaps someone there has some answers
concerning pops/clicks with full duplex and SB Live cards.

On Mon, 2003-05-19 at 18:42, Tarragon Allen wrote:
> On Tuesday 20 May 2003 08:49, Josh Green wrote:
> > The problem that I mentioned, in regard to full duplex, doesn't relate
> > to clipping I don't think. From what I experienced I think its a problem
> > with the record and playback buffers getting out of sync (like say if
> > you tried to do full duplex with 2 different sound cards). Things would
> > be perfectly fine, then a few little pops and clicks which would
> > gradually get worse until an overrun occurs, then back to being okay
> > again (sometimes I would do something to purposefully cause an overrun,
> > to get things synchronized again). As far as I can tell this is probably
> > an ALSA problem, although my tests using OSS were inconclusive (or to
> > rephrase, I can't remember :) I think the OSS SB Live drivers might be
> > able to do full duplex, would be interested to test it again to see if
> > it is indeed an ALSA specific problem. What version of ALSA are you
> > using Lukas?  Cheers.
> > 	Josh Green
> 
> Just for reference, I'm seeing the same behaviour using Ardour. The pops and 
> clicks only occur when I'm recording, and yes, I'm using full duplex mode. If 
> I turn off record mode the symptoms dissappear, and reappear as soon as I go 
> to record again - until there is a very minor xrun and it all clears up for a 
> while (usually about 15-20 minutes between instances, that I've noticed).
> 
> Alsa 0.9.2, SBLive! Value, Kernel 2.4.20.
> 

Okay, it was like 2 years ago when I was complaining about this same
problem. Just wanted to make sure it was indeed a new version of ALSA.

> t

Cheers.
	Josh Green



-------------------------------------------------------
This SF.net email is sponsored by: ObjectStore.
If flattening out C++ or Java code to make your application fit in a
relational database is painful, don't do it! Check out ObjectStore.
Now part of Progress Software. http://www.objectstore.net/sourceforge
