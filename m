From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: mono/stereo translation & number of frames per
 period
Date: Tue, 4 Apr 2017 11:18:13 +0200
Message-ID: <b8bbf9c0-74ee-45b7-c5c2-2fc33ac44934@ladisch.de>
References: <c803630b-965e-40fa-be7b-e16c8682431f@me.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from webclient5.webclient5.de (webclient5.webclient5.de
 [136.243.32.179])
 by alsa0.perex.cz (Postfix) with ESMTP id D7A562668F6
 for <alsa-devel@alsa-project.org>; Tue,  4 Apr 2017 11:18:14 +0200 (CEST)
In-Reply-To: <c803630b-965e-40fa-be7b-e16c8682431f@me.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Paul Stone <metabagel@icloud.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Paul Stone wrote:
> I thought that simply by reporting that my driver only supports two
> channels, that I could simply utilize a mixer or that ALSA would
> automatically support sending and receiving monaural data to/from my
> stereo-only driver. Ultimately, I wasn't able to make it work. Is this
> a mode of operation that ALSA supports, or does ALSA require the
> driver to support single-channel operation in order to send/receive
> monaural data?

The driver should report only those sample formats that the hardware
actually supports.

The ALSA library can do automatic sample rate/format conversions (with
the "default" or "plughw" devices).  However, this does not work if you
bypass it with the "hw" device.

> It appears that ALSA looks at the minimum period size and
> decides to send that much audio data for playback.

No; it tells you how large the buffer is, and your driver programs the
hardware to play from that buffer.  The application is responsible for
keeping the buffer filled.

Periods are where your hardware raises interrupts, to report progress.

> The minimum period size is in bytes

The fields in the snd_pcm_hw structure are for commonly-used constraints.
But you can put other constraints on the period size, if you need to.

But do you actually need it?  (Does your hardware support mono?)


Regards,
Clemens
