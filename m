From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: [pulseaudio-discuss] ThinkPad T-510 audio output
	mute LED non-workingness
Date: Mon, 11 May 2015 14:56:45 +0200
Message-ID: <5550A70D.20407@canonical.com>
References: <CAN8cciZQBRz2Ty3YRt2+3KO9v1BWef-_8FU_d_SsE87mLdgY-w@mail.gmail.com>
 <s5hh9s2gj45.wl-tiwai@suse.de> <20150427135859.GI550@huh.zplane.com>
 <s5ha8xt4hsa.wl-tiwai@suse.de> <20150428000206.GK550@huh.zplane.com>
 <CAN8ccibSH6je=OpX6vOTG9PzETxikmpuX+7PDgiYNrsG+YavNw@mail.gmail.com>
 <20150502160003.GA557@huh.zplane.com>
 <1430735828.1027589.262340817.33A79FB3@webmail.messagingengine.com>
 <20150504122604.GA577@huh.zplane.com>
 <1430745381.1616962.262389473.6ABEC97F@webmail.messagingengine.com>
 <20150507001557.GH554@huh.zplane.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 45B18261A3D
 for <alsa-devel@alsa-project.org>; Mon, 11 May 2015 14:56:45 +0200 (CEST)
In-Reply-To: <20150507001557.GH554@huh.zplane.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: gdg@zplane.com, Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Raymond Yau <superquad.vortex2@gmail.com>, Takashi Iwai <tiwai@suse.de>, Alex Hung <alex.hung@canonical.com>, bruno.mueller@gmail.com, ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org



On 2015-05-07 02:15, Glenn Golden wrote:
>   8.  ...because [Alsa? Pulseaudio?] maintains two independent mixer mute state
>       variables -- one for headphone port, one for speaker port -- the semantics
>       of both the mute key and the mute LED become less straightforward than
>       with the hardware-based mute in 3.18.

The mute LED follows the state of ALSA's "Master Playback Switch". When 
that one is off, neither 3.5 mm headphone nor internal speakers have 
output - they're both muted.

PulseAudio's abstraction layer sets "Master Playback Switch" according 
to its active port's mute state. PulseAudio's active port (here speaker 
or headphone) will, by default, change automatically as headphones are 
plugged in or unplugged.

-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic
