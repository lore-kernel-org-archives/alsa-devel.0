From: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Subject: Re: [PATCH] RME HDSPM MADI lock fix
Date: Tue, 7 Jun 2011 10:38:48 +0200
Message-ID: <20110607083848.GH17989@ltw.loris.tv>
References: <4DEB5325.9070903@stackingdwarves.net>
	<s5hk4cz1gae.wl%tiwai@suse.de>
	<4DEDE273.9060200@stackingdwarves.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ltw.loris.tv (ltw.loris.tv [85.14.220.160])
	by alsa0.perex.cz (Postfix) with ESMTP id 8DB9B1038ED
	for <alsa-devel@alsa-project.org>;
	Tue,  7 Jun 2011 10:38:56 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4DEDE273.9060200@stackingdwarves.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: =?iso-8859-1?Q?J=F6rn?= Nettingsmeier <nettings@stackingdwarves.net>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Jun 07, 2011 at 10:33:55AM +0200, J=F6rn Nettingsmeier wrote:

> --- linux-2.6.39/sound/pci/rme9652/hdspm.c.orig	2011-05-19 06:06:34.00000=
0000 +0200
> +++ linux-2.6.39/sound/pci/rme9652/hdspm.c	2011-06-07 10:26:35.778933230 =
+0200
> @@ -1639,12 +1639,14 @@
>  		}
>  	}
>  	hmidi->pending =3D 0;
> +	spin_unlock_irqrestore (&hmidi->lock, flags);
>  =

> +	spin_lock_irqsave (&hmidi->hdspm->lock, flags);
>  	hmidi->hdspm->control_register |=3D hmidi->ie;
>  	hdspm_write(hmidi->hdspm, HDSPM_controlRegister,
>  		    hmidi->hdspm->control_register);
> +	spin_unlock_irqrestore (&hmidi->hdspm->lock, flags);
>  =

> -	spin_unlock_irqrestore (&hmidi->lock, flags);
>  	return snd_hdspm_midi_output_write (hmidi);
>  }
>  =



This looks sane to me. I'll add it to my git repo and will re-post it
together with the upcoming changes for the iosono guys once we're
finished.


Cheers

-- =

mail: adi@thur.de  	http://adi.thur.de	PGP/GPG: key via keyserver
