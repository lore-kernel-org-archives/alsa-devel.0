From: Manuel Jander <manuel.jander@usm.cl>
Subject: Re: The ALSA Situation
Date: Thu, 11 Nov 2004 19:34:46 -0300
Message-ID: <1100212487.2076.13.camel@localhost>
References: <200411102113.iAALDLUN001061@localhost.localdomain>
	 <Pine.LNX.4.58.0411101426260.2301@ppc970.osdl.org>
	 <Pine.LNX.4.58.0411110714280.2179@pnote.perex-int.cz>
	 <Pine.LNX.4.58.0411102241240.2301@ppc970.osdl.org>
	 <s5his8cfiot.wl@alsa2.suse.de>
	 <Pine.LNX.4.58.0411110855380.2301@ppc970.osdl.org>
	 <s5hhdnwfgbz.wl@alsa2.suse.de>
	 <Pine.LNX.4.58.0411111021520.2301@ppc970.osdl.org>
Reply-To: mjander@users.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.58.0411111021520.2301@ppc970.osdl.org>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Linus Torvalds <torvalds@osdl.org>, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Hi

On Thu, 2004-11-11 at 10:23 -0800, Linus Torvalds wrote:
> 
> On Thu, 11 Nov 2004, Takashi Iwai wrote:
> > 
> > Oh, that's hard to tell what should be the "default" parameters.
> > This strongly depends on the board.
> 
> Which is exactly why apps should not even try to set them.

At last somebody agree :) Frankly IMHO, setting buffer sizes in a sound
application, seemed always pretty silly thing to me. Its too much
hardware dependant, to be done inside a user application; sort of out of
scope.

> My point is that the driver can select some default parameters, and then 
> users just use them by default, and thus there are no issues of 
> synchronizing between them.

Yes, that would be very, very nice. At most, user program should have
the ability to ask for less_latency or longer_buffering, because that
relationship obviously is a tradeoff between 2 goodnesses. But most
current "options" don't actually provide any benefit. If choosen wrong,
sound output may even not work correctly.
The less options -> the more likelyhood that it will work (just works
paradigm).

> > ALSA tries to provide as much function as possible.  This results in
> > variety of configurations, i.e. the famous complexity.
> 
> That may or may not be a valid excuse.
> 
> Complexity also often arises from bad decisions. And the decision to only 
> have one user open at a time appears like a pretty fundamentally bad one.

I agree too. Its even worst with fear to a rewrite/redesign.

-- 
Manuel Jander
Electronic Engineer



-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
