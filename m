From: jhall@UU.NET (Jeremy Hall)
Subject: Re: when did the rme9652 driver break?
Date: Wed, 20 Feb 2002 02:49:22 -0500 (EST)
Message-ID: <QQmczn03614.200202200749@neserve0.corp.us.uu.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
In-Reply-To: <QQmcxa10325.200202191538@neserve0.corp.us.uu.net> from Jeremy Hall
 at "Feb 19, 2002 10:38:22 am"
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Jeremy Hall <jhall@UU.NET>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,

Actually there appear to be some wierd cases where the driver can still
cause XRUNS, but these may not be alsa-related things.  Do you have an
idea where this might be coming from if in alsa? (but don't spend flocks
of time on it, just a quick think over it)

_J

In the new year, Jeremy Hall wrote:
> ah yes, now works GREAT! operating with 1.12 of the rme9652.c
> 
> _J
> 
> In the new year, Takashi Iwai wrote:
> > At Tue, 19 Feb 2002 10:03:42 -0500 (EST),
> > Jeremy Hall wrote:
> > > 
> > > Hi,
> > > 
> > > What is going on? my computer goes on vacation for a week and when it
> > > returns and updates its CVS, alsa now locks the kernel when I try to use
> > > the rme9652 card.  Jack whines about loads of xruns, which get larger as
> > > time goes by, resulting in a system crash that must be hard-reset.
> > > 
> > > When were these unstable changes introduced so I may revert back to a more
> > > stable build?
> > > 
> > > Other apps besides jack can cause the computer to lock as well.
> > 
> > oops, sorry, perhaps my fault.  a typo was introduced in fixes for
> > non-intel architectures.
> > 
> > now fixed on cvs.  please give a try.
> > 
> > 
> > Takashi
> > 
> > _______________________________________________
> > Alsa-devel mailing list
> > Alsa-devel@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/alsa-devel
> > 
> 
> 
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel
> 


_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
