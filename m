From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: hardware channel mixing [EMU10K1 DMA]
Date: Tue, 07 Sep 2004 00:47:49 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1094532469.16954.15.camel@krustophenia.net>
References: <Pine.HPX.4.33n.0409031451550.24397-100000@studcom.urz.uni-halle.de>
	 <1094254221.6575.94.camel@krustophenia.net>
	 <1094260793.3727.19.camel@localhost>
	 <1094408916.4445.13.camel@krustophenia.net>
	 <Pine.LNX.4.58.0409061347340.8854@linux.local>
	 <1094503299.29921.78.camel@krustophenia.net>
	 <1094519360.3727.13.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1094519360.3727.13.camel@localhost>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: mjander@users.sourceforge.net
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Mon, 2004-09-06 at 21:09, Manuel Jander wrote:
> On Mon, 2004-09-06 at 16:41, Lee Revell wrote: 
> > > > It seems like if this were the case, then it would require a workaround
> > > > similar to the extra voice hack.  Does this seem plausible?
> > > 
> > > Maybe. But it forces us to use only two periods per ring buffer.
> > 
> > But this is how the hardware was designed to work.  It is ALSA that is
> > unusual in supporting more than 2 periods per buffer after all.  Is this
> > really the only reason for the extra voice?  It is good that ALSA
> > supports this, but forcing it on hardware that was not designed for it
> > doesn't make sense here.
> 
> If the most effective way is to use 2 DMA subbuffers, there are software
> means to emulate more periods. AFAIK, there is a Crystal CS42xx driver
> using that scheme, and the Aureal driver does this too (despite the
> latter supports upto 4 subbuffers).
> 

OK, I think I got it.  The OSS driver uses the interval timer for
playback.  The ALSA driver does not use the timer interrupt at all, and
the OSS driver does not seem to use the channel loop interrupt at all.  

The interval timer seems to be intended exactly for this use; I am a bit
baffled as to why was the channel loop interrupt, a relatively obscure
feature, was chosen as the playback interrupt source.

I should have a patch in a day or two to eliminate the extra voice. 
Looks like this will also allow the driver to support real multichannel
PCM playback rather than the current kludge of alsa plugins using
multiple stereo and mono PCMs for 5.1, etc.

Lee



-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
