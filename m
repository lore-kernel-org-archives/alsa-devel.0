From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: hardware channel mixing [EMU10K1 DMA]
Date: Tue, 07 Sep 2004 14:26:43 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1094581603.16954.92.camel@krustophenia.net>
References: <Pine.HPX.4.33n.0409031451550.24397-100000@studcom.urz.uni-halle.de>
	 <1094254221.6575.94.camel@krustophenia.net>
	 <1094260793.3727.19.camel@localhost>
	 <1094408916.4445.13.camel@krustophenia.net>
	 <Pine.LNX.4.58.0409061347340.8854@linux.local>
	 <1094503299.29921.78.camel@krustophenia.net>
	 <1094519360.3727.13.camel@localhost>
	 <1094532469.16954.15.camel@krustophenia.net>
	 <Pine.LNX.4.58.0409071022180.1723@linux.local>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.58.0409071022180.1723@linux.local>
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

On Tue, 2004-09-07 at 04:23, Jaroslav Kysela wrote:
> On Tue, 7 Sep 2004, Lee Revell wrote:
> 
> > The interval timer seems to be intended exactly for this use; I am a bit
> > baffled as to why was the channel loop interrupt, a relatively obscure
> > feature, was chosen as the playback interrupt source.
> 
> No, in this case you don't get exact interrupt at period boundary.
> It seems bigger problem (wrapping) than having an extra voice.
> 

Hmm.  If this is the case then it really seems like the OSS driver
should not work at all then.  You mentioned previously that removing the
extra voice would only allow 2 periods per buffer.  Do you mean that the
interval timer could be used in this case, and that it's only not
reliable for more than 2 periods per buffer?  Or would you still use the
channel loop interrupt, but on the playback voice rather than an extra
one?

How did you figure out the use of the channel loop interrupt, as this is
not used in the OSS driver at all?

Anyway, guess it's time to try it and see what happens.  It still seems
like I can implement the kX ASIO functionality without needing the extra
voice because the efx capture device provides a very high resolution
timer.

Lee



-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
