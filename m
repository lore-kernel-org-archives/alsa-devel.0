From: Mark Knecht <markknecht@comcast.net>
Subject: Re: aoss failures under Alsa-1.0.0rc1
Date: Thu, 04 Dec 2003 12:28:27 -0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1070569707.2228.7.camel@Wizard.knechthome.com>
References: <1070543197.2081.30.camel@Wizard.knechthome.com>
	 <Pine.LNX.4.56-Maildir.0312041413510.17423@yme.midgardsormen.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.56-Maildir.0312041413510.17423@yme.midgardsormen.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Erik Inge =?ISO-8859-1?Q?Bols=F8?= <knan@mo.himolde.no>
Cc: Alsa-Devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Thu, 2003-12-04 at 05:15, Erik Inge Bolsø wrote:
> On Thu, 4 Dec 2003, Mark Knecht wrote:
> >pcm.playback_5_6 {
> >          type dshare
> >          slave hdsp


> Uhmm... for _playback_, shouldn't that be "type dmix"? Or am I confused
> again?
> 

I tried dmix instead of dshare but get the same results. I guess I hope
that Clemens or possibly Thomas jumps in with some ideas. I don't know
if this is an Alsa problem, a driver problem, or just something that
will never work because of my card's capabilities?

If the later is the case, then is this something that should/could be
better spelled out so that well meaning but uneducated folks like me
don;t keep bothering you guys?

Thanks,
Mark



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
