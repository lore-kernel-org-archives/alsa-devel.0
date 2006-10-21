From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Multi-seated machine.
Date: Sat, 21 Oct 2006 19:21:12 -0400
Message-ID: <1161472872.20231.14.camel@mindpipe>
References: <453AA8C7.4050408@superbug.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <453AA8C7.4050408@superbug.co.uk>
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

On Sun, 2006-10-22 at 00:09 +0100, James Courtier-Dutton wrote:
> Hi,
> 
> As linux can now be used in a mode whereby one has one base box, and 
> then multiple keyboard/mouse/screen

Is this possible OOTB on any distro?  Last I heard it required kernel
and/or X patches?  Got a link?

> , how might one separate the sound?
> I.e. Sound card 0 for screen 0, sound card 1 for screen 1 etc.
> Or one might want "Front" for screen 0, "Rear" for screen 1 etc.
> 
> How would we achieve this in ALSA?
> I expect we would need a different asoundrc for each screen, but I don't 
> know how well this might work or not.

AFAICT it should work now with Gnome and multiple soundcards as long as
each screen logs in as a separate user - gnome-soundcard-properties just
modifies the .asoundrc to set the default soundcard.  If Gnome could be
made aware of this multiple-console-user mode then it seems like it
could be made plug and play...

With a single soundcard it seems like it would be very tricky and
hardware-dependent, because Front and Rear are not independent on most
devices?

Lee


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
