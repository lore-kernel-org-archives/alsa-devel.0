From: Liam Girdwood <liam.girdwood@wolfsonmicro.com>
Subject: Re: [RFC] Extra info via the TLV interface
Date: Mon, 04 Sep 2006 14:14:13 +0100
Message-ID: <1157375653.2772.61.camel@localhost.localdomain>
References: <44FC20B0.4060501@superbug.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <44FC20B0.4060501@superbug.co.uk>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: James Courtier-Dutton <James@superbug.co.uk>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Mon, 2006-09-04 at 13:48 +0100, James Courtier-Dutton wrote:
> Hi,
> 
> I would like to now pass extra info regarding the controls via the TLV
> interface.
> 1) Whether the control is Playback, Capture or Both.

Agreed, it would also be nice to know about sidetone/bypass.

> 2) Whether the control is digital or analog.
> 3) Some description of the routing of the control. i.e. how it links to
> other controls.

Fwiw, I've created a patch for ASoC that uses the audio routing map
(includes how controls are linked to other controls) within ASoC to
enable easy scenario setting. This allows a route to be be automatically
created (and powered) by specifing the source and sink e.g.

"Left DAC" --> "Left Headphone"

It wouldn't be difficult to add code here that could also specify the
active controls for that route. i.e. active route controls could be
highlighted to make using the mixer tools easier.

If anyone is interested, patch is here:-

http://www.rpsys.net/openzaurus/patches/alsa/asoc-scenario-v0.3.patch

Atm, it's ASoC only as it requires a map of the machine audio subsystem.

> 4) Both "short" and "long" mixer control names.
> 5) Control grouping. I.e. to have mixer controls "Front" and "Surround"
> next to each other.
> 
> I know (1) sort of works just by adding playback or capture to the
> control name, but it seems to fail in some ambiguous cases. E.g.
> "Capture feedback", "Mic Boost", "HD Source", "HD Channel"
> 
> Any comments?
> 

I'd also like to pass in log time values for ALC/AGC.

Liam



-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
