From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Re: 2.6.12-rc1-mm3, sound card lost id
Date: Tue, 29 Mar 2005 16:18:31 -0500
Message-ID: <1112131111.5386.3.camel@mindpipe>
References: <20050325002154.335c6b0b.akpm@osdl.org>
	 <20050326111945.5eb58343.khali@linux-fr.org> <s5hr7hyiqra.wl@alsa2.suse.de>
	 <20050329195721.385717aa.khali@linux-fr.org>
	 <1112127424.5141.7.camel@mindpipe>
	 <20050329224630.069cda56.khali@linux-fr.org>
	 <1112129571.5141.18.camel@mindpipe>
	 <20050329231345.281e7323.khali@linux-fr.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from viper.oldcity.dca.net (viper.oldcity.dca.net [216.158.38.4])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with SMTP id 81412251
	for <alsa-devel@alsa-project.org>; Tue, 29 Mar 2005 23:18:33 +0200 (MEST)
In-Reply-To: <20050329231345.281e7323.khali@linux-fr.org>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jean Delvare <khali@linux-fr.org>
Cc: James Courtier-Dutton <James@superbug.co.uk>, Takashi Iwai <tiwai@suse.de>, Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, Jaroslav Kysela <perex@suse.cz>
List-Id: alsa-devel@alsa-project.org

On Tue, 2005-03-29 at 23:13 +0200, Jean Delvare wrote:
> > +	{.vendor = 0x1102, .device = 0x0002, .subsystem = 0x80271102,
> > +	 .driver = "EMU10K1", .name = "SBLive! Value [CT4832]", 
> > +	 .emu10k1_chip = 1,
> > +	 .ac97_chip = 1} ,
> Unsurprisingly, my card is now named CT4832. I had to edit
> /etc/asound.state manually to get my mixer settings back (with some
> warnings, but I get some sound).
> 
> Not sure I quite see the idea of renaming from "Live", which the user
> will understand, to (I suppose) the exact chip name on the card, while
> the user has certainly no idea what it is. But heh I'm not an ALSA
> developer, there must be a good reason.

Blame Creative.  They have released so many different cards under the
Live! name that it's become meaningless.  There are now two separate
classes of cards marketed as Live! (or Audigy) that don't even use the
same driver (ca0106 and emu10k1x), the hardware isn't even similar.
Unsurprisingly, the user confusion is massive.

The model number is the simplest unique identifier.  This is also what
the "good" Windows drivers for these devices, http://www.kxproject.com,
use.

Lee



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
