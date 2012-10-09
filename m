From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: Constant noise on HDA ALC275
Date: Tue, 09 Oct 2012 08:19:56 +0200
Message-ID: <5073C20C.2080603@canonical.com>
References: <87obl7bg02.fsf@dex.adm.naquadah.org>
 <s5hwqzna4pn.wl%tiwai@suse.de> <87haqrijiz.fsf@dex.adm.naquadah.org>
 <s5htxura31x.wl%tiwai@suse.de> <87d31fii3v.fsf@dex.adm.naquadah.org>
 <s5hmx0ja08z.wl%tiwai@suse.de> <874nmried6.fsf@dex.adm.naquadah.org>
 <s5hfw6bpen9.wl%tiwai@suse.de> <87vcf7gyl5.fsf@dex.adm.naquadah.org>
 <s5h6277pdfi.wl%tiwai@suse.de> <87r4pvgxvx.fsf@dex.adm.naquadah.org>
 <87r4pepcgo.fsf@dex.adm.naquadah.org> <s5h1uh9jfxq.wl%tiwai@suse.de>
 <87zk3xku73.fsf@dex.adm.naquadah.org> <s5hwqz1i0y0.wl%tiwai@suse.de>
 <87fw5pktos.fsf@dex.adm.naquadah.org> <s5hr4p9hzw0.wl%tiwai@suse.de>
 <87ehl96ifc.fsf@dex.adm.naquadah.org> <s5h7gr1gc7o.wl%tiwai@suse.de>
 <87ehl86h4l.fsf@dex.adm.naquadah.org> <s5hvcek7oh7.wl%tiwai@suse.de>
 <87zk3wity4.fsf@dex.adm.naquadah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 6455326159D
 for <alsa-devel@alsa-project.org>; Tue,  9 Oct 2012 08:19:58 +0200 (CEST)
In-Reply-To: <87zk3wity4.fsf@dex.adm.naquadah.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Julien Danjou <julien@danjou.info>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 10/08/2012 10:34 PM, Julien Danjou wrote:
>> Hm, then maybe the effect of removing noise appears no matter which
>> input of NID 0x0b be unmuted?
>
> I've retested some, and you're right, it seems some others do make the
> noise disappear:
>
> For example, this works too:
>
> @@ -198,7 +198,7 @@
>     Control: name="Beep Playback Switch", index=0, device=0
>       ControlAmp: chs=3, dir=In, idx=4, ofs=0
>     Amp-In caps: ofs=0x17, nsteps=0x1f, stepsize=0x05, mute=1
> -  Amp-In vals:  [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80]
> +  Amp-In vals:  [0x80 0x80] [0x80 0x80] [0x00 0x00] [0x80 0x80] [0x80 0x80]
>     Connection: 5
>        0x18 0x19 0x1a 0x1b 0x1d
>   Node 0x0c [Audio Mixer] wcaps 0x20010b: Stereo Amp-In
>
>
> This one too:
> @@ -198,7 +198,7 @@
>     Control: name="Beep Playback Switch", index=0, device=0
>       ControlAmp: chs=3, dir=In, idx=4, ofs=0
>     Amp-In caps: ofs=0x17, nsteps=0x1f, stepsize=0x05, mute=1
> -  Amp-In vals:  [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80]
> +  Amp-In vals:  [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x00 0x00] [0x80 0x80]
>     Connection: 5
>        0x18 0x19 0x1a 0x1b 0x1d
>   Node 0x0c [Audio Mixer] wcaps 0x20010b: Stereo Amp-In
>
> Other pairs do not work, but some do change the noise sound.

So; if everything is muted, it causes some codec bug to appear. If this 
only happens in the speaker, maybe we should try to reroute the speaker 
to go 0x02 -> 0x0c -> 0x14 instead of 0x03 -> 0x0d -> 0x14? What will 
happen if you change 0x14 to take its input from 0x0c instead?


-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic
