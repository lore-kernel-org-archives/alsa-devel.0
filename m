From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: potential emu10k1 bug/issue for Audigy2 ZS Platinum Pro
Date: Thu, 10 Feb 2005 15:26:46 -0500
Message-ID: <1108067206.10310.7.camel@krustophenia.net>
References: <420B8B23.2090404@vt.edu>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
In-Reply-To: <420B8B23.2090404@vt.edu>
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

[forwarding to alsa-devel]

On Thu, 2005-02-10 at 11:26 -0500, Rick Wright wrote:
> Hi Lee,
> 
> Sorry to keep bothering you re the emu10k1 driver, but I've finally had 
> some success with multichannel I/O and now think I have found some 
> bugs.  I really want to thank you for your efforts in maturing this driver.
> 
> I've never filed a bug report for anything in Linux, but I would like to 
> contribute to the community.  Could you give me an overview of the 
> process so that I can use that avenue for all future issues I find?
> 
> I've finally gotten the multichannel capture to show me 16 channels by 
> default like everyone assured me it should do.  Not sure how this 
> happened.  I was fooling with trying to use ALSA CVS and apply your v009 
> patch (per your suggestions), but couldn't get it to compile (newb 
> problem..).  Anyway, I finally reverted to ALSA 1.0.8 patched with your 
> v008 and suddenly it gave me 16 capture channels using the original 
> asound.state file that I previously had only 2 cpature channels with (I 
> had backed it up, then copied it back after reinstalling the patched 
> 1.0.8).  I've no idea what happened to make it work, but work it does!
> 
> The problem:
> The Left & Right PCM channel volume controls (gnome-control-volume) are 
> reversed for each of the L/R stereo output signals.
> 
> I remember you mentioned that you couldn't guarantee all the correct 
> channel mapping for every card out there, so here is my contribution.   
> I've done some thorough testing to map capture/playback ports to 
> physical channels on my Audigy2 Platinum Pro card w/external connection 
> box and here are my results (this is both FYI and relevant info to the 
> bug/issue I believe I've found):
> 
> Inputs to PCM Capture ports:            (with my 5.1 setup -- I tried to 
> keep the input routing is consistent with the 5.1 output routing)
> Line In #1 Left     =    capture_10      (LF)
> Line In #1 Right   =    capture_9        (RF)
> Line In #2 Left     =    capture_12      (LR)
> Line In #2 Right   =    capture_11      (RR)
> Line In #3 Left     =    capture_13      (Cen)
> Line In #3 Right   =    capture_14      (LFE)
> 
> Outputs to PCM Playback ports:                        (5.1 setup 
> described in Audigy2 product literature)
> Stereo Output #1 Left     =    playback_10         (LF)
> Stereo Output #1 Right   =    playback_9           (RF)
> Stereo Output #2 Left     =    playback_4           (LR)
> Stereo Output #2 Right   =    playback_3           (RR)
> Stereo Output #3 Left     =    playback_8           (Cen)
> Stereo Output #3 Right   =    playback_7           (LFE)
> 
> The first observation is that it's odd that all of the L/R channel pairs 
> are backwards from the typical Left-comes-first configuration (except 
> Line In #3)
> 
> The real problem is that the PCM output volume control sliders are 
> backwards (or perhaps the remapping the channels to L/R, rather than R/L 
> will fix this).  For example: PCM Front L slider controls the volume of 
> playback_9 which is the RIGHT Front signal, PCM Front R slider controls 
> playback_10 which is the LEFT Front signal.  This is true for all of the 
> Stereo Output channel pairs.  If you think about it, the PCM sliders are 
> actually controlling the correct physical L & R outputs on the card, but 
> the alsa_pcm:playback signals being routed to those physical channels 
> are reversed, make sense?
> 
> Is this a bug?  If so, what is the proper place/way to report it so that 
> I don't use any more of your time?  Has it already been fixed?  I know 
> you mentioned v008 still had problems...
> 
> Many thanks for both your work and your advice,
> -Rick
> 

ISTR that this is a hardware bug, and the kX driver works around it.  I
will look into it.

Are the channels reversed if you use JACK with the default stereo PCM,
hw:0,0?

Lee



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
