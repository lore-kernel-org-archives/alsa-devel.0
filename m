From: =?ISO-8859-1?Q?Erik_Inge_Bols=F8?= <knan@mo.himolde.no>
Subject: Re: hammerfall dsp controls (again)
Date: Fri, 8 Mar 2002 15:09:37 +0100 (CET)
Message-ID: <Pine.LNX.4.44.0203081500480.20832-100000@yme.mo.himolde.no>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Received: from yme.mo.himolde.no (qmailr@[158.38.74.10])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with SMTP id PAA25914
	for <alsa-devel@alsa-project.org>; Fri, 8 Mar 2002 15:05:08 +0100
In-Reply-To: <200203081339.g28Dd5x16550@op.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Paul Davis <pbd@op.net>
Cc: alsa-devel mailing list <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Fri, 8 Mar 2002, Paul Davis wrote:
>well, since nobody responded to a 100% open question on how to support
>the 1500 or so mixer controls that exist on the H-DSP, i'll offer up
>an explicit solution and see if anyone can comment on that.
>
>since no generic ALSA program is going to be able to usefully present
>all those mixer controls, and since they all represent variations on a
>theme, i propose to offer a single control that includes:
>
>       data source
>       data destination
>       gain
>
>it will be up to applications to get/set whatever combinations of
>these they are interested in. there will be no single control that can
>be read to get, say, the gain for a specific data destination, since
>no such value can really be said to exist in the H-DSP - gain values
>always apply to a combination of a source and a destination.
>
>any comments on this?

Can't think of anything better - and it should be possible to implement
all sorts of fancy mixer UIs on top of that.

Could be useful for the alsa-lib "multi" and "share" devices as well, to
implement runtime routing, if that's desirable on that level... *vague
idea*

--
Erik I. Bols=F8 | email: <knan at mo.himolde.no>
The UNIX philosophy basically involves giving you enough rope to
hang yourself.  And then a couple of feet more, just to be sure.




_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
