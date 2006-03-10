From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [alsa-cvslog] CVS: alsa-kernel/usb usbaudio.c,1.172,1.173
Date: Fri, 10 Mar 2006 09:16:09 +0100
Message-ID: <20060310081609.GB10971@turing.informatik.uni-halle.de>
References: <E1FHG2j-0001sX-Ln@sc8-pr-cvs1.sourceforge.net>
 <1141940987.13319.71.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <1141940987.13319.71.camel@mindpipe>
Content-disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Lee Revell <rlrevell@joe-job.com>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>, linux-kernel <linux-kernel@vger.kernel.org>, usb-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Lee Revell wrote:
> On Wed, 2006-03-08 at 23:58 -0800, Clemens Ladisch wrote:
> > +static const char *usb_error_string(int err)
> > +{
> > +	switch (err) {
> > +	case -ENODEV:
> > +		return "no device";
> > +	case -ENOENT:
> > +		return "endpoint not enabled";
> > +	case -EPIPE:
> > +		return "endpoint stalled";
> > +	case -ENOSPC:
> > +		return "not enough bandwidth";
> > +	case -ESHUTDOWN:
> > +		return "device disabled";
> > +	case -EHOSTUNREACH:
> > +		return "device suspended";
> > +	case -EINVAL:
> > +	case -EAGAIN:
> > +	case -EFBIG:
> > +	case -EMSGSIZE:
> > +		return "internal error";
> > +	default:
> > +		return "unknown error";
> > +	}
> > +}
> 
> Shouldn't a generic facility be created for this?

Yes, there's nothing audio specific in this function (except for my
decision which codes to lump together as "internal error").

> After all these are standard error codes and it seem like other parts
> of the kernel might want to do user friendly error reporting.

But it seems none of those parts actually does.  ;-)


Clemens


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
