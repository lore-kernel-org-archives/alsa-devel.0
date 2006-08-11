From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: [RFC] compatibility between alsa-kernel
	and	alsa-lib
Date: Fri, 11 Aug 2006 11:55:17 -0400
Message-ID: <1155311717.26925.22.camel@mindpipe>
References: <m23bcd612c.fsf@vador.mandriva.com>
	<s5hzmekvnyg.wl%tiwai@suse.de> <m2fyg741bt.fsf_-_@vador.mandriva.com>
	<m27j1fs2m0.fsf@vador.mandriva.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <m27j1fs2m0.fsf@vador.mandriva.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Thierry Vignaud <tvignaud@mandriva.com>
Cc: Alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Fri, 2006-08-11 at 17:39 +0200, Thierry Vignaud wrote:
> Thierry Vignaud <tvignaud@mandriva.com> writes:
> 
> > > Yes, that's a missing part, so far.
> > > 
> > > Currently, we keep the backward compatibility as much as possible.
> > > For example, if a control element is renamed, we keep the old
> > > entry with "optional true" attribute so that the same config works
> > > for older version.  But, this wouldn't work if the device number
> > > changes or any other critical change occurs.
> > > 
> > > The versioned config would be a solution.  The question is how to
> > > take the version number/string.  One possible idea is that a card
> > > provides a read-only control element named "Version" with
> > > IFACE_CARD.  Or simply a new ioctl for this purpose.
> > > 
> > > Anyway, this implementation should be more discussed on alsa-devel
> > > ML.
> > 
> > let's forward it alsa-devel@ ml then.
> 
> is nobody interested in ensuring compatibility between alsa-lib &
> alsa-kernel?
> see linus statements about greg wanted to break compatibility with
> older udev...

I thought it was already ALSA policy for a year or so not to make
incompatible changes between alsa-lib and alsa-kernel.

Lee


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
