From: Gernot Kohlhaas <gernot.kohlhaas@googlemail.com>
Subject: Re: SB X-Fi driver fixes (Re: Testers wanted: New SB
 X-Fi	driver)
Date: Tue, 09 Jun 2009 19:11:02 +0200
Message-ID: <4A2E97A6.3090301@googlemail.com>
References: <1244140942.4550.2.camel@polo-desktop>	<s5hbpp1zpt9.wl%tiwai@suse.de>	<1244376026.6985.5.camel@polo-desktop>	<s5hk53oowhz.wl%tiwai@suse.de>	<s5hbpoz3pbj.wl%tiwai@suse.de>	<4A2D56C7.2090505@googlemail.com>	<s5hws7m7cfd.wl%tiwai@suse.de>	<4A2D7181.3040108@googlemail.com>	<s5h63f6f8qo.wl%tiwai@suse.de>	<4A2DF1EC.9060104@googlemail.com>	<s5hab4ix8wo.wl%tiwai@suse.de>	<4A2DF6BD.6060004@googlemail.com>	<s5h63f5ylee.wl%tiwai@suse.de>
	<s5hk53l3f6p.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f215.google.com (mail-bw0-f215.google.com
	[209.85.218.215])
	by alsa0.perex.cz (Postfix) with ESMTP id E9C01103802
	for <alsa-devel@alsa-project.org>;
	Tue,  9 Jun 2009 19:11:04 +0200 (CEST)
Received: by bwz11 with SMTP id 11so151772bwz.32
	for <alsa-devel@alsa-project.org>; Tue, 09 Jun 2009 10:11:03 -0700 (PDT)
In-Reply-To: <s5hk53l3f6p.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Takashi Iwai schrieb:
>> Hm, please double-check later.  I really don't see any possible cause
>> of this.
Okay... Newest alsa-driver-snapshot - no change. Still got these hiccups
when compiling with --with-debug=full.

>> OK, this implies either a spin deadlock or a dead-end in the irq
>> handler.
>>
>> Anyway, please try the very latest alsa-driver-snapshot.  
Sorry... No luck... It still crashes.

>> If it still
>> doesn't work, let me know whether use_system_timer=1 works around the
>> crash.  
Yes! With use_system_timer everything works fine!

>> If yes, just try to comment out all spin_*() calls in
>> cttimer.c.
Sorry... Still crashes. Only use_system_timer worked so far...

> Also, show your ~/.asoundrc setup so that I can try to reproduce
> the same bug with my test machine.
Here it is:
pcm.xfi
{
        type hw
        card 0
  channels 6
}

ctl.xfi
{
        type hw
        card 0
}

pcm.ch51dup {
         slave.pcm "plug:lowpass51"
         slave.channels 6
         type route
         ttable.0.0 1
         ttable.1.1 1
         ttable.0.2 1
         ttable.1.3 1
         ttable.0.4 0.5
         ttable.1.4 0.5
         ttable.0.5 1
         ttable.1.5 1
}

pcm.lowpass51 {
    type ladspa
    slave.pcm default
    path "/usr/lib/ladspa"
    plugins {
        0 {
            id 1098 # Identity (Audio) (1098/identity_audio)
            policy duplicate
            input.bindings.0 "Input";
            output.bindings.0 "Output";
        }

        1 {
            id 1672
            policy none
            input.bindings.5 "Input";
            output.bindings.5 "Output";
            input {
                controls [ 120 2 ]
            }
        }
    }
}

Thanks!

-- 
http://www.gnupp.de/verschluesselung/warum.html
Key ID: 0x4C0B2250
Key: http://home.arcor.de/mr_maniac/ANDERES/public.gpg
