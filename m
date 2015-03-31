From: Nikolay Dimitrov <picmaster@mail.bg>
Subject: Re: Speaker burnout
Date: Tue, 31 Mar 2015 14:23:53 +0300
Message-ID: <551A83C9.1070106@mail.bg>
References: <1427551386.3092172.246393281.691C33A7@webmail.messagingengine.com>
 <5518F8F3.10304@ladisch.de>
 <1427711234.231499.246955417.6E2E7C65@webmail.messagingengine.com>
 <55192FBC.1070307@ladisch.de>
 <1427726222.1872206.247049189.3E3BB0F7@webmail.messagingengine.com>
 <551A6A15.1070605@canonical.com>
 <1427796392.581386.247465613.43178C71@webmail.messagingengine.com>
 <551A7A4D.203@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.mail.bg (mx2.mail.bg [193.201.172.118])
 by alsa0.perex.cz (Postfix) with ESMTP id C446D2617A5
 for <alsa-devel@alsa-project.org>; Tue, 31 Mar 2015 13:24:00 +0200 (CEST)
In-Reply-To: <551A7A4D.203@canonical.com>
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
Cc: Takashi Iwai <tiwai@suse.de>, Clemens Ladisch <clemens@ladisch.de>, alsa-devel@alsa-project.org, "Nikita N." <nikitan@operamail.com>
List-Id: alsa-devel@alsa-project.org

Hi David,

On 03/31/2015 01:43 PM, David Henningsson wrote:
>
>
> On 2015-03-31 12:06, Nikita N. wrote:
>>> If you have any concrete examples (alsa-info please!) of speakers
>>> that can be burned out, and you know a maximum speaker volume
>>> where this
>> As we said, that is not our bug, we are not audio experts, nor any
>> of us is interested in audio matters.
>
> Here's my suggestion how to move forward on this:
>
> 1) Gather consensus that limit the maximum volume on internal
> speakers is the right way forward. Takashi, Clemens, anyone against
> that strategy?
>
> 2) From the person with the hardware, we will need alsa-info (
> https://wiki.ubuntu.com/Audio/AlsaInfo ), and also the max volume
> where this does not happen. Is -6 dB good enough? -12 dB? I don't
> know - this is something someone with the hardware must tell us, it
> cannot simply be guessed.
>
> 3) I or someone else can write a kernel patch that limits the maximum
>  volume of the speakers to the amount deducted from point 2).
> Considering that we're actually dealing with hardware breakage, this
> should be sent to stable as well. Then no userspace application can
> set the volume higher than our limit.

Probably a kernel patch is not necessary. asound.conf ans asound.state
can do similar job. If the master volume is fixed to a safe value, the
audio can be routed through softvol plugin, which can be used as a
replacement for the master volume control (the exact levels need to be
confirmed with someone who has access to the problematic hardware).

state.Intel {
	control.1 {
		comment.access 'read'  // read-only
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 64'
		comment.dbmin -6400
		comment.dbmax 0
		iface MIXER
		name 'Speaker Playback Volume'
		value.0 42  // safe volume levels
		value.1 42  //
	}
}

Could be even better if the HW master volume control is hidden (I don't
know how to do this), and the softvol control is exposes as master volume:

pcm.!default {
     type            softvol
     slave.pcm       "default"
     control.name    "Master Volume"
     control.card    0
}

...something like this.

Kind regards,
Nikolay
