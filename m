From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: hardware channel mixing [EMU10K1 DMA]
Date: Tue, 07 Sep 2004 16:06:12 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1094587572.16954.138.camel@krustophenia.net>
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
	 <1094585672.16954.113.camel@krustophenia.net>
	 <Pine.LNX.4.58.0409072138040.32166@linux.local>
	 <1094586515.16954.123.camel@krustophenia.net>
	 <Pine.LNX.4.58.0409072151220.32166@linux.local>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.58.0409072151220.32166@linux.local>
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

On Tue, 2004-09-07 at 15:52, Jaroslav Kysela wrote:
> On Tue, 7 Sep 2004, Lee Revell wrote:
> 
> > On Tue, 2004-09-07 at 15:41, Jaroslav Kysela wrote:
> > > On Tue, 7 Sep 2004, Lee Revell wrote:
> > > 
> > > > I think you can start a stereo stream using one I/O transaction, but
> > > 
> > > No, voices are started independently, so even with stereo, there might be 
> > > no proper sample sync.
> > > 
> > 
> > Well even if this is the case, the ASIO drivers certainly seem to work
> > great.  What kinds of problems could this cause?
> > 
> > Maybe it works because the capture channels are always in sync?
> 
> Yes, efx device is only one, thus it is started only via one PCI 
> transaction.
> 

OK, so you can't start them in sync, but it seems like once you are
rolling then it would be OK.  Makes sense considering the emu10k1 seems
more designed for MIDI wavetable synthesis than PCM playback.

Lee



-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
