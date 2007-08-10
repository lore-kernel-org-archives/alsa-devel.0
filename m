From: "John L. Utz III" <john.utz@dmx.com>
Subject: Re: Where is simple mixer control "Surround" defined
 for ac97 or via82xx? I cant find it anywhere in ac97....
Date: Fri, 10 Aug 2007 10:56:26 -0700
Message-ID: <20070810105626.2e8a7166@jutz-fc6.na.corp.dmxmusic.com>
References: <20070808150429.45d1abef@jutz-fc6.na.corp.dmxmusic.com>
	<1186731226.23948.1204693671@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.dmxmusic.com (mail.dmxmusic.com [199.201.237.35])
	by alsa0.perex.cz (Postfix) with ESMTP id BC1E424393
	for <alsa-devel@alsa-project.org>;
	Fri, 10 Aug 2007 19:52:03 +0200 (CEST)
In-Reply-To: <1186731226.23948.1204693671@webmail.messagingengine.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <cladisch@fastmail.net>
Cc: ALSA devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Tnx Clemens!

On Fri, 10 Aug 2007 09:33:46 +0200
"Clemens Ladisch" <cladisch@fastmail.net> wrote:

> John L. Utz III wrote:
> > amixer controls | grep Surround
> > numid=20,iface=MIXER,name='Surround Playback Switch'
> > numid=21,iface=MIXER,name='Surround Playback Volume'
> > 
> > But for the life of me, i cant find the code that implements it!
> 
> Around line 1350 in ac97_codec.c:
> 
> 	/* build surround controls */
> 	if ((snd_ac97_try_volume_mix(ac97, AC97_SURROUND_MASTER))
> 		&& !(ac97->flags & AC97_AD_MULTI)) {
> 		/* Surround Master (0x38) is with stereo mutes */
> 		if ((err = snd_ac97_cmix_new_stereo(card, "Surround
> Playback", AC97_SURROUND_MASTER, 1, 0,
> 						    ac97)) < 0)
> 			return err;
> 	}
> 
> HTH

It does, i think that i'll try to use snd_ac97_rename_vol_ctl() in
patch_vt1618() to make Surround the Rear control.

Hopefully, i'll have a usable patch to submit for vt1618 next week,
woohoo!

> Clemens
> 
