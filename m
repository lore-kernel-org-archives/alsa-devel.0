From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: potential emu10k1 bug/issue for Audigy2 ZS Platinum Pro
Date: Thu, 10 Feb 2005 17:12:42 -0500
Message-ID: <1108073563.11177.1.camel@krustophenia.net>
References: <420B8B23.2090404@vt.edu>
	 <1108067206.10310.7.camel@krustophenia.net>  <420BD024.8040602@vt.edu>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
In-Reply-To: <420BD024.8040602@vt.edu>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Rick Wright <riwright@vt.edu>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Thu, 2005-02-10 at 16:20 -0500, Rick Wright wrote:
> > > The real problem is that the PCM output volume control sliders are 
> > > backwards (or perhaps the remapping the channels to L/R, rather than R/L 
> > > will fix this).  For example: PCM Front L slider controls the volume of 
> > > playback_9 which is the RIGHT Front signal, PCM Front R slider controls 
> > > playback_10 which is the LEFT Front signal.  This is true for all of the 
> > > Stereo Output channel pairs.  If you think about it, the PCM sliders are 
> > > actually controlling the correct physical L & R outputs on the card, but 
> > > the alsa_pcm:playback signals being routed to those physical channels 
> > > are reversed, make sense?
> > > 
> > > Is this a bug?  If so, what is the proper place/way to report it so that 
> > > I don't use any more of your time?  Has it already been fixed?  I know 
> > > you mentioned v008 still had problems...
> > > 
> > >     
> > 
> > ISTR that this is a hardware bug, and the kX driver works around it.  I
> > will look into it.
> > 
> > Are the channels reversed if you use JACK with the default stereo PCM,
> > hw:0,0?
> > 
> >   
> Using hw:0,0 for BOTH the Input & Output devices in QJackCtl:
> (actually, input probably doesn't matter, huh?)
> playback_1 maps to Stereo Output #1 RIGHT and volume is controlled by
> the PCM LEFT slider
> playback_2 maps to Stereo Output #1 LEFT and volume is controlled by
> the PCM RIGHT slider
> 
> In this case, it seems that slider is controlling the correct
> playback_x stream, but the stream is mapped to the wrong stereo
> channel of the soundcard.

This does look like an upstream bug.  Can you verify that the channels
are still reversed without my patch?

Lee



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
