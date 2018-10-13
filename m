From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: Controlling the Tascam FW-1884
Date: Sat, 13 Oct 2018 19:40:24 +0900
Message-ID: <97e54edf-1e47-d422-e438-a2c859083fd3@sakamocchi.jp>
References: <9cec059e1ff1a558f21a3f0729c5a69a3d506573.camel@suse.com>
 <0e469670-0520-5953-230b-8d2da5e4c357@sakamocchi.jp>
 <985b1f6dc5b0af2aae049e0b6fcf976ab400d34d.camel@suse.com>
 <55afba82-ad24-fe70-b784-d28a38e291c9@sakamocchi.jp>
 <7a0f35eea26ce475bc3f6953db97f83205ad0a58.camel@suse.com>
 <fc278639-12da-02b8-685d-681e06b044e4@sakamocchi.jp>
 <10a99ea9c672ac6d0c9d5536e9d85a15f5a32d95.camel@suse.com>
 <47f66c7d-4337-52da-72da-cdb3f0638dc4@sakamocchi.jp>
 <d63527a1ab830c50c621664946ad9eafdb37d578.camel@suse.com>
 <f4537970-775e-6480-acc4-6b5dd050d597@sakamocchi.jp>
 <fed5ab3a-c39a-4de9-6802-c064a33140eb@sakamocchi.jp>
 <246b8baaa3c415a0accdb76d3b524dec5e0429f9.camel@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com
 [209.85.214.180])
 by alsa0.perex.cz (Postfix) with ESMTP id 4D303267783
 for <alsa-devel@alsa-project.org>; Sat, 13 Oct 2018 12:40:29 +0200 (CEST)
Received: by mail-pl1-f180.google.com with SMTP id f8-v6so7097144plb.2
 for <alsa-devel@alsa-project.org>; Sat, 13 Oct 2018 03:40:28 -0700 (PDT)
In-Reply-To: <246b8baaa3c415a0accdb76d3b524dec5e0429f9.camel@suse.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Scott Bahling <sbahling@suse.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

Hi Scott,

On Oct 12 2018 17:12, Scott Bahling wrote:
> I have tested the branches and it works well. I was able to create
> daemon in python to interface the FW-1884 with Ardour via the OSC
> protocol. That's working reliably.

Good to hear ;)

> I had to enable quadlets 00-04 since they contain the fader control
> values. I masked out the solo control values in the same way as the
> monitor control values since they continuously fluctuate in the same
> way.

For FW-1082 these quadlets includes value of movable fader as well,
however unlike FW-1884 they have fluctuate quirk. So I think it
reasonable for us to program this module to ignore them.

Instead, let us program applications so that they call
'hinawa_snd_tscm_get_status()' periodically to get current value of
these faders between touch and untouch event on quadlet 05? This
take applications to consume CPU time more efficiently than handling
many events.

> While testing, noticed that the encoder bits on quadlet 06 do not get
> updated reliably if the encoder knob is moved quickly. The transitions
> on those bits happen quickly and some of the bit state changes get
> lost. I switched to using the absolute encoder values on quadlets 10-15
> which works reliably.

Yep. We need to ignore some bits in quadlet 06 and 08 for value of the
knobs.


Well, as a result, ALSA firewire-tascam driver handles 'edge-trigge'
events except for jog wheel and knobs. For this kind of event, it's
useful to notify before/after value when emitting notification. So I'd
like to change structure passed to UAPI so that:

  struct snd_firewire_tascam_control {
         unsigned int index;
-       __u32 flags;
+       __u32 before;
+       __u32 after;
  };

Would I request your opinion? You can see patches here:
  - 
https://github.com/takaswie/snd-firewire-improve/tree/topic/tascam-userspace-take3
  - https://github.com/takaswie/libhinawa/tree/topic/tascam-userspace-take3

You can receive 'control' event of 'HinawaSndTscm' GObject with these
two values:

```
def handle_control(self, index, before, after):
     print('{0:02d}: {1:08x} -> {2:08x}, {3:08x}'.format(index, before, 
after, after ^ before))
```

idx before      after     XOR
09: ffffffff -> 7fffffff, 80000000
09: 7fffffff -> ffffffff, 80000000
06: ffffffff -> ff7fffff, 00800000
06: ff7fffff -> ffffffff, 00800000
07: ffffffff -> ffffff7f, 00000080
07: ffffff7f -> ffffffff, 00000080
10: 00000000 -> 00000001, 00000001 (knob)
10: 00000001 -> 00000002, 00000003 (knob)
15: 003f000c -> 003f000b, 00000007 (jog wheel)
15: 003f000b -> 003f000a, 00000001 (job wheel)
14: 00100005 -> 00110005, 00010000 (knob)
09: ffffffff -> fffffbff, 00000400
09: fffffbff -> ffffffff, 00000400
05: 01ff00a6 -> 017f00a6, 00800000
05: 017f00a6 -> 01ff00a6, 00800000


Thanks

Takashi Sakamoto
