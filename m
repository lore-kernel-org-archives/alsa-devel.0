From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: ALSA processor usage is too high
Date: Fri, 05 Nov 2010 18:58:21 +0100
Message-ID: <4CD445BD.3020501@ladisch.de>
References: <AANLkTik-sb1OihaDhNgptH44gQ4__E+ozxhSKpA9GdSK@mail.gmail.com>
	<4CD41528.1060600@ladisch.de>
	<AANLkTinXm2G1y477xRTc_QjXuEZ_nyAqGWuSkq32KGe2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3.smtp.messagingengine.com (out3.smtp.messagingengine.com
	[66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id 58022103975
	for <alsa-devel@alsa-project.org>; Fri,  5 Nov 2010 18:56:34 +0100 (CET)
In-Reply-To: <AANLkTinXm2G1y477xRTc_QjXuEZ_nyAqGWuSkq32KGe2@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Adam Rosenberg <adam@alcorn.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Adam Rosenberg wrote:
> On Fri, Nov 5, 2010 at 10:31 AM, Clemens Ladisch <clemens@ladisch.de> wrote:
> > How much CPU does "aplay -D hw -t raw -f dat /dev/zero" use?
> 
> I do not know how to calculate CPU usage for a given process.

The time utility (if you have it) measures both elapsed and actually
used CPU time.

> For the audio playback I am polling the streams using
> snd_pcm_avail_update() and then writing the number of frames available
> using snd_pcm_writei().

And what does your program do when avail_update returns 0 frames?

> I am able to add aplay for testing so I used your command to open the
> 8 streams, removed the audio processing from my application, and ran
> the test again.  The result was 4 minutes and 35 seconds, which is
> basically the same as the result from the test within my application
> and much too slow.

You cannot write data faster than it's playing; the audio ring buffer
has a finite size.

You would have a problem if the processing and/or the driver would
make everything so slow that you wouldn't be able to write new data
to the device fast enough, which would result in an buffer underrun.
Does this actually happen?


Regards,
Clemens
