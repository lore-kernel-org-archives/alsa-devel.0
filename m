From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: hardware channel mixing [EMU10K1 DMA]
Date: Wed, 08 Sep 2004 18:49:18 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1094683758.1362.231.camel@krustophenia.net>
References: <Pine.HPX.4.33n.0409031451550.24397-100000@studcom.urz.uni-halle.de>
	 <1094254221.6575.94.camel@krustophenia.net>
	 <1094260793.3727.19.camel@localhost>
	 <1094408916.4445.13.camel@krustophenia.net>
	 <Pine.LNX.4.58.0409061347340.8854@linux.local>
	 <1094503299.29921.78.camel@krustophenia.net>
	 <1094519360.3727.13.camel@localhost>
	 <1094532469.16954.15.camel@krustophenia.net>
	 <Pine.LNX.4.58.0409071022180.1723@linux.local>
	 <1094581603.16954.92.camel@krustophenia.net>
	 <Pine.LNX.4.58.0409072104340.32166@linux.local>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.58.0409072104340.32166@linux.local>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: mjander@users.sourceforge.net, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Tue, 2004-09-07 at 15:16, Jaroslav Kysela wrote:
> On Tue, 7 Sep 2004, Lee Revell wrote:
> 
> > On Tue, 2004-09-07 at 04:23, Jaroslav Kysela wrote:
> > > On Tue, 7 Sep 2004, Lee Revell wrote:
> > > 
> > > > The interval timer seems to be intended exactly for this use; I am a bit
> > > > baffled as to why was the channel loop interrupt, a relatively obscure
> > > > feature, was chosen as the playback interrupt source.
> > > 
> > > No, in this case you don't get exact interrupt at period boundary.
> > > It seems bigger problem (wrapping) than having an extra voice.
> > > 
> > 
> > Hmm.  If this is the case then it really seems like the OSS driver
> > should not work at all then.
> 
> It works, but with higher latencies than application requested. You can 
> probably write a timer scheduler code, but it will be probably 
> a maintenance nightmare.
> 

Hmm, looks like the OSS driver sets the interval timer, then when this
goes off, uses a tasklet to schedule the work that ALSA does in the
pointer callback!  Of course this will result in higher latencies than
the application requested, it seems like this would not work well at
all.

The timer seems to support latencies as low as 4 sample periods, so it
looks like it would work since the ALSA driver would run the pointer
callback directly from the timer interrupt handler.

It doesn't seem like this would be too bad to maintain, the timer
handler code in the OSS driver is very simple.

However the OSS driver seems suspiciously missing some things.  For
example the capture buffer interrupt handlers are not used at all, it
uses the interval timer for capture too, which seems broken.

Lee



-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
