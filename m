From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Verifying mixer dB data/Invalid dB data from USB
	cards, especially Aureon 5.1 MkII
Date: Tue, 23 Feb 2010 20:46:28 +0800
Message-ID: <4f3252891002230446g3fa96521yf51290e058473b94@mail.gmail.com>
References: <20100216233825.GB23623@sirena.org.uk>
	<20100218023742.GC23637@tango.0pointer.de>
	<4f3252891002172215j7b85313ci3626a1bdad5c040c@mail.gmail.com>
	<20100218181322.GB5606@tango.0pointer.de>
	<alpine.LNX.2.00.1002190916410.28127@eeebox2.perex-int.cz>
	<4f3252891002190257u608073c3l48f2251d8a6458ee@mail.gmail.com>
	<20100219151328.GC25873@tango.0pointer.de>
	<4f3252891002202001gb6df8cg6c023c52e7d8394a@mail.gmail.com>
	<20100221192951.GD30380@tango.0pointer.de>
	<4B83A912.1050501@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pw0-f51.google.com (mail-pw0-f51.google.com
	[209.85.160.51])
	by alsa0.perex.cz (Postfix) with ESMTP id ABD5710387E
	for <alsa-devel@alsa-project.org>; Tue, 23 Feb 2010 13:46:29 +0100 (CET)
Received: by pwi9 with SMTP id 9so3266018pwi.38
	for <alsa-devel@alsa-project.org>; Tue, 23 Feb 2010 04:46:28 -0800 (PST)
In-Reply-To: <4B83A912.1050501@ladisch.de>
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

2010/2/23 Clemens Ladisch <clemens@ladisch.de>

> Lennart Poettering wrote:
> > On Sun, 21.02.10 12:01, Raymond Yau (superquad.vortex2@gmail.com) wrote:
> > > However Simple Mixer API cannot know the subdevice number , you have to
> use
> > > control API ( the lower level API used by Simple Mixer API )
> >
> > Unfortunately there is no way from the simple mixer to the lower level
> > mixer.
>
> From the check_unplugged function in alsa-utils/alsamixer/mixer_widget.c:
>
>        err = snd_mixer_get_hctl(mixer, mixer_device_name, &hctl);
>        if (err >= 0)
>                ctl = snd_hctl_ctl(hctl);
>
> > It would be great if the smixer would include some API that gives me a
> > hint to which device/subdevice a specific snd_mixer_elem_t belongs to.
>
> Often, there is no 1:1 correspondence between mixer elements and PCM
> devices.  Only mixer controls with interface PCM (not MIXER) have (sub-)
> device numbers, and at the moment this is used only for controls that
> are associated with the streams of hardware-mixing-capable cards.
>
> Getting information about the mixer layout (like the nodes reported by
> HDA and USB devices) is on the TODO list; the only reason it isn't being
> implemented is lack of time.
>
>
> Regards,
> Clemens
>
>

for hda , Since PA server open pcm device , so it still can use

snd_mixer_selem_id_set_index(sid, snd_pcm_info_get_subdevice(pcm_info));

pavucontrol still can query PA server to get the sudevice numer
whenever PA resum from suspend

But gnome volume control has no way to know which application open
which subdevice
