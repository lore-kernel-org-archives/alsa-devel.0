From: Giuliano Pochini <pochini@shiny.it>
Subject: Re: mixer device
Date: Thu, 13 May 2004 18:28:17 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <XFMail.20040513182817.pochini@shiny.it>
References: <20040513153457.GE6913@sunrise.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20040513153457.GE6913@sunrise.pg.gda.pl>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Adam Tla/lka <atlka@pg.gda.pl>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


On 13-May-2004 Adam Tla/lka wrote:

>> What do you want to do with the mixer?
> Hmm - typically people just want to control PCM volume.
> When using OSS you can just do mixer ioctl's on the opened PCM fd.
> Simple and clear.

No, it's not simple, unless the driver makes it simple
removing some capabilities of the card. For example the
Echoaudio Mia hasn't a PCM volume control. It has a mixer
that mixes 8 PCM channels into 4 physical channels. In
order to change the PCM volume of one of the eight
channels you have to change the levels of a whole row of
the mixer. Similarly, all other Echoaudio cards don't
have a line-out volume control and to change the volume
of one output channel you have to change the PCM volume
of that channel *and* a whole column of the monitor mixer.
I guess there are some cards that are more complex than
those. I exported the raw controls and I handle everything
in user-space with a dedicated "console" program similar
to the one shipped with the windos drivers.


> So how a program could in a simple way obtain information which
> control to use to set the volume level of particular stream?

Good question. The current approach is based on the control
names but sometimes they're not enough. What do you suggest ?



--
Giuliano.


-------------------------------------------------------
This SF.Net email is sponsored by: SourceForge.net Broadband
Sign-up now for SourceForge Broadband and get the fastest
6.0/768 connection for only $19.95/mo for the first 3 months!
http://ads.osdn.com/?ad_id=2562&alloc_id=6184&op=click
