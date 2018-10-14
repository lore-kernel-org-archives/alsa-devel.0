From: Scott Bahling <sbahling@suse.com>
Subject: Re: Controlling the Tascam FW-1884
Date: Sun, 14 Oct 2018 21:09:27 +0200
Message-ID: <58ef33b1fffec178217044e0f0d5f2b6aecfc31d.camel@suse.com>
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
 <97e54edf-1e47-d422-e438-a2c859083fd3@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id CB52426785C
 for <alsa-devel@alsa-project.org>; Sun, 14 Oct 2018 21:09:29 +0200 (CEST)
In-Reply-To: <97e54edf-1e47-d422-e438-a2c859083fd3@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

On Sat, 2018-10-13 at 19:40 +0900, Takashi Sakamoto wrote:

> For FW-1082 these quadlets includes value of movable fader as well,
> however unlike FW-1884 they have fluctuate quirk. So I think it
> reasonable for us to program this module to ignore them.

Ah, understood.

> Instead, let us program applications so that they call
> 'hinawa_snd_tscm_get_status()' periodically to get current value of
> these faders between touch and untouch event on quadlet 05? This
> take applications to consume CPU time more efficiently than handling
> many events.

That should work.

...
> Well, as a result, ALSA firewire-tascam driver handles 'edge-trigge'
> events except for jog wheel and knobs. For this kind of event, it's
> useful to notify before/after value when emitting notification. So I'd
> like to change structure passed to UAPI so that:
> 
>   struct snd_firewire_tascam_control {
>          unsigned int index;
> -       __u32 flags;
> +       __u32 before;
> +       __u32 after;
>   };
> 
> Would I request your opinion? You can see patches here:
>   - 
> https://github.com/takaswie/snd-firewire-improve/tree/topic/tascam-userspace-take3
>   - https://github.com/takaswie/libhinawa/tree/topic/tascam-userspace-take3
> 
> You can receive 'control' event of 'HinawaSndTscm' GObject with these
> two values:
> 
...

Sounds reasonable. For state change detection, I currently store the
"before" state of each control in my application. Your new driver
implementation will mean not needing to maintain my own state
structures for that purpose.

I will try it out in the next few days.

Thanks!

Scott
