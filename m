From: "Wischer, Timo (ADITG/ESB)" <twischer@de.adit-jv.com>
Subject: Re: [PATCH - JACK plugin 4/4] jack: Support
 snd_pcm_drain()
Date: Fri, 16 Mar 2018 15:52:31 +0000
Message-ID: <B0FB33DC1499054591F62C0EF1E013D7684FDF04@HI2EXCH01.adit-jv.com>
References: <s5hd10qyg05.wl-tiwai@suse.de>
 <1519910048-19732-1-git-send-email-twischer@de.adit-jv.com>
 <1519910048-19732-5-git-send-email-twischer@de.adit-jv.com>
 <3f0f0873-9544-050d-ef69-35d4b23e8c6c@perex.cz>
 <B0FB33DC1499054591F62C0EF1E013D7684FDEA1@HI2EXCH01.adit-jv.com>,
 <07334145-d1f1-54b4-84d0-eacbea0a3987@perex.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp1.de.adit-jv.com (smtp1.de.adit-jv.com [62.225.105.245])
 by alsa0.perex.cz (Postfix) with ESMTP id C467E2670A1
 for <alsa-devel@alsa-project.org>; Fri, 16 Mar 2018 16:52:44 +0100 (CET)
In-Reply-To: <07334145-d1f1-54b4-84d0-eacbea0a3987@perex.cz>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi Jaroslav,

> But it changes the PCM API behaviour, so some apps might have trouble
> with it, because it might cause the unexpected task blocking. The
> correct behaviour is return with -EAGAIN

I have checked all IO plugins (pulse, oss, a52, jack) only a52 could return=
 -EAGAIN.
oss and pulse do always block and it seems that they are not updating the f=
ile descriptor in case of draining.
Therefore snd_pcm_wait() would block infinitely.

I think an application developer would not expect that he has to call snd_p=
cm_drop() after snd_pcm_drain().
Therefore snd_pcm_drop has to be called internally.
(On a real hardware it will be handled in the kernel)

Therefore I think snd_pcm_drop() has to be called from snd_pcm_wait() befor=
e returning.
But snd_pcm_wait callback is not available in the IO plug API.
Therefore I think we have to call snd_pcm_drop() from snd_pcm_ioplug_poll_r=
events().
But this looks a little bit ugly for me.
Do you have another idea?

One approach could be the following
snd_pcm_ioplug_poll_revents()
{
	...
	if (draining)
		snd_pcm_drop()
}

snd_pcm_ioplug_drain()
{
	int err =3D 0
	if (io->data->callback->drain)
		err =3D io->data->callback->drain(io->data);
	if (err !=3D -EAGAIN) {
		snd_pcm_lock(pcm);
		err =3D snd_pcm_ioplug_drop(pcm);
		snd_pcm_unlock(pcm);
	}
	return err;
}

But I am not aware of if this would brake any of the existing IO plugins.
I would prefer to avoid these changes.

Best regards

Timo Wischer

Advanced Driver Information Technology GmbH
Engineering Software Base (ADITG/ESB)
Robert-Bosch-Str. 200
31139 Hildesheim
Germany

Tel. +49 5121 49 6938
Fax +49 5121 49 6999
twischer@de.adit-jv.com

ADIT is a joint venture company of Robert Bosch GmbH/Robert Bosch Car Multi=
media GmbH and DENSO Corporation
Sitz: Hildesheim, Registergericht: Amtsgericht Hildesheim HRB 3438
Gesch=E4ftsf=FChrung: Wilhelm Grabow, Ken Yaguchi
