From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: M-Audio FTU issues
Date: Fri, 24 Jun 2011 17:58:38 +0200
Message-ID: <4E04B42E.2080906@ladisch.de>
References: <BANLkTimOjiKwOqSveGvujMJ5uBL-JKsBeA@mail.gmail.com>	<4E045058.6000405@showlabor.de>
	<BANLkTi=Bj7DFbSFs9p1go-ACzCAtZ=ij6w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3.smtp.messagingengine.com (out3.smtp.messagingengine.com
	[66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id DAE4624634
	for <alsa-devel@alsa-project.org>;
	Fri, 24 Jun 2011 17:58:42 +0200 (CEST)
In-Reply-To: <BANLkTi=Bj7DFbSFs9p1go-ACzCAtZ=ij6w@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>
Cc: alsa-devel@alsa-project.org, =?UTF-8?B?QXVyw6lsaWVuIExlYmxv?=@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Grant Diffey <gdiffey@gmail.com>, Felix Homann <linuxaudio@showlabor.de>, =?UTF-8?B?bmQ=?= <blablack@gmail.com>
List-Id: alsa-devel@alsa-project.org

Daniel Mack wrote:
> 1. Like I posted last year, I wanted to just collect the number of
> received frames when capturing data and modify
> snd_audio_next_packet_size() so that it approximates to the number of
> samples received in the record stream. This didn't work as easily
> because the streaming loop ended up queueing 0-byte packets which the
> hardware doesn't like at all. It will stop streaming and won't recover
> after the first empty packet was sent.

There are other devices with the same bug.

> 3. The most promising approach (the one implemented in the attached
> patch) splits the urb's size calculation from the actual ops.prepare()
> handler and re-uses the ops.prepare() from a new function called
> queue_next_out_urb(). For this, our complete_urb function must be
> modified to not automatically requeue the next out urb but leave it to
> the capture stream's retire callbacks when to fire the next out packet
> (and here, we will ignore 0-byte input packets and not send out 0-byte
> out urbs). A new counter variable (next_out_urb) is needed for that.
> 
> The problem, however, is that we now have to check when to actually
> start and stop the capture stream:
> 
> - We have to start it (and put it to pause mode) once the playback
> starts and switch over to the real callback once the user starts the
> capture PCM stream
> - We also have to start it if the user only wants to capture PCM,
> without playback.
> - We can stop it if the user was only using capture PCM or playback PCM streams.
> - But we cannot stop it if it still serves as feedback source for a
> running playback PCM.

The same logic is implemented in ua101.c.

> I started to implement some logic for this, but I'm not really happy
> with it yet. Some reference counting would be much better than what I
> currently have, but I don't see a good solution yet. Maybe I've been
> looking at this for too long now, and someone else has an idea?

The overall structure of the code handling the PCM streams becomes
different: not only must the starting/stopping of the USB capture stream
be decoupled from the ALSA stream, but the handling of audio formats and
URB buffers changes because capturing can be started before the ALSA PCM
capture stream is configured.

I think the best solution would be to move the USB streaming into
a module, add implicit feedback support there, and create a separate
driver for the FTU and similar devices.  (I'm doing this for FireWire
streaming right now, and always wanted to do the same for USB.  Many
thanks for volunteering!  :-)


Regards,
Clemens
