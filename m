From: FF  <lgperson@126.com>
Subject: Re: [PATCH 044/112] ALSA: hda - More generic auto-mic
 switching for Realtek codecs
Date: Thu, 17 Jan 2013 10:47:08 +0800 (CST)
Message-ID: <2bf60376.44d5.13c46671d14.Coremail.lgperson@126.com>
References: <1357645185-7645-1-git-send-email-tiwai@suse.de>
 <1357645185-7645-45-git-send-email-tiwai@suse.de>
 <CAN8ccibLinueHznUv47s3xkF2boDNxB0VRJ1vdEz6KGqvgFf4A@mail.gmail.com>
 <s5h1udt2hyz.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from m15-13.126.com (m15-13.126.com [220.181.15.13])
 by alsa0.perex.cz (Postfix) with ESMTP id 2FE8D264F07
 for <alsa-devel@alsa-project.org>; Thu, 17 Jan 2013 03:47:13 +0100 (CET)
In-Reply-To: <s5h1udt2hyz.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Raymond Yau <superquad.vortex2@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello!
   where is the trace_hda_send_cmd function source code?I can not find it in the path of    alsa-kernel\pci\hda\hda_code.c and linux kenerl.
Thank you!
 

/*
 * Compose a 32bit command word to be sent to the HD-audio controller
 */
static inline unsigned int
make_codec_cmd(struct hda_codec *codec, hda_nid_t nid, int direct,
        unsigned int verb, unsigned int parm)
{
 u32 val;
 if ((codec->addr & ~0xf) || (direct & ~1) || (nid & ~0x7f) ||
     (verb & ~0xfff) || (parm & ~0xffff)) {
  printk(KERN_ERR "hda-codec: out of range cmd %x:%x:%x:%x:%x\n",
         codec->addr, direct, nid, verb, parm);
  return ~0;
 }
 val = (u32)codec->addr << 28;
 val |= (u32)direct << 27;
 val |= (u32)nid << 20;
 val |= verb << 8;
 val |= parm;
 return val;
}
/*
 * Send and receive a verb
 */
static int codec_exec_verb(struct hda_codec *codec, unsigned int cmd,
      unsigned int *res)
{
 struct hda_bus *bus = codec->bus;
 int err;
 if (cmd == ~0)
  return -1;
 if (res)
  *res = -1;
 again:
 snd_hda_power_up(codec);
 mutex_lock(&bus->cmd_mutex);
 trace_hda_send_cmd(codec, cmd);
 err = bus->ops.command(bus, cmd);
 if (!err && res) {
  *res = bus->ops.get_response(bus, codec->addr);
  trace_hda_get_response(codec, *res);
 }
 mutex_unlock(&bus->cmd_mutex);
 snd_hda_power_down(codec);
 if (res && *res == -1 && bus->rirb_error) {
  if (bus->response_reset) {
   snd_printd("hda_codec: resetting BUS due to "
       "fatal communication error\n");
   trace_hda_bus_reset(bus);
   bus->ops.bus_reset(bus);
  }
  goto again;
 }
 /* clear reset-flag when the communication gets recovered */
 if (!err)
  bus->response_reset = 0;
 return err;
}









At 2013-01-10 23:08:52,"Takashi Iwai" <tiwai@suse.de> wrote:
>At Thu, 10 Jan 2013 08:41:13 +0800,
>Raymond Yau wrote:
>> 
>> >
>> > This patch extends the capability of the auto-mic feature.
>> > Instead of limiting the automatic input-source selection only to the
>> > mics (internal, external and dock mics), allow it for generic inputs,
>> > e.g. switching between the rear line-in and the front mic.
>> >
>> > The logic is to check the attribute and location of input pins, and
>> > enable the automatic selection feature only if all such pins are in
>> > different locations (e.g. internal, front, rear, etc) and line-in or
>> > mic pins.  That is, if multiple input pins are assigned to a single
>> > location, the feature isn't enabled because we don't know the
>> > priority.
>> >
>> > (You may wonder why this restriction doesn't exist for the headphone
>> >  automute.  The reason is that the output case is different from the
>> >  input: the input source is an exclusive selection while the output
>> >  can be multiplexed.)
>> >
>> > Note that, for avoiding regressions, the line-in auto switching
>> > feature isn't activated as default.  It has to be set explicitly via
>> > spec->line_in_auto_switch flag in a fixup code.
>> 
>> Is this feature automatically disabled when rear Mic or line in Jack is
>> retasked as output ?
>> 
>> Does it mean that multi channel capture will not be implemented since it is
>> conflict with both dynamic adc  switching and auto Mic selection ?
>
>The recent jack detection codes (at least the code in
>test/hda-gen-parser branch) checks the direction of the pinctl.
>If a multi-io pin is configured as output, the mic autoswitch will
>ignore this pin.  Vice versa for the auto-mute and headphone-as-mic
>case.
>
>
>Takashi
