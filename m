From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: aoss failures under Alsa-1.0.0rc1
Date: Fri, 05 Dec 2003 14:10:45 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0312051406500.21103-100000@studcom.urz.uni-halle.de>
References: <1070569707.2228.7.camel@Wizard.knechthome.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <1070569707.2228.7.camel@Wizard.knechthome.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Mark Knecht <markknecht@comcast.net>
Cc: Erik Inge =?ISO-8859-1?Q?Bols=F8?= <knan@mo.himolde.no>, Alsa-Devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Mark Knecht wrote:
> On Thu, 2003-12-04 at 05:15, Erik Inge Bols=F8 wrote:
> > On Thu, 4 Dec 2003, Mark Knecht wrote:
> > >pcm.playback_5_6 {
> > >          type dshare
> > >          slave hdsp
>
> > Uhmm... for _playback_, shouldn't that be "type dmix"? Or am I co=
nfused
> > again?
>
> I tried dmix instead of dshare but get the same results.

dshare allows its clients to share separate channels, dmix allows the=
m
to access the same channels.

> I don't know if this is an Alsa problem, a driver problem, or just
> something that will never work because of my card's capabilities?

An aoss problem, I think.  Are you using the latest CVS version?
(You can update this single package independantly of the other ALSA
packages.)


Regards,
Clemens





-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
