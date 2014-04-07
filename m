From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 26/44] fireworks: Add PCM interface
Date: Mon, 07 Apr 2014 16:20:14 +0900
Message-ID: <534251AE.4020308@sakamocchi.jp>
References: <1395400229-22957-1-git-send-email-o-takashi@sakamocchi.jp>
	<1395400229-22957-27-git-send-email-o-takashi@sakamocchi.jp>
	<533E71C8.9030606@ladisch.de> <53414C45.2070006@sakamocchi.jp>
	<53416A44.6070905@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux1394-devel-bounces@lists.sourceforge.net>
In-Reply-To: <53416A44.6070905@ladisch.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux1394-devel>
List-Post: <mailto:linux1394-devel@lists.sourceforge.net>
List-Help: <mailto:linux1394-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux1394-devel-bounces@lists.sourceforge.net
To: Clemens Ladisch <clemens@ladisch.de>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, linux1394-devel@lists.sourceforge.net, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

Hi Clemens,

(Apr 6 2014 23:52), Clemens Ladisch wrote:
>>>> +static int pcm_open(struct snd_pcm_substream *substream)
>>>> +{
>>>> +    ...
>>>> +    /*
>>>> +     * When source of clock is not internal or any PCM streams are running,
>>>> +     * available sampling rate is limited at current sampling rate.
>>>> +     */
>>>> +    if ((clock_source != SND_EFW_CLOCK_SOURCE_INTERNAL) ||
>>>> +        amdtp_stream_pcm_running(&efw->tx_stream) ||
>>>> +        amdtp_stream_pcm_running(&efw->rx_stream)) {
>>>
> There is already a mutex for everything in start_duplex(), so the only
> unprotected piece of data is this counter.

Yes. I think atomic_t mostly solves the issue.


But these codes (in PCM .open) includes another issue which brings a 
great headache to me.

The driver uses SNDRV_PCM_INFO_JOINT_DUPLEX. So sampling rate for 
playback/capture should be the same. But there is a case to allow 
applications to break this rule.

Let's assume that two applications try to use PCM functionality. 
Application 1 is for 48.0kHz playback, and Application 2 is for 88.2kHz 
capture. In this case, Application 1 write 48.0kHz samples on 88.2kHz 
streams:

Application 1: snd_pcm_open() for playback
Application 1: snd_pcm_hw_params() at 48.0kHz
(snd_pcm_prepare() and AMDTP streams start)
Application 2: snd_pcm_open() for capture
Application 2: snd_pcm_hw_params() at 88.2kHz
(snd_pcm_prepare() and AMDTP streams re-start)
Application 2: read PCM samples
Application 1: write PCM samples

The reason to allow snd_pcm_prepare() to restart streams at different 
sampling rate is to continue MIDI substreams at different sampling rate.

I've been considering about this issue for several months but still have 
no good ideas...

But I think this is actually too rare. I assume most applications 
write/read samples after snd_pcm_hw_params() as soon as possible and 
most sound server uses the same sampling rate for its capturing/playbacking.

So I hope this issue pending for my future work.


Thanks

Takashi Sakamoto
o-takashi@sakamocchi.jp


------------------------------------------------------------------------------
Put Bad Developers to Shame
Dominate Development with Jenkins Continuous Integration
Continuously Automate Build, Test & Deployment 
Start a new project now. Try Jenkins in the cloud.
http://p.sf.net/sfu/13600_Cloudbees_APR
