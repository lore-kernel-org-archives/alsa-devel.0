From: Rask Ingemann Lambertsen <rask@sygehus.dk>
Subject: Re: [RFC][RFT] Adding support for Jazz16 based sound
	cards
Date: Tue, 13 Mar 2007 00:23:57 +0100
Message-ID: <20070312232356.GA25489@sygehus.dk>
References: <20070311232436.GB9778@sygehus.dk> <s5h4poqsnun.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <s5h4poqsnun.wl%tiwai@suse.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: Adam Belay <ambx1@neo.rr.com>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Mon, Mar 12, 2007 at 12:28:00PM +0100, Takashi Iwai wrote:
> At Mon, 12 Mar 2007 00:24:36 +0100,
> Rask Ingemann Lambertsen wrote:
> > 
> >    Below is a patch against linux-2.6.20 to add support for Jazz16 sound
> > cards. It consists of changes to ALSA's SoundBlaster support and a new PnP
> > protocol for detecting the card, setting resources and such. Before
> > submitting a patch for inclusion into Linux, I would like to have a few
> > comments and perhaps a test report from someone else.
> 
> At a quick review, it's mostly OK.  There are small coding-style
> issues (see below), but the code itself looks fine.

   Will be fixed.

> >    Setting the irq of the MPU-401 port requires the SB part to be active and
> > even worse, DSP commands need to be sent. Would it be better to just use the
> > MPU-401 port without an irq and avoid the complexity?
> 
> Isn't SB part already active?

   Not the way it is right now, because the MPU-401 port is a separate PnP
device. I'm not sure that is right, but it is consistent with the only
example of a PNPb00f-device I have, which is the one at
<URL:http://www.garbled.net/tmp/residual/residual.6015-2>.

> It's fine with non-irq version (which
> uses timer) if the code gets too complicated, of course.


> > @@ -278,14 +377,14 @@ static int snd_sb8_capture_prepare(struc
> >  	} else {
> >  		snd_sbdsp_command(chip, 256 - runtime->rate_den);
> >  	}
> > -	if (chip->capture_format != SB_DSP_OUTPUT) {
> > +	if (chip->capture_format != SB_DSP_INPUT) {
> 
> Is this a bug in the current code?

   I believe it is a bug, and if it is, will cause capture to fail on SB 1.0
hardware. This should have been in a separate patch.

-- 
Rask Ingemann Lambertsen

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
