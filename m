From: "Marco Santamaria" <marco.santamaria@gmail.com>
Subject: Re: snd_usb_caiaq bug?
Date: Thu, 8 Jan 2009 02:34:46 +0100
Message-ID: <31e66c9e0901071734t70c980a8t87f668f973b54635@mail.gmail.com>
References: <31e66c9e0901040829y4bedc1ebgcf91afe10d80341a@mail.gmail.com>
	<s5hprizv0yh.wl%tiwai@suse.de>
	<31e66c9e0901070741i2f6f363l9dc023223954ce2@mail.gmail.com>
	<s5hk597t6pm.wl%tiwai@suse.de>
	<31e66c9e0901071046v36112db7s757788bcf5beaeeb@mail.gmail.com>
	<907c05c70901071206y4bba38bej47f3eba51e6106d3@mail.gmail.com>
	<s5hy6xmhgp3.wl%tiwai@suse.de>
	<31e66c9e0901071659p63219af1wb392f50541cda7a0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f20.google.com (mail-bw0-f20.google.com
	[209.85.218.20])
	by alsa0.perex.cz (Postfix) with ESMTP id 00BA31037E3
	for <alsa-devel@alsa-project.org>; Thu,  8 Jan 2009 02:34:47 +0100 (CET)
Received: by bwz13 with SMTP id 13so22891812bwz.8
	for <alsa-devel@alsa-project.org>; Wed, 07 Jan 2009 17:34:47 -0800 (PST)
In-Reply-To: <31e66c9e0901071659p63219af1wb392f50541cda7a0@mail.gmail.com>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Daniel Mack <daniel@caiaq.de>, Mysth-R <mysthr21@gmail.com>
List-Id: alsa-devel@alsa-project.org

Unfortunately I have to correct my previous message.

After a load test with jack + qsynth + rosegarden (sample rate=88200,
frames/period=256,  periods/buffer=3), using a 16 tracks midi file and a
29MB sound font, the following message appeared:

[ 1098.445807] ALSA
/home/marco/build/linux-2.6.24-19-rt/alsa-1.0.17/driver-patched/alsa-driver-1.0.17/usb/caiaq/../../alsa-kernel/usb/caiaq/caiaq-midi.c:84:
snd-usb-caiaq log: snd_usb_caiaq_midi_send(f64c66c0): usb_submit_urb()
failed, -22

Cheers,
Marco

2009/1/8 Marco Santamaria <marco.santamaria@gmail.com>

> No more errors in dmesg this time. Tomorrow I will apply the patch to the
> latest stable version of the alsa-driver (1.0.18).
>
> Please let me know if there are more tests I can do with JACK, Rosegarden,
> Ardour or something else.
>
> Do you think that this patch will go in the next version of the
> alsa-driver?
>
> Thank you very much for your help,
> Marco
>
>
> 2009/1/7 Takashi Iwai <tiwai@suse.de>
>
>> At Wed, 7 Jan 2009 21:06:23 +0100,
>>
>> Mysth-R wrote:
>> >
>> > Hi Takashi,
>> >
>> > I have almost the same problem as Marco. (that is why Marco forwarded me
>> this
>> > message).
>> >
>> > Well, Now it seems to be almost perfect. Just to explain to you :
>> >
>> > I had a problem with Pure data, each time I wanted to enable the alsa
>> midi (in
>> > pure data). Then I had some problem opening some of my patch, making pd
>> > zombified and Jack output tons of "delay of 1666.000 usecs exceeds
>> estimated
>> > spare time of 1140.000; restart ..." until I stop it and run it again.
>> >
>> > Now pd works perfectly. I made some others jackd settings, and the
>> "xruns"
>> > messages seems to gone away.
>> >
>> > But like Marco I got this message in the output of dmesg :
>> >
>> > [ 20.269196] Adding 530136k swap on /dev/sda3. Priority:-1 extents:1
>> > across:530136k
>> > [ 445.142031] snd-usb-caiaq log:
>> snd_usb_caiaq_midi_send(ffff81007f9380c0):
>> > usb_submit_urb() failed, -22
>> > [ 445.393030] snd-usb-caiaq log:
>> snd_usb_caiaq_midi_send(ffff81007f9380c0):
>> > usb_submit_urb() failed, -22
>> > [ 445.640986] snd-usb-caiaq log:
>> snd_usb_caiaq_midi_send(ffff81007f9380c0):
>> > usb_submit_urb() failed, -22
>> > [ 445.892008] snd-usb-caiaq log:
>> snd_usb_caiaq_midi_send(ffff81007f9380c0):
>> > usb_submit_urb() failed, -22
>> > [ 446.141982] snd-usb-caiaq log:
>> snd_usb_caiaq_midi_send(ffff81007f9380c0):
>> > usb_submit_urb() failed, -22
>> > [ 446.392962] snd-usb-caiaq log:
>> snd_usb_caiaq_midi_send(ffff81007f9380c0):
>> > usb_submit_urb() failed, -22
>> > [ 446.640967] snd-usb-caiaq log:
>> snd_usb_caiaq_midi_send(ffff81007f9380c0):
>> > usb_submit_urb() failed, -22
>> > [ 446.891986] snd-usb-caiaq log:
>> snd_usb_caiaq_midi_send(ffff81007f9380c0):
>> > usb_submit_urb() failed, -22
>>
>> OK, what about this patch?  Now it checks the URB existence before
>> submission.
>>
>>
>> thanks,
>>
>> Takashi
>>
>> ---
>> diff --git a/sound/usb/caiaq/caiaq-device.h
>> b/sound/usb/caiaq/caiaq-device.h
>> index f9fbdba..ab56e73 100644
>> --- a/sound/usb/caiaq/caiaq-device.h
>> +++ b/sound/usb/caiaq/caiaq-device.h
>> @@ -75,6 +75,7 @@ struct snd_usb_caiaqdev {
>>        wait_queue_head_t ep1_wait_queue;
>>        wait_queue_head_t prepare_wait_queue;
>>        int spec_received, audio_parm_answer;
>> +       int midi_out_active;
>>
>>        char vendor_name[CAIAQ_USB_STR_LEN];
>>        char product_name[CAIAQ_USB_STR_LEN];
>> diff --git a/sound/usb/caiaq/caiaq-midi.c b/sound/usb/caiaq/caiaq-midi.c
>> index 30b57f9..6b76f7f 100644
>> --- a/sound/usb/caiaq/caiaq-midi.c
>> +++ b/sound/usb/caiaq/caiaq-midi.c
>> @@ -69,7 +69,8 @@ static void snd_usb_caiaq_midi_send(struct
>> snd_usb_caiaqdev *dev,
>>
>>        dev->midi_out_buf[0] = EP1_CMD_MIDI_WRITE;
>>        dev->midi_out_buf[1] = 0; /* port */
>> -       len = snd_rawmidi_transmit_peek(substream, dev->midi_out_buf+3,
>> EP1_BUFSIZE-3);
>> +       len = snd_rawmidi_transmit(substream, dev->midi_out_buf + 3,
>> +                                  EP1_BUFSIZE - 3);
>>
>>        if (len <= 0)
>>                return;
>> @@ -81,22 +82,21 @@ static void snd_usb_caiaq_midi_send(struct
>> snd_usb_caiaqdev *dev,
>>        if (ret < 0)
>>                log("snd_usb_caiaq_midi_send(%p): usb_submit_urb() failed,
>> %d\n",
>>                                substream, ret);
>> +       else
>> +               dev->midi_out_active = 1;
>>  }
>>
>>  static void snd_usb_caiaq_midi_output_trigger(struct
>> snd_rawmidi_substream *substream, int up)
>>  {
>>        struct snd_usb_caiaqdev *dev = substream->rmidi->private_data;
>>
>> -       if (dev->midi_out_substream != NULL)
>> -               return;
>> -
>> -       if (!up) {
>> +       if (up) {
>> +               dev->midi_out_substream = substream;
>> +               if (!dev->midi_out_active)
>> +                       snd_usb_caiaq_midi_send(dev, substream);
>> +       } else {
>>                dev->midi_out_substream = NULL;
>> -               return;
>>        }
>> -
>> -       dev->midi_out_substream = substream;
>> -       snd_usb_caiaq_midi_send(dev, substream);
>>  }
>>
>>
>> @@ -163,14 +163,13 @@ void snd_usb_caiaq_midi_output_done(struct urb* urb)
>>        struct snd_usb_caiaqdev *dev = urb->context;
>>        char *buf = urb->transfer_buffer;
>>
>> +       dev->midi_out_active = 0;
>>        if (urb->status != 0)
>>                return;
>>
>>        if (!dev->midi_out_substream)
>>                return;
>>
>> -       snd_rawmidi_transmit_ack(dev->midi_out_substream, buf[2]);
>> -       dev->midi_out_substream = NULL;
>>        snd_usb_caiaq_midi_send(dev, dev->midi_out_substream);
>>  }
>>
>>
>
