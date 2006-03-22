From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Any missing patches?
Date: Tue, 21 Mar 2006 23:15:45 -0500
Message-ID: <1143000946.1792.40.camel@mindpipe>
References: <s5hmzfl9cql.wl%tiwai@suse.de>
	 <1142991436.4532.212.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1142991436.4532.212.camel@mindpipe>
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
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Tue, 2006-03-21 at 20:37 -0500, Lee Revell wrote:
> On Mon, 2006-03-20 at 19:45 +0100, Takashi Iwai wrote:
> > Hi,
> > 
> > if someone has patches intended for merging to ALSA tree, please
> > submit them ASAP.
> > 
> > I think the current ALSA CVS tree is forming to a relatively good
> > shape now, and it's good time to push Linux kernel tree, too.
> > Let's be not too late to ride a bus.
> > 
> 
> Can you look at bug #1952 (speakers not disabled when headphones plugged
> with hda-intel + STAC92xx)?  amixer output shows no "Jack sense"
> controls present.  It looks like it just needs an HP_MUTE quirk (or
> whatever the hda-intel equivalent is)

Never mind - user reports fixed in CVS.

Lee



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
