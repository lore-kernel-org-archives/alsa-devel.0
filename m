From: Thierry Vignaud <tvignaud@mandriva.com>
Subject: [RFC] compatibility between alsa-kernel and alsa-lib
Date: Tue, 08 Aug 2006 18:52:22 +0200
Message-ID: <m2fyg741bt.fsf_-_@vador.mandriva.com>
References: <m23bcd612c.fsf@vador.mandriva.com> <s5hzmekvnyg.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <s5hzmekvnyg.wl%tiwai@suse.de> (Takashi Iwai's message of "Fri,
	04 Aug 2006 11:40:07 +0200")
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Takashi Iwai <tiwai@suse.de> writes:

> > I may have already raised this (sorry), but from times to times, a
> > change in a driver (ie a mixer element change) is coupled with a
> > corresponding change in the config file in
> > /usr/share/alsa/cards/).
> > 
> > This means that there's a point of linkage between alsa-kernel and
> > alsa-lib (that is one has to use older releases for both kernel
> > and libs or new releases for both).
> > 
> > Is there a way to ensure some compatibility, ie alsa-lib-1.0.20
> > will work with both kernel-2.6.32 and kernel-2.6.16 despite driver
> > snd-foobar has changed it's mixer in kernel-2.6.20?
> > 
> > Maybe with versionnated config files or versionnated definitions
> > in the config files?
> > 
> > I know that this can be hard since more and more change will be
> > accumulated (on the other hand, such changes don't happen that
> > often).
> 
> Yes, that's a missing part, so far.
> 
> Currently, we keep the backward compatibility as much as possible.
> For example, if a control element is renamed, we keep the old entry
> with "optional true" attribute so that the same config works for
> older version.  But, this wouldn't work if the device number changes
> or any other critical change occurs.
> 
> The versioned config would be a solution.  The question is how to
> take the version number/string.  One possible idea is that a card
> provides a read-only control element named "Version" with
> IFACE_CARD.  Or simply a new ioctl for this purpose.
> 
> Anyway, this implementation should be more discussed on alsa-devel
> ML.

let's forward it alsa-devel@ ml then.

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
