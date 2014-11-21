From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: usb: offset in trigger_tstamp?
Date: Fri, 21 Nov 2014 14:28:17 +0100
Message-ID: <546F3DF1.50205@ladisch.de>
References: <1416476977-20118-1-git-send-email-padma.v@samsung.com>
 <CAAgF-BfwGsn6HbJWH8uE48F2VWAYnAkv8=kGPkqCEWKaBM6=GQ@mail.gmail.com>
 <546E1D3D.50500@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id 15B34266AFD
 for <alsa-devel@alsa-project.org>; Fri, 21 Nov 2014 14:28:19 +0100 (CET)
In-Reply-To: <546E1D3D.50500@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Pierre-Louis Bossart wrote:
> I was trying to find a bug in the timestamping logic I am working on
> and after some time I realized the USB audio class driver seems to
> have an issue.
> If I instrument the code in sound/usb/pcm.c, I see a offset of up to
> 6ms between the  snd_usb_substream_playback_trigger and
> prepare_playback_urb steps
>
> [45053.102625] trigger_start
> [45053.108320] prepare_playback_urb
>
> My understanding is that empty URBs are submitted in the prepare step
> to avoid underflows, which is fine. The problem with that is that the
> trigger_tstamp value is captured before audio transfers actually start
> and there is a constant offset when trying to track audio/system time
> drifts or do basic a/v sync.

Most other devices have a FIFO that gets filled quickly when the stream
is started.  This results in a small offset in the opposite direction.

AFAICS you cannot avoid having an offset when trying to relate the
trigger_tstamp value to the sample clock.


Regards,
Clemens
