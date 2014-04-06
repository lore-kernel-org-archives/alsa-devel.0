From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 24/44] fireworks: Add MIDI interface
Date: Sun, 06 Apr 2014 21:03:19 +0900
Message-ID: <53414287.4050801@sakamocchi.jp>
References: <1395400229-22957-1-git-send-email-o-takashi@sakamocchi.jp>
	<1395400229-22957-25-git-send-email-o-takashi@sakamocchi.jp>
	<533DD083.10506@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux1394-devel-bounces@lists.sourceforge.net>
In-Reply-To: <533DD083.10506@ladisch.de>
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

(Apr 4 2014 06:20), Clemens Ladisch wrote:
>> +++ b/sound/firewire/fireworks/fireworks_midi.c
>> +static int midi_capture_open(struct snd_rawmidi_substream *substream)
>> +{
>> +	struct snd_efw *efw = substream->rmidi->private_data;
>> +
>> +	efw->capture_substreams++;
>
> The MIDI .open callback is not synchronized with the PCM callbacks;
> this might race and must be protected with a mutex.

Exactly. And I've realized it.

The race appears between some processes to handle substream counter at 
the same time. The counter is changed by below operations:
  PCM  .hw_param/.hw_free
  MIDI .open/.close

I'm optimistic for this issue and I thought usual users rarely execute 
these operations at the same time. So I kept this issue pending for my 
future because I have some issues with higher priority than this issue.

Well, for this issue, I think it better to use atomic_t for substream 
counter than mutex. The way to use mutex is propper for MIDI 
.open/.close because these functions also execure stream_start_duplex() 
/ stream_stop_duplex() (then I must move mutex_lock/mutex_unlock from 
stream.c). But PCM .hw_param/.hw_free just increment / decrement 
substream counter. I think it consts expensive than such simple operation.


Thanks

Takashi Sakamoto
o-takashi@sakamocchi.jp


------------------------------------------------------------------------------
