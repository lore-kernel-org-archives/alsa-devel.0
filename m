From: =?iso-8859-15?Q?Jos=E9?= Fonseca <j_r_fonseca@yahoo.co.uk>
Subject: Re: Oops in cs4281_suspend
Date: Mon, 11 Nov 2002 16:57:54 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20021111165754.GA15463@localhost.localdomain>
References: <20021111143136.GB6862@localhost.localdomain> <Pine.LNX.4.21.0211111716180.1287-100000@mailserver.intern.bfad.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0211111716180.1287-100000@mailserver.intern.bfad.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: tomasz motylewski <T.Motylewski@bfad.de>
Cc: alsa-devel@lists.sourceforge.net, arip@bfad.de
List-Id: alsa-devel@alsa-project.org

On Mon, Nov 11, 2002 at 05:19:14PM +0100, tomasz motylewski wrote:
> > options (also attached), it shows that the problem is in the line:
> > 
> > 	chip->suspend_regs[i] = snd_cs4281_peekBA0(chip, saved_regs[i]);
> 
> Very good report :-)
> 

Well I'm still beating myself for not noticing what was the bug even
after looking so many times to those lines! 8O

> I think the following patch should solve this problem. But since that
> suspend/resume seems to not have been tested at all for that driver,
> may be some other things will show up.

It solved indeed. And surprisingly suspend/resume worked flawlessly
after.

Thanks,

José Fonseca
__________________________________________________
Do You Yahoo!?
Everything you'll ever need on one web page
from News and Sport to Email and Music Charts
http://uk.my.yahoo.com


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
