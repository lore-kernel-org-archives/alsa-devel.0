From: Christof Damian <cdamian@guideguide.com>
Subject: Re: Hoontech Audio DSP24 Value (+bracket)
Date: Tue, 12 Feb 2002 11:02:23 +0000
Message-ID: <20020212110223.S18197@stratus.london.guideguide.com>
References: <s5hpu3b5776.wl@alsa2.suse.de> <Pine.LNX.4.31.0202121138001.496-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.31.0202121138001.496-100000@pnote.perex-int.cz>; from perex@perex.cz on Tue, Feb 12, 2002 at 11:49:12AM +0100
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.de>, alsa developer mailinglist <alsa-devel@alsa.alsa-project.org>, Claus Riethmueller <claus@ridi.com>
List-Id: alsa-devel@alsa-project.org

Jaroslav Kysela schrieb am Dienstag, den 12. Februar 2002:
> 
> The patch is wrong. There is PIC accessing and initializating AK4524
> codecs. I'm not sure, if we can drive analog codecs directly,
> because I have no further information about DSP24 Value.

i thought it might be, but it made the card work a little bit better
than before.

> I'm also not sure about differences between models, because the full
> version expects some additional I/O boxes, but there is no way to
> detect which (and if) a box is connected. 

I wonder if the windows software can do it.

> The DSP24 Value version looks like a card with simplified build-in
> I/O box.

thats what i think too.

> I think that I have a contact to a guy from Taiwan (Hoontech) from
> Claus Riethmueller, so I asked him for more information about
> differences between DSP24 and DSP24 Value, but he has not replied.

very good.

christof
-- 
Christof Damian         
Technical Director, guideguide ltd.	            

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
