From: Glenn Golden <gdg@zplane.com>
Subject: Re: [pulseaudio-discuss] ThinkPad T-510 audio output
 mute LED non-workingness
Date: Sat, 16 May 2015 14:32:57 -0600
Message-ID: <20150516203257.GA565@huh.zplane.com>
References: <20150427135859.GI550@huh.zplane.com>
 <s5ha8xt4hsa.wl-tiwai@suse.de>
 <20150428000206.GK550@huh.zplane.com>
 <CAN8ccibSH6je=OpX6vOTG9PzETxikmpuX+7PDgiYNrsG+YavNw@mail.gmail.com>
 <20150502160003.GA557@huh.zplane.com>
 <1430735828.1027589.262340817.33A79FB3@webmail.messagingengine.com>
 <20150504122604.GA577@huh.zplane.com>
 <1430745381.1616962.262389473.6ABEC97F@webmail.messagingengine.com>
 <20150507001557.GH554@huh.zplane.com>
 <5550A70D.20407@canonical.com>
Reply-To: gdg@zplane.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.indra.com (smtp.indra.com [209.169.0.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 0A0FA260715
 for <alsa-devel@alsa-project.org>; Sat, 16 May 2015 22:33:12 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <5550A70D.20407@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: David Henningsson <david.henningsson@canonical.com>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>, Alex Hung <alex.hung@canonical.com>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Raymond Yau <superquad.vortex2@gmail.com>, bruno.mueller@gmail.com
List-Id: alsa-devel@alsa-project.org

David Henningsson <david.henningsson@canonical.com> [2015-05-11 14:56:45 +0200]:
> 
> 
> On 2015-05-07 02:15, Glenn Golden wrote:
> >  8.  ...because [Alsa? Pulseaudio?] maintains two independent mixer mute state
> >      variables -- one for headphone port, one for speaker port -- the semantics
> >      of both the mute key and the mute LED become less straightforward than
> >      with the hardware-based mute in 3.18.
> 
> The mute LED follows the state of ALSA's "Master Playback Switch". When that
> one is off, neither 3.5 mm headphone nor internal speakers have output -
> they're both muted.
> 
> PulseAudio's abstraction layer sets "Master Playback Switch" according to
> its active port's mute state. PulseAudio's active port (here speaker or
> headphone) will, by default, change automatically as headphones are plugged
> in or unplugged.
> 

Thanks, David.  I updated #7 and #8 per your comments above:

 =============================================================================
 7.  If you elect to have the mute key toggle the Master Playback mute via an
     event which invokes pactl/pacmd/amixer/[insert fave mixer control tool]
     then the mute LED will automatically follow the Master Playback mute state
     as mentioned above, thus no explicit action is required to make the LED
     work.  But! ...

 8.  ...if you also use PulseAudio, then the situation becomes a little more
     complicated, because PA maintains two independent mixer mute state
     variables, one for the headphone port, one for the speaker port, and the
     following caveats apply:

       * The mute key (via your userspace mixer control event handler) will
         toggle only the port (HPH or SPKR) that happens to be active at that
         time, and will have no effect on the mute state of the other port.

       * PulseAudio forces the Master Playback mute state to follow the mute
         state of its curently active port, hence...

       * ...the mute LED will likewise follow the mute state of PA's active
         port via kernel auto-synch (as described in (5) above).

     Taken together, these imply that when PulseAudio is in the picture, no
     unequivocal semantic can be attached to "mute LED on", as it was with
     hardware-based mute in 3.18: All you can say is that if the LED is on,
     then PulseAudio's active port is muted via the mixer; the LED gives no
     information about the inactive port's mute state.  One possibly surprising
     consequence of this is that if the ALSA 'auto-mute' feature is enabled,
     then the mute LED may (or may not) change state simply by the action of
     plugging or unplugging the headphones, since doing so automatically
     switches the active port.
 =============================================================================
