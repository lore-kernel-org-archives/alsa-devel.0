From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: problems with Terratec Aureon Sky 5.1
Date: Sun, 14 Mar 2004 17:59:38 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0403141751370.3332@pnote.perex-int.cz>
References: <20040314164136.GA24447@phoenix.hadiko.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20040314164136.GA24447@phoenix.hadiko.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Andreas Bulling <uek32z@phoenix.hadiko.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Sun, 14 Mar 2004, Andreas Bulling wrote:

> -----
> andreas@phoenix andreas $ aplay -Dsurround51 /usr/kde/3.2/share/sounds/pop.wav
> Playing WAVE '/usr/kde/3.2/share/sounds/pop.wav' : Signed 16 bit Little Endian, Rate 44100 Hz, Mono
> aplay: set_params:827: Sample format non available
> -----
> 
> The common format problem, but why hasn't it already been fixed in
> /usr/share/alsa/cards/ICE1724.conf? I looked into the file, changed a little

Because it's perfectly ok. The applications should use 'plug:surround51' 
device if they want to enable automatic conversions. So, report this bug 
to xine developers.

> bit but had no success.

> Using -Dplug:surround51 instead works, but still without sound out of the
> rear speakers...

Are you sure that xine sends six channels to device? It looks like that 
only two channels are processed and in this case alsa-lib default 
configuration copies only two channels to output.

If you refer to 'aplay -Dplug:surround51' then it won't work, too. Same 
problem - you need to override the default policy for the plug plugin:

  route_policy STR      # route policy for automatic ttable generation
                        # STR can be 'default', 'average', 'copy', 'duplicate'
                        # average: result is average of input channels
                        # copy: only first channels are copied to destination
                        # duplicate: duplicate first set of channels
                        # default: copy policy, except for mono capture - sum

So, you need something like:

pcm.duplicate {
	type plug
	slave.pcm "surround51"
	route_policy duplicate
}

And now, 'aplay -Dduplicate' will duplicate stream to all six channels.

It is also possible that you can do duplication at hardware level, but
I don't remember the ICE1724 datasheet....

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
