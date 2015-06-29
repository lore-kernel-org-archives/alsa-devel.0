From: Laurence Darby <ldarby@tuffmail.com>
Subject: Re: [PATCH] ALSA: oxygen: Fix S/PDIF muting
Date: Mon, 29 Jun 2015 21:01:59 +0100
Message-ID: <20150629210159.b8c7f6baa83eef02555686f1@tuffmail.com>
References: <20150628131337.d8077aed73a9851b194bdc30@tuffmail.com>
 <5590408A.6030100@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mxout-07.mxes.net (mxout-07.mxes.net [216.86.168.182])
 by alsa0.perex.cz (Postfix) with ESMTP id D59362656F5
 for <alsa-devel@alsa-project.org>; Mon, 29 Jun 2015 22:02:03 +0200 (CEST)
In-Reply-To: <5590408A.6030100@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sun, 28 Jun 2015 20:44:26 +0200 Clemens Ladisch wrote:

> Laurence Darby wrote:
> > The S/PDIF output was muted whenever audio wasn't playing which
> > resulted in a clicking noise from the DAC when resuming
> 
> It indeed appears that there are too many oxygen_clear_bits32() calls.
> However, I don't trust the hardware; please confirm that the S/PDIF
> output, without an active stream, play zeros and not the last sample.

Well, to test that I created a wav file of about a quarter of a sine
wave (at about -15dB), consisting of 5520 samples, so it matched the
alsa buffer size, otherwise aplay pads the buffer with silence.

The chip does continue playing the last sample value, then the speakers
pop later when something else is played.  Is this really an issue
though? I just found my intel hda chip behaves the same way, and that
chip's driver leaves it un-muted.

If this is still going to prevent fixing the popping noise for the
oxygen chip, what about writing a single 0x00 sample to it in the
driver instead of muting it?

> 
> > Also, the mixer control wasn't actually controlling the S/PDIF
> > output.
> 
> Because that is not its purpose to begin with.  >:-)
> 
> The mixer control enables copying the "Multichannel" device to the
> S/PDIF output.  The "Digital" device has no mute, and takes precedence
> over the multichannel device when both are active.
> 

All my other sound cards (hda, cmedia & emu10k) have an S/PDIF mixer
control that mutes the output (i.e. causes the DAC to lose the signal),
in the same way as disabling OXYGEN_SPDIF_OUT_ENABLE does, so I would
say that it does have mute, and I thought it should be controlled by
the variable called "spdif_playback_enable"...

Would an acceptable fix be to create another mixer control for muting
(and also rename the existing S/PDIF to e.g. "S/PDIF Multichannel"
so its clearer what that's for)?

Regards,
Laurence
