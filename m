From: Peter Stuge <stuge-alsa@cdy.org>
Subject: Re: USB soundcard acting up
Date: Tue, 17 May 2005 17:05:15 +0200
Message-ID: <20050517150515.GA25071@foo.birdnet.se>
References: <20050517004134.GA15202@foo.birdnet.se> <Pine.HPX.4.33n.0505170945570.13786-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <Pine.HPX.4.33n.0505170945570.13786-100000@studcom.urz.uni-halle.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

(I'm on the list, please don't cc me. Thanks!)

Thanks for the reply!

On Tue, May 17, 2005 at 09:54:10AM +0200, Clemens Ladisch wrote:
> Peter Stuge wrote:
> > The PCM2902 is a USB Audio Class device and the ALSA driver picks it
> > up without problems. It works well most of the time, but..
> >
> > Now and then the MD deck unlocks for a fraction of a second, i.e.
> > loses sync in the digital input stream, which of course causes audio
> > to be lost.
> >
> > Question is where the problem lies. It's not really reproducable, it
> > happens stochastically whether I'm actually playing audio or not.
> 
> That is, when you aren't playing anything, the device sends a stream
> of silence which has the same glitches?

Correct. This would indicate that the problem isn't really with ALSA,
but I figured someone on the list could provide insight from
experience with USB audio devices in general. :)


> The output endpoints use adaptive synchronization, i.e., the PCM2902
> is responsible for determining the exact rate of USB data, and
> synchronizin to that.  It may be possible that it thinks the sample
> rate has changed, or that it can better approximate the USB data rate
> by using a slightly different sample rate.

Aha. I haven't read up on the Audio Class spec but I imagined there
was a command for selecting the sampling rate.


> Does this happen at both 44.1 and 48 kHz?  Synchronization at 44.1
> kHz isn't easy because packet sizes aren't constant, but at 48 kHz,
> the driver sends exactly 48 samples per USB frame.

Right, I remember there was something special each 9th frame when
running at 44.1 from when I've looked in the audio class spec last.

But yes, it has happened at both rates. I've experimented back and
forth but haven't found any sure way to either reproduce or suppress
the problem.

Thanks for the input so far!


//Peter


-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7412&alloc_id=16344&op=click
