From: Peter L Jones <peter@drealm.org.uk>
Subject: Re: help needed on how to autoload snd-usb-midi
Date: Wed, 16 Oct 2002 18:49:28 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200210161849.29189@advent.drealm.org.uk>
References: <Pine.HPX.4.33n.0210161227530.11784-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.HPX.4.33n.0210161227530.11784-100000@studcom.urz.uni-halle.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Wednesday 16 Oct 2002 12:19, Clemens Ladisch wrote:
[snip]
>
> Well, the real reason why I wrote a sequencer driver was that I wanted to
> decide between a rawmidi and a sequencer driver, but there wasn't any
> sequencer driver supporting input, so I had to write one to find out about
> it.  ;-)

That's a _good_ reason in my book... ;-)

>
> It turns out there isn't any real advantage over a rawmidi driver, so I
> think I'll change the driver to use rawmidi in the next few days.

Will this affect the code used when I'm playing (with) my USB MIDI keyboard?  
(i.e. do I need to test it? ;-) )
>
>
> Regards
> Clemens
>
>
>
> -------------------------------------------------------
> This sf.net email is sponsored by: viaVerio will pay you up to
> $1,000 for every account that you consolidate with us.
> http://ad.doubleclick.net/clk;4749864;7604308;v?
> http://www.viaverio.com/consolidator/osdn.cfm
> _______________________________________________

Oh dear, we're selling stuff for sf.net :-))

-- Peter


-------------------------------------------------------
This sf.net email is sponsored by: viaVerio will pay you up to
$1,000 for every account that you consolidate with us.
http://ad.doubleclick.net/clk;4749864;7604308;v?
http://www.viaverio.com/consolidator/osdn.cfm
