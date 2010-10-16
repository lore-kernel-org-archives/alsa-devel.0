From: Julian Scheel <julian@jusst.de>
Subject: Re: USB asynchronous mode feedback format
Date: Sat, 16 Oct 2010 12:25:38 +0200
Message-ID: <201010161225.39002.julian@jusst.de>
References: <1287046026.4cb6c38a2a179@discus.singnet.com.sg>
	<201010151919.41810.julian@jusst.de>
	<1287193974.2133.2.camel@desktop-alex>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp2.work.de (smtp.work.de [212.12.45.188])
	by alsa0.perex.cz (Postfix) with ESMTP id AD1992473A
	for <alsa-devel@alsa-project.org>;
	Sat, 16 Oct 2010 12:25:40 +0200 (CEST)
In-Reply-To: <1287193974.2133.2.camel@desktop-alex>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Alex Lee <lee188@singnet.com.sg>, Daniel Mack <daniel@caiaq.de>
List-Id: alsa-devel@alsa-project.org

Am Samstag, 16. Oktober 2010, 03:52:54 schrieb Alex Lee:
> On Fri, 2010-10-15 at 19:19 +0200, Julian Scheel wrote:
> > Correcting myself. It detects the card, but playback is not possible
> > anymore:
> > 
> > LC_ALL=en speaker-test -Dusb -c 2 -t sine -f 1000
> > 
> > speaker-test 1.0.23
> > 
> > Playback device is usb
> > Stream parameters are 48000Hz, S16_LE, 2 channels
> > Sine wave rate is 1000.0000Hz
> > Rate set to 48000Hz (requested 48000Hz)
> > Buffer size range from 96 to 262144
> > Period size range from 48 to 131072
> > Using max buffer size 262144
> > Periods = 4
> > Unable to set hw params for playback: Broken pipe
> > Setting of hwparams failed: Broken pipe
> 
> > Is this a hint to not-working feedback? (c:
> You may need to respond to the specific requests for get and set of the
> sampling rate of the audio stream, once you have the Sample Rate
> Attribute set.  See my sdr-widget code to process these requests:

Thanks, I implemented them the way same you did. So for get_min/max/cur I 
always return 48kHz and set_cur simply does nothing.
Now playback in general works again. But still the rate feedback seems to have 
no impact on the data-rate. Also the frequency value shown in proc-interface 
is unchanged. When rate feedback works, it would probably be slightly 
different than 48.000kHz?!

Regards,
Julian
