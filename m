From: Liam Girdwood <liam.girdwood@wolfsonmicro.com>
Subject: Re: [RFC] Extra info via the TLV interface
Date: Mon, 04 Sep 2006 14:30:19 +0100
Message-ID: <1157376619.2772.74.camel@localhost.localdomain>
References: <44FC20B0.4060501@superbug.co.uk>
	<Pine.LNX.4.61.0609041455110.9339@tm8103.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.61.0609041455110.9339@tm8103.perex-int.cz>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Jaroslav Kysela <perex@suse.cz>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>, James Courtier-Dutton <James@superbug.co.uk>
List-Id: alsa-devel@alsa-project.org

On Mon, 2006-09-04 at 15:04 +0200, Jaroslav Kysela wrote:
> On Mon, 4 Sep 2006, James Courtier-Dutton wrote:
> 
> > Hi,
> > 
> > I would like to now pass extra info regarding the controls via the TLV
> > interface.
> > 1) Whether the control is Playback, Capture or Both.
> > 2) Whether the control is digital or analog.
> > 3) Some description of the routing of the control. i.e. how it links to
> > other controls.
> > 4) Both "short" and "long" mixer control names.
> > 5) Control grouping. I.e. to have mixer controls "Front" and "Surround"
> > next to each other.
> 
> In my opinion, all these GUI hints should be elsewhere (userspace), 
> otherwise we'll end up with drivers containing digital photos of 
> sound chips in the TLV structure :-)
> 

We've almost got a "digital photo" of each sound chip in ASoC atm. It's
good for a few things (including GUI hints) :-

 o Power Management. Knowing when to enable/disable individual chip and
machine audio components (based on any active streams and current mixer
settings).
 o Scenario setting. Allowing a route to be set from source to sink
within a machine. I'd like to eventually have some kind of scenario
description in the card conf file for each use case. 

Atm, the audio map is within the driver code, but it could eventually be
moved into userspace. The only question is whether the PM will work well
in userspace.

Liam


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
