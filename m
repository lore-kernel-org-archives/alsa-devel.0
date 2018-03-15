From: "Wischer, Timo (ADITG/ESB)" <twischer@de.adit-jv.com>
Subject: Re: [PATCH - JACK 1/1] jack: Use internal
 snd_pcm_state to reduce amount of additional variables
Date: Thu, 15 Mar 2018 14:05:39 +0000
Message-ID: <B0FB33DC1499054591F62C0EF1E013D7684FDC82@HI2EXCH01.adit-jv.com>
References: <s5hefl3izpf.wl-tiwai@suse.de>
 <1521118587-6319-1-git-send-email-twischer@de.adit-jv.com>
 <1521118587-6319-2-git-send-email-twischer@de.adit-jv.com>,
 <s5hpo457a75.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp1.de.adit-jv.com (smtp1.de.adit-jv.com [62.225.105.245])
 by alsa0.perex.cz (Postfix) with ESMTP id 6DB75267252
 for <alsa-devel@alsa-project.org>; Thu, 15 Mar 2018 15:05:50 +0100 (CET)
In-Reply-To: <s5hpo457a75.wl-tiwai@suse.de>
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
To: Takashi Iwai <tiwai@suse.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hello Takashi,

> Well, the fact that the state change is done for PREPARE before the
> plugin callback can be seen as a generic bug of ioplug.  The best
> would be to fix in ioplug side.

This change could possibly brake other existing IO plugins.
Do you think we should really change it?


> For RUNNING, instead of keeping an internal shadow state, a saner way
> would be to have a jack->running bool flag indicating whether it's
> really running.

With the following pending commits [1] and [2] we would than have 3 additio=
nal variables to indicate
- running
- xruns
- draining

My idea was to avoid this variables and use the already existing snd_pcm_st=
ate enum.

With further commits which I have not yet sent I want to make the JACK plug=
in thread save.
But instead of using locking I am using atomic lock-less access (to avoid b=
locking of the JACK daemon).
Therefore I cannot call snd_pcm_state() to get the internal state.
I have to forward the status by my own to the JACK thread.
Due to that I need an internal variable which will be atomically accessed a=
nd represents the state.
(I think it is not intended by ALSA to extend the ALSA library to update th=
e internal ALSA state atomically
so that it can be read atomically from any thread. Therefore I have not yet=
 another idea how to transfer the state to the JACK thread with atomic lock=
-less access.)

I could replace the assignments to the internal state in all IO plug callba=
ck functions in the JACK plugin with
jack->state =3D io->state
But I am not sure if this is really helpful for the understanding.

[1] http://mailman.alsa-project.org/pipermail/alsa-devel/2018-March/132725.=
html
[2] http://mailman.alsa-project.org/pipermail/alsa-devel/2018-March/132726.=
html

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

________________________________________
From: Takashi Iwai [tiwai@suse.de]
Sent: Thursday, March 15, 2018 2:14 PM
To: Wischer, Timo (ADITG/ESB)
Cc: alsa-devel@alsa-project.org
Subject: Re: [PATCH - JACK 1/1] jack: Use internal snd_pcm_state to reduce =
amount of additional variables

On Thu, 15 Mar 2018 13:56:27 +0100,
<twischer@de.adit-jv.com> wrote:
>
> From: Timo Wischer <twischer@de.adit-jv.com>
>
> This variable will be used to exchange the status of the stream between
> the ALSA and JACK thread. In future commits it will also be used to signal
> DRAINING state from the ALSA to JACK thread and to signal XRUN state form
> the JACK to ALSA thread.
>
> Therefore this internal state variable is not always in sync with
> io->state. In addition the internal state variable will be updated after
> the corresponding callback function was processed and not before the
> callback function was called (e.g. PREPARE and RUNNING).

Well, the fact that the state change is done for PREPARE before the
plugin callback can be seen as a generic bug of ioplug.  The best
would be to fix in ioplug side.

And, the rest is RUNNING state.  Is there anything else?
For RUNNING, instead of keeping an internal shadow state, a saner way
would be to have a jack->running bool flag indicating whether it's
really running.


thanks,

Takashi
