From: Oliver Neukum <oneukum@suse.de>
Subject: Re: question on snd_power_change_state()
Date: Fri, 11 Mar 2011 13:20:46 +0100
Message-ID: <201103111320.46750.oneukum@suse.de>
References: <201103111312.17360.oneukum@suse.de> <s5hr5adkg4f.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	by alsa0.perex.cz (Postfix) with ESMTP id 0A2A1244B8
	for <alsa-devel@alsa-project.org>; Fri, 11 Mar 2011 13:20:21 +0100 (CET)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.221.2])
	by mx2.suse.de (Postfix) with ESMTP id CEF355FC9F
	for <alsa-devel@alsa-project.org>; Fri, 11 Mar 2011 13:20:20 +0100 (CET)
In-Reply-To: <s5hr5adkg4f.wl%tiwai@suse.de>
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

Am Freitag, 11. M=E4rz 2011, 13:15:28 schrieb Takashi Iwai:
> At Fri, 11 Mar 2011 13:12:17 +0100,
> Oliver Neukum wrote:
> > =

> > Hi,
> > =

> > will calling snd_power_change_state() reset all mixer settings?
> =

> No, it's a simple inline function defined in include/sound/core.h.
> =

> static inline void snd_power_change_state(struct snd_card *card, unsigned=
 int state)
> {
> 	card->power_state =3D state;
> 	wake_up(&card->power_sleep);
> }
> =

> It's present mostly for historical reasons.

Is there a helper that will do that?

	Regards
		Oliver
