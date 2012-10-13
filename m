From: Ondrej Zary <linux@rainbow-software.org>
Subject: Re: calling snd_ctl_notify from mixer ctl_put
Date: Sat, 13 Oct 2012 23:23:44 +0200
Message-ID: <201210132323.44951.linux@rainbow-software.org>
References: <201210112129.03097.linux@rainbow-software.org>
 <5077B2A1.5070608@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.atlantis.sk (mail-1-out2.atlantis.sk [80.94.52.71])
 by alsa0.perex.cz (Postfix) with ESMTP id 0487E2616EE
 for <alsa-devel@alsa-project.org>; Sat, 13 Oct 2012 23:24:17 +0200 (CEST)
In-Reply-To: <5077B2A1.5070608@ladisch.de>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Friday 12 October 2012 08:03:13 Clemens Ladisch wrote:
> Ondrej Zary wrote:
> > I want to enable/disable some mixer controls based on state of another
> > control (switching between limiter and AGC mode). So I (re)set the
> > SNDRV_CTL_ELEM_ACCESS_INACTIVE flag in kctl->vd[0].access
> > and then call snd_ctl_notify(card, SNDRV_CTL_EVENT_MASK_INFO, &kctl->id);
> > Everyting from ctl_put() mixer callback.
> >
> > When changing the control value in alsamixer, it crashes with:
> > alsamixer: simple.c:948: snd_mixer_selem_get_enum_item: Assertion
> > `(elem)->type == SND_MIXER_ELEM_SIMPLE' failed.
>
> Looks like a bug in alsamixer.

Thanks. I've now tried some other mixers that are present in Debian and most 
of them are unusable:
alsamixergui: does not understand ENUM controls
gnome-alsamixer: does not understand ENUM controls
gnome-volume-control: crashes like alsamixer
xfce4-mixer: crashes like alsamixer
kmix (TDE 3.5.13): does not update controls when switching limiter/AGC
kmix (KDE 4): crashes like alsamixer
(other mixers won't even run as they seem to be OSS-only)

But there's one that works fine: QasMixer.

-- 
Ondrej Zary
