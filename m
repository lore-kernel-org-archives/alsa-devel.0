From: Martin Habets <errandir_news@mph.eclipse.co.uk>
Subject: Re: seq24 not in aconnect or qjackctl
Date: Thu, 31 Mar 2005 13:38:15 +0100
Message-ID: <20050331123815.GA5857@palantir8>
References: <20050330150554.GA17648@palantir7.mph.eclipse.net> <Pine.HPX.4.33n.0503311030090.25472-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <Pine.HPX.4.33n.0503311030090.25472-100000@studcom.urz.uni-halle.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: seq24-users@lists.sourceforge.net, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Thu, Mar 31, 2005 at 10:31:41AM +0200, Clemens Ladisch wrote:
> Martin Habets wrote:
> > Problem I'm having is that seq24 does not show up in
> > aconnect or qjackctl.
> >
> > $ cat /proc/asound/seq/clients
> > ...
> > Client 128 : "seq24" [User]
> >   Port   0 : "seq24 out" (r---)
> >   Port   1 : "seq24 in" (-w--)
> >   Port   2 : "seq24 in" (-w--)
> 
> seq24 doesn't allow connecting from other programs, you have to do it
> from inside seq24.

Thanks. So this is a 'feature', not a bug. Personally it's a 'feature'
I could do without.

-- 
Martin


-------------------------------------------------------
This SF.net email is sponsored by Demarc:
A global provider of Threat Management Solutions.
Download our HomeAdmin security software for free today!
http://www.demarc.com/Info/Sentarus/hamr30
