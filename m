From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: [Alsa-devel] Re: Re: Re: SB Live! PCM control
Date: Fri, 11 Feb 2005 15:33:14 -0500
Message-ID: <1108153994.20365.39.camel@krustophenia.net>
References: <420270C1.3000706@voicenet.com>
	 <1107457227.7256.37.camel@krustophenia.net>
	 <4202A72C.3000007@superbug.co.uk>
	 <1108141670.20188.4.camel@krustophenia.net>
	 <420D0112.2050509@superbug.co.uk>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-user-admin@lists.sourceforge.net>
In-Reply-To: <420D0112.2050509@superbug.co.uk>
Sender: alsa-user-admin@lists.sourceforge.net
Errors-To: alsa-user-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-user@lists.sourceforge.net>
List-Help: <mailto:alsa-user-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-user>
To: James Courtier-Dutton <James@superbug.co.uk>
Cc: Adam K Kirchhoff <adamk@voicenet.com>, alsa-user@lists.sourceforge.net, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Fri, 2005-02-11 at 19:01 +0000, James Courtier-Dutton wrote:
> Lee Revell wrote:
> > On Thu, 2005-02-03 at 22:35 +0000, James Courtier-Dutton wrote:
> > 
> >>I think it is unwise to implement a Master volume control for the SBLive 
> >>at this time. We had to remove it some time ago, and it can be 
> >>implemented in a better way that in the DSP code.
> >>
> > 
> > 
> > James, can you please elaborate on this a bit?  If you have a better way
> > then I don't want to waste time doing it in the DSP.
> > 
> > Lee
> > 
> 
> This should instead be supported in the alsa-lib mixer abstraction 
> layer, that unfortunately, has not been completed yet.
> Then, the DSP would have 3 stereo controls for front, rear, center/lfe 
> and the mixer lisp config would add a "virtual" Master control, that 
> would present a single "Master" control to the user application, but 
> alsa-lib would convert that to control messages to all 3 stereo controls.
> 
> I think your time would be better spent completing the mixer abstraction 
> layer that other alsa developers have already started.
> 

Sorry but I just don't have the bandwidth to work on alsa-lib.  There is
enough wrong with the emu10k1 driver.

> Another point, I personally did not remove the Master control, but it 
> disappeared due to lack of SB Live DSP GPR registers.

There is something gravely wrong with the default SBLive DSP config if
we don't have enough extra GPRs to implement a master volume.  The kX
driver does everything we do plus a chorus, reverb, and FX mixer.

Lee




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
