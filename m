From: Martin Langer <martin-langer@gmx.de>
Subject: Re: usbus428 0.0.7 patch against release alsa-driver 0.9.6 (was Re: tascam gives a go for us428 @ alsa ...)
Date: Wed, 20 Aug 2003 19:58:11 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030820175811.GA876@tuba.home>
References: <200304301356.34023.annabellesgarden@yahoo.de> <s5hfzntcz7q.wl@alsa2.suse.de> <200307302133.37883.annabellesgarden@yahoo.de> <s5h3cgdle87.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <s5h3cgdle87.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Karsten Wiese <annabellesgarden@yahoo.de>, alsa-devel@lists.sourceforge.net, us428@drehmoment.org
List-Id: alsa-devel@alsa-project.org

On Thu, Aug 07, 2003 at 04:44:08PM +0200, Takashi Iwai wrote:
> At Wed, 30 Jul 2003 21:33:37 +0200,
> Karsten Wiese wrote:
> > 
> > i agree that its a reasonable goal to integrate the us428 audio part into ALSA 
> > usb-audio. is there such a mechanism to syncronize the playback-pipe by the 
> > capture-pipe allrteady in usb-audio.c? the us428 definitly needs such a 
> > beast.
> 
> i'm not sure what you mean here, but i guess it's not implemented.
> (is it a standard USB audio feature? if not, we don't have it :)

Stupid question: Why do we need synchronisation??

Isn't it the job of the FPGA? We know that each signal is routed across the
FPGA and that's why the config data should be loaded into for standalone
usage or nothing will work on our USxxx. Without an internal
synchronisation there would be no standalone usage possible or do I make a
mistake here.

What about removing synchronisation stuff and replacing it with some 
talking to the FPGA buffer??? I guess that will not fit into USB AUDIO
class, but anyhow my USxxx is vendor specififc.


martin


-------------------------------------------------------
This SF.net email is sponsored by Dice.com.
Did you know that Dice has over 25,000 tech jobs available today? From
careers in IT to Engineering to Tech Sales, Dice has tech jobs from the
best hiring companies. http://www.dice.com/index.epl?rel_code=104
