From: Tobin Davis <tdavis@dsl-only.net>
Subject: Re: Upgrading alsa drivers. current and hg from
	suse	site
Date: Fri, 02 Nov 2007 15:20:57 -0700
Message-ID: <1194042057.574.20.camel@razman.gruemaster.com>
References: <200711022233.43715.cave.dnb2m97pp@aliceadsl.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from iron2.pdx.net (iron2.pdx.net [69.64.224.71])
	by alsa0.perex.cz (Postfix) with ESMTP id 88F8B2452F
	for <alsa-devel@alsa-project.org>; Fri,  2 Nov 2007 23:21:00 +0100 (CET)
In-Reply-To: <200711022233.43715.cave.dnb2m97pp@aliceadsl.fr>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Nigel Henry <cave.dnb2m97pp@aliceadsl.fr>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, 2007-11-02 at 22:33 +0100, Nigel Henry wrote:

> I try to help folks now and then with sound problems. I don't have an hda 
> intel card, but try to point folks in the right direction to get help.
> 
> Question:
> I've sorted out the upgrading of the alsa driver on Fedora, Archlinux, and 
> Debian, even though I don't need too, as my audigy2 soundblaster, and on the 
> other machine, an ensoniq (ens1371) are fine. this was from the latest 1.0.15 
> release at http://alsa-project.org.
> 
> My question is to do with the nightly hg releases obtainable from.
> ftp://ftp.suse.com/pub/projects/alsa/snapshot/driver/
> 
> Will these install using the same ./configure, make, (su to root), then make 
> install, as with upgrading to the current 1.0.15 version from. 
> http://alsa-project.org.
> 

Yes.  These are essentially the same as the release, but with daily
snapshot code.  Just untar, ./configure, make && make install.


> Sorry if this is a trivial question, but I don't want to give bad information 
> to folks looking for help.

No problem, the more help the better.


> I've only recently subscribed to the alsa-devel list, and hadn't realised how 
> much effort was being put in to resolve soundcard problems, particularly hda 
> intel ones.
> 

Considering laptop and desktop systems all come with Intel HD Audio
these days, the need for support in this area is increasing
exponentially.  Any help you can provide is great.

I have a user on #alsa irc that wrote a great little script that uploads
system information to a website for developers to use.  It has proven to
be very helpful.  You can get it here:
http://bulletproof.servebeer.com/alsa/scripts/alsa-info.sh



-- 
Tobin Davis  


MIPS:
	Meaningless Indicator of Processor Speed
