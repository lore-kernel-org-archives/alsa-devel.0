From: Mark Knecht <markknecht@attbi.com>
Subject: Re: NEW hdsp 9652 problems - {WAS: alsaconf -L -
	where's Waldo?)
Date: 21 Mar 2003 10:49:38 -0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1048272578.11156.56.camel@Wizard>
References: <20030321174201.MLEN28880.sccrgwc02.attbi.com@mail09.voicenet.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20030321174201.MLEN28880.sccrgwc02.attbi.com@mail09.voicenet.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Paul Davis <paul@linuxaudiosystems.com>
Cc: Alsa-Devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Fri, 2003-03-21 at 09:45, Paul Davis wrote:
> >Now, this all worked fine on the previous 2.4.19-1.ll kernel from the
> >PlanetCCRMA site **BEFORE** I updated firmware on the HDSP 9652 for new
> >Win XP driver support. After updating firmware for the card, the
> >alsaconf program I had for the 2.4.19-1.ll kernel no longer recognized
> >the card at all and cannot write anything in modules.conf.
> 
> you cannot use the current ALSA driver with the new firmware.
> 
> i submitted a patch to handle the new firmware, but it has not been
> put into CVS yet. meanwhile, thomas charbonnel has extended the work i
> did and added some more stuff, and so we are working on a "mega-patch"
> that fixes lots of issues with full H-DSP support.
> 
> once thomas gets his tasklet problems fixed (for MIDI I/O without
> affecting PCM latency), we'll submit the patch again.
> 
> --p

Paul,
   Well, I guess thanks then for saving the rest of my vacation Friday
from being a total waste of time. I took the day off to focus on getting
this Alsa stuff going. Now I find I cannot. Too bad for me I guess. 

    I guess I will take my vacation day and rewire my studio to get this
Linux box out of the audio path completely. In a few hours I'll be back
to where I was last September, other than using Linux for email now, it
just doesn't seem like a positive 6 months.

   Not your fault. All mine for even trying to use this Linux stuff
seriously I suppose. Such disappointment.

Mark



-------------------------------------------------------
This SF.net email is sponsored by:Crypto Challenge is now open! 
Get cracking and register here for some mind boggling fun and 
the chance of winning an Apple iPod:
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0031en
