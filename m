From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: hardware channel mixing [EMU10K1 DMA]
Date: Tue, 07 Sep 2004 02:53:10 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1094539989.16954.71.camel@krustophenia.net>
References: <Pine.HPX.4.33n.0409031451550.24397-100000@studcom.urz.uni-halle.de>
	 <1094254221.6575.94.camel@krustophenia.net>
	 <1094260793.3727.19.camel@localhost>
	 <1094408916.4445.13.camel@krustophenia.net>
	 <Pine.LNX.4.58.0409061347340.8854@linux.local>
	 <1094503299.29921.78.camel@krustophenia.net>
	 <1094519360.3727.13.camel@localhost>
	 <1094532469.16954.15.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1094532469.16954.15.camel@krustophenia.net>
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

On Tue, 2004-09-07 at 00:47, Lee Revell wrote:
> OK, I think I got it.  The OSS driver uses the interval timer for
> playback.  The ALSA driver does not use the timer interrupt at all, and
> the OSS driver does not seem to use the channel loop interrupt at all.  
> 
> The interval timer seems to be intended exactly for this use; I am a bit
> baffled as to why was the channel loop interrupt, a relatively obscure
> feature, was chosen as the playback interrupt source.
> 
> I should have a patch in a day or two to eliminate the extra voice. 
> Looks like this will also allow the driver to support real multichannel
> PCM playback rather than the current kludge of alsa plugins using
> multiple stereo and mono PCMs for 5.1, etc.
> 

The above is almost right; this will eliminate the extra voice for
regular PCM playback, system sounds, etc but will not give you sample
accurate synchronized full duplex operation like kX ASIO.  The only way
to do this is to have all the period_elapsed callbacks for the linked
capture/playback streams run atomically in the same interrupt handler. 

This can be achieved by adding another multichannel playback device,
corresponding to the hw;0,2 FXBus, and use the efx_capture interrupt for
playback.  When these playback channels are opened a voice is allocated
and added to the efx capture device;s linked linked list of playback
streams.  This _has_ to be how the ASIO drivers work.

I should have a patch fairly soon.

Lee



-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
