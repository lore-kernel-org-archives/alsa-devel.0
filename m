From: jhall@UU.NET (Jeremy Hall)
Subject: Re: when did the rme9652 driver break?
Date: Tue, 19 Feb 2002 10:38:22 -0500 (EST)
Message-ID: <QQmcxa10325.200202191538@neserve0.corp.us.uu.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
In-Reply-To: <s5h3czxxzsl.wl@alsa2.suse.de> from Takashi Iwai at "Feb 19, 2002
 04:21:46 pm"
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Jeremy Hall <jhall@UU.NET>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

ah yes, now works GREAT! operating with 1.12 of the rme9652.c

_J

In the new year, Takashi Iwai wrote:
> At Tue, 19 Feb 2002 10:03:42 -0500 (EST),
> Jeremy Hall wrote:
> > 
> > Hi,
> > 
> > What is going on? my computer goes on vacation for a week and when it
> > returns and updates its CVS, alsa now locks the kernel when I try to use
> > the rme9652 card.  Jack whines about loads of xruns, which get larger as
> > time goes by, resulting in a system crash that must be hard-reset.
> > 
> > When were these unstable changes introduced so I may revert back to a more
> > stable build?
> > 
> > Other apps besides jack can cause the computer to lock as well.
> 
> oops, sorry, perhaps my fault.  a typo was introduced in fixes for
> non-intel architectures.
> 
> now fixed on cvs.  please give a try.
> 
> 
> Takashi
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
