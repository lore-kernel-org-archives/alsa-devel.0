From: "Jan \"Evil Twin\" Depner" <eviltwin69@cableone.net>
Subject: Re: Alsa config... DSP24 and rc6
Date: 27 Dec 2002 10:21:43 -0600
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1041006104.4921.21.camel@eviltwin>
References: <20021226075641.40837.qmail@web14704.mail.yahoo.com>
	<3E0B11B9.1000804@cucumelo.org>  <001c01c2ad59$fe36e420$2800a8c0@burp>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <001c01c2ad59$fe36e420$2800a8c0@burp>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Tom Browne <tbrowne@tbrowne.demon.co.uk>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Tom,

	Have you taken a look at envy24control.  They've made some upgrades and
there is a problem with the clock rate.  I have to switch to S/PDIF In
prior to changing it to any other clock rate for it to take.  Also, all
of the channels will be muted on load.  It sounds like you probably have
deeper problems but I thought I'd throw in my 2 cents.

Jan

On Thu, 2002-12-26 at 21:41, Tom Browne wrote:
> Hi all,
> 
> After "upgrading" to Mandrake 9 (2.4.19, gcc3.2), and putting rc6 on, I am
> unable to get any sound from any native ALSA app, which report "write error:
> File Descriptor in bad state".  Info under /proc/asound all looks normal,
> and the card seems to be initialised correctly.  Even my own app, which
> doesn't use plughw, won't produce any sound.
> 
> I tried to remove the ice1712 module, only to be greeted with a "kernel BUG
> at page_alloc:97" message and a register dump + stack trace.  Hmm?
> 
> If anyone could point me in the right direction, it'd be much appreciated...
> everything was working fine with Mandrake 8.1(2.4.16+ll, gcc2.96) and an
> ALSA CVS snapshot at around rc2 time!
> 
> Gaaaah... not a great Christmas... 2 channels of my preamp blew up on
> Christmas Day!
> 
> - Tom.
> 
> 
> 
> -------------------------------------------------------
> This sf.net email is sponsored by:ThinkGeek
> Welcome to geek heaven.
> http://thinkgeek.com/sf
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
