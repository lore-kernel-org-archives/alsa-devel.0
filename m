From: Andreas Bulling <uek32z@phoenix.hadiko.de>
Subject: Re: problems with Terratec Aureon Sky 5.1
Date: Sun, 14 Mar 2004 18:17:47 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040314171747.GA24849@phoenix.hadiko.de>
References: <20040314164136.GA24447@phoenix.hadiko.de> <Pine.LNX.4.58.0403141751370.3332@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0403141751370.3332@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Thanks for your answer!

On Sun, Mar 14, 2004 at 05:59:38PM +0100, Jaroslav Kysela wrote:
| Because it's perfectly ok. The applications should use 'plug:surround51' 
| device if they want to enable automatic conversions. So, report this bug 
| to xine developers.

I will do that.

| Are you sure that xine sends six channels to device? It looks like that 
| only two channels are processed and in this case alsa-lib default 
| configuration copies only two channels to output.
| 
| If you refer to 'aplay -Dplug:surround51' then it won't work, too. Same 
| problem - you need to override the default policy for the plug plugin:
| 
|   route_policy STR      # route policy for automatic ttable generation
|                         # STR can be 'default', 'average', 'copy', 'duplicate'
|                         # average: result is average of input channels
|                         # copy: only first channels are copied to destination
|                         # duplicate: duplicate first set of channels
|                         # default: copy policy, except for mono capture - sum
| 
| So, you need something like:
| 
| pcm.duplicate {
| 	type plug
| 	slave.pcm "surround51"
| 	route_policy duplicate
| }
| 
| And now, 'aplay -Dduplicate' will duplicate stream to all six channels.

-> slave.pcm "surround51":
That means that the standard surround51 device should also work right out of
the box with the ice1724 chip?
I was surprised that the format problem has gone ;)

Hm... I tried that but it doesn't work - still sound only out of the front speakers with
xmms and the duplicate output device. Do I need anything else?

Andreas


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
