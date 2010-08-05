From: "Sebastian H." <vand2@gmx.de>
Subject: Re: Alsamixer-Qt4 0.4.0 released
Date: Thu, 05 Aug 2010 14:48:36 +0200
Message-ID: <4C5AB324.2020006@gmx.de>
References: <4C595A52.7030401@gmx.de>
	<AANLkTim=OvWfYgvRLvGgELg5AiJPYZk0snkEHSxxdcaC@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gmx.net (mailout-de.gmx.net [213.165.64.23])
	by alsa0.perex.cz (Postfix) with SMTP id 8EDE31038D7
	for <alsa-devel@alsa-project.org>;
	Thu,  5 Aug 2010 14:47:31 +0200 (CEST)
In-Reply-To: <AANLkTim=OvWfYgvRLvGgELg5AiJPYZk0snkEHSxxdcaC@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello Raymond

>> I've been working on Alsamixer-Qt4 lately and compiled
>> the changes into a new release version 0.4.0.
> 
> 1) au8830 Equalizer
> you can find the screenshot of the equalizer ( gnome volume control) and the
> correct implementation of the equalizer of the vortexcontrol and python
> version of the equalizer
> 
> the asound.state of au8830
> 
> https://bugtrack.alsa-project.org/alsa-bug/view.php?id=3678

Ok, I tried to figure out how this relates to alsamixer-qt4 (since I
don't have the sound card).

Please correct me if I'm wrong.

The "EQ Peaks" Simple Mixer Element has more channels than the 9
channels described in the snd_mixer_selem_channel_id_t enum.
( SND_MIXER_SCHN_FRONT_LEFT up to SND_MIXER_SCHN_REAR_CENTER ).

http://www.alsa-project.org/alsa-doc/alsa-lib/group___simple_mixer.html#g9cb8437b2f92d168c43e4da2c667e823

Alsamixer-Qt4 currently can only show these 9 channels - in the channels
mixer dialog - which is not sufficient.

I did not find a function like snd_mixer_selem_playback_channels
which would return the number of channels.
So to find out how many channels there actually are I would have to do
something like this

int num_playback = 0;
for ( int ii=0; ii < 1024; ++ii ) {
	if ( snd_mixer_selem_has_playback_channel ( elem, ii ) ) {
		num_playback += 1;
	} else {
		break;
	}
}



> 2) CMI8788 's 8 Channels Master Volume Control
> 
> https://bugtrack.alsa-project.org/alsa-bug/view.php?id=4204
> 
> Card hw:0 'CMI8788'/'C-Media Oxygen HD Audio (rev 2) at 0xec00, irq 17'
> 
>   Mixer name	: 'CMI8788'
>   Components	: 'AK4396 AK5385 CMI8788'
>   Controls      : 23
>   Simple ctrls  : 12
> Simple mixer control 'Master',0
>   Capabilities: pvolume pswitch pswitch-joined
>   Playback channels: Front Left - Front Right - Rear Left - Rear Right
> - Front Center - Woofer - Side Left - Side Right
>   Limits: Playback 0 - 255
>   Mono:
>   Front Left: Playback 112 [44%] [-7.14dB] [on]
>   Front Right: Playback 112 [44%] [-7.14dB] [on]
>   Rear Left: Playback 178 [70%] [-3.12dB] [on]
>   Rear Right: Playback 178 [70%] [-3.12dB] [on]
>   Front Center: Playback 178 [70%] [-3.12dB] [on]
>   Woofer: Playback 178 [70%] [-3.12dB] [on]
>   Side Left: Playback 178 [70%] [-3.12dB] [on]
>   Side Right: Playback 178 [70%] [-3.12dB] [on]
> 
> 
> state.CMI8788 {
> 	control.1 {
> 		comment.access 'read write'
> 		comment.type INTEGER
> 		comment.count 8
> 		comment.range '0 - 255'
> 		comment.dbmin -9999999
> 		comment.dbmax 0
> 		iface MIXER
> 		name 'Master Playback Volume'
> 		value.0 112
> 		value.1 112
> 		value.2 178
> 		value.3 178
> 		value.4 178
> 		value.5 178
> 		value.6 178
> 		value.7 178
> 	}

Basically the same issue?

Best,
Sebastian
