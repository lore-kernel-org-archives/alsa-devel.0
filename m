From: James Courtier-Dutton <james.dutton@gmail.com>
Subject: Re: RFC: PCM extra attributes
Date: Fri, 19 Jun 2009 12:58:21 +0100
Message-ID: <ad2655cb0906190458x4852f6b7m46b8df170d3921eb@mail.gmail.com>
References: <s5hiqiseiwj.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f226.google.com (mail-fx0-f226.google.com
	[209.85.220.226])
	by alsa0.perex.cz (Postfix) with ESMTP id 7808410381B
	for <alsa-devel@alsa-project.org>;
	Fri, 19 Jun 2009 13:58:21 +0200 (CEST)
Received: by fxm26 with SMTP id 26so1064061fxm.32
	for <alsa-devel@alsa-project.org>; Fri, 19 Jun 2009 04:58:21 -0700 (PDT)
In-Reply-To: <s5hiqiseiwj.wl%tiwai@suse.de>
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

2009/6/19 Takashi Iwai <tiwai@suse.de>:
> Hi,
>
> this is yet another topic I'm (currently) working on -- the addition
> of PCM ioctls to get/set some extra attributes. =A0Basically, it adds
> two simple ioctls for getting/setting extra attributes to the PCM
> substream. =A0The attribute has a sort of TLV form,
>

How is the association done between the pcm and the control?
I would have thought an easy approach could be (from userland):
snd_pcm_open( snd_pcm_t **handle, ...);
snd_pcm_get_attr( handle, int attribute_id, *attributeX );
snd_pcm_set_attr( handle, int attribute_id, *attributeX );

I.e Use the snd_pcm_t handle from the snd_pcm_open call to query and
set any controls associated with the pcm. We could then remove those
controls from being viewable in alsamixer and leave it to the
application to control them.
The only controls left in alsamixer would then be the global controls.
E.g. Speaker arrangement, master gain control etc.
The result being that applications would never need to access the
alsamixer controls, and instead only need to use the
snd_pcm_get/set_attr interface on a per PCM basis that is much more in
line with what applications actually need.

>An important note is that I'm planning to use this framework for
>getting/setting the PCM (surround) channel mapping.
Why would we want this channel mapping info in user space?
Can't we just standardize on a single channel mapping as seen from
user space, and get the driver to do any adaption if needed?

Kind Regards

James
