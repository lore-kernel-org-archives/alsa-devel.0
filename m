From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: snd-usb-audio syncronisation problem
Date: Fri, 22 Feb 2008 14:09:14 +0100
Message-ID: <47BEC97A.3030507@ladisch.de>
References: <43e8c7320802220151p177d2c73y2c9724a4cb4743ef@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3.smtp.messagingengine.com (out3.smtp.messagingengine.com
	[66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id 6AC32245D0
	for <alsa-devel@alsa-project.org>; Fri, 22 Feb 2008 14:07:28 +0100 (CET)
In-Reply-To: <43e8c7320802220151p177d2c73y2c9724a4cb4743ef@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Adrian Stancu <adrian.stancu.82@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Adrian Stancu wrote:
> I'm using an E-MU 0404 USB interface with the snd-usb-audio module
> from alsa 1.0.16, operating in isochronous asynchronous mode. This
> interface was producing very annoying click/pop sounds at regular
> intervals during playback. Eventually I discovered that the
> syncronisation mechanism telling the driver to send audio data faster
> or slower to match the interface's consumption speed does not work as
> expected, for some reason.

The momentary frequency as requested by the device is shown in
/proc/asound/card?/stream? (if CONFIG_SND_VERBOSE_PROCFS is enabled).

Try something like:

while sleep 0.3; do grep "Momentary freq" /proc/asound/card0/stream0; done

In theory, once the device has determined its own speed relative to
the computer, this value should be nearly constant.  (When a stream has
just been started, the requested frequency usually is higher because the
device's buffer is empty.)


Regards,
Clemens
