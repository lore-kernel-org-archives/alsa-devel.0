From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Implementing ALSA compatibility in OSS
Date: Tue, 16 Nov 2004 10:56:34 +0100 (CET)
Message-ID: <Pine.LNX.4.58.0411161056250.21901@pnote.perex-int.cz>
References: <Pine.HPX.4.33n.0411151354510.12617-100000@studcom.urz.uni-halle.de>
 <Pine.LNX.4.58.0411151518070.9417@zeus.compusonic.fi>
 <Pine.LNX.4.58.0411151655090.1751@pnote.perex-int.cz>
 <Pine.LNX.4.58.0411151859220.9516@zeus.compusonic.fi> <s5hd5yfdjwh.wl@alsa2.suse.de>
 <Pine.LNX.4.58.0411152057340.13352@pnote.perex-int.cz> <s5h8y92dtnz.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5h8y92dtnz.wl@alsa2.suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Hannu Savolainen <hannu@opensound.com>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Tue, 16 Nov 2004, Takashi Iwai wrote:

> At Mon, 15 Nov 2004 20:58:47 +0100 (CET),
> Jaroslav wrote:
> > 
> > On Mon, 15 Nov 2004, Takashi Iwai wrote:
> > 
> > > For example, the current design of ALSA lib isn't well suitable for
> > > the embedded system.  It's because we wanted to have a powerful and
> > > extensible middle layer which can be used uniquely by apps.  For the
> > > tiny systems, OTOH, it's too bold.
> > 
> > It's not true. We can allow to remove not used code. I plan to shrink
> > library for these devices. It's not a big problem.
> 
> Read the word "current".
> 
> Your plan is exactly what I have, too :)

Fine. Sorry ;-)

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs


-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
