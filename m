From: Mark Rages <markrages@mlug.missouri.edu>
Subject: Re: ALSA driver architecture documentation?
Date: Mon, 19 Aug 2002 14:44:02 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020819194402.GA4672@mlug.missouri.edu>
References: <20020819213712.A18500@xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <20020819213712.A18500@xs4all.nl>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Fred Jan Kraan <fjkraan@xs4all.nl>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Mon, Aug 19, 2002 at 09:37:12PM +0200, Fred Jan Kraan wrote:
> Recently I started to collect some info on how to make a ALSA driver for
> the Digigram VXpocket V2. Digigram decided to provide information
> this PCMCIA card, on condition that a moderator is the single point of
> contact with Digigram.
> A driver for the VXpocket should interface with the PCMCIA module and
> (most likely) the ALSA package. Info on how to make a PCMCIA driver
> easy to find. Description of layers and a well documented dummy driver.
> Alas I did not find much info in the ALSA structure. There is lots of
> source code and even a dummy driver, but completely uncommented.
> What seems to be documented is how to interface with ALSA, not how to
> write a ALSA driver. So is there more than "use the source"? :-)
> 

As far as I know, no.

If you find any more information, please add it to:

http://alsa.opensrc.org/index.php?page=WritingAnAlsaDriver

You can subscribe to alsa-devel for a year like I did, and
pick up enough information to write a driver that works every
second time it's loaded, with xruns when you even *think* about
moving the mouse...

Mark



-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
