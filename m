From: "Bob Ingraham" <bobi@netshel.net>
Subject: Re: Converting OSS ioctl's to ALSA API
Date: Wed, 7 Sep 2005 10:09:06 -0700 (PDT)
Message-ID: <52491.12.110.19.97.1126112946.squirrel@12.110.19.97>
References: <33017.65.103.251.231.1125967798.squirrel@65.103.251.231>
    <Pine.HPX.4.33n.0509060950330.11382-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.HPX.4.33n.0509060950330.11382-100000@studcom.urz.uni-halle.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Thank-you so much for ioctl mapping!

May I ask one other architectural question?

This video-conferencing app expected to use two half-duplex devices for
simultaneous record-playback:

/dev/dsp0 and /dev/dsp1 - these were expected to be configured as the
separate playback and record channels of a single soundcard.

However, on all of our target platforms (all running
SuSE/Novell-Linux-Desktop,) there only appears to be a single, full-duple=
x
device to use (plugwh:0,0) for both record and playback.

So the (three-part) question is:

1. Do I:

  (a) Try to re-write this app to use full-duplex? or,

  (b) Can I re-configure ALSA to split the default device (plughw:0,0)
into two separate, half-duplex sub-devices (one for playback and one for
record?


2. Which approach makes more sense (i.e., more stable, reliable, etc.)?


3. If 1a is the way to go, is there a tutorial or sample-doc on how to
properly program full-duplex (simultaneous record & playback) operation
under ALSA?


Thanks,
Bob

> Bob Ingraham wrote:
>> what would be the equivalent of the OSS SNDCTL_DSP_SYNC ioctl?
>
> snd_pcm_drain()
>
>> SNDCTL_DSP_SETFRAGMENT
>
> snd_pcm_hw_params_set_period_size()
> snd_pcm_hw_params_set_periods()
>
>> SNDCLT_DSP_GETOSPACE, SNDCTL_DSP_GETISPACE
>
> snd_pcm_avail_update()
>
>
> HTH
> Clemens
>
>



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practic=
es
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & Q=
A
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
