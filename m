From: =?ISO-8859-1?Q?Andr=E9e_=27Glaucous=27?= <glakke1@gmail.com>
Subject: Re: HDMI LPCM (7.1) with AMD/FGLRX
Date: Tue, 9 Aug 2011 11:37:37 +0200
Message-ID: <CAD=fgeJiB9njYmawo44R8eW96nyxv99G=QptkvP2zO3P+7oBWg@mail.gmail.com>
References: <CAD=fgeJpR6xJbHxmp3EfWa1SOn_dx6ibQ4ffBTdf492UYrR06w@mail.gmail.com>
	<s5haabk9xud.wl%tiwai@suse.de>
	<CAD=fgeLDRisd8V88NL7L8Vfty95kCqaWUDM6onxSPNbd2udwRw@mail.gmail.com>
	<s5hk4aogrhu.wl%tiwai@suse.de>
	<CAD=fgeJrbWs9faGKf_wah7qOLV3juDHSDNtTnhy3XQ2u2WzM4w@mail.gmail.com>
	<s5hmxfkf505.wl%tiwai@suse.de>
	<CAD=fge+x+wPPROTsnOSkwUM+PXKLajYxLczZFhmRqksd25oKJA@mail.gmail.com>
	<s5h39hceyqw.wl%tiwai@suse.de>
	<CAD=fge+v1C9mNU8Bq06HTsY-qmXB76UZkXP3kPyvefrzXEQp8g@mail.gmail.com>
	<CAD=fgeKsQAFTD3m41p7o6AAm9H53On=O4ZOkioCk+CJJQ99RTA@mail.gmail.com>
	<s5h4o1ryrug.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vx0-f179.google.com (mail-vx0-f179.google.com
	[209.85.220.179])
	by alsa0.perex.cz (Postfix) with ESMTP id C32771037EE
	for <alsa-devel@alsa-project.org>;
	Tue,  9 Aug 2011 11:37:38 +0200 (CEST)
Received: by vxh2 with SMTP id 2so3926768vxh.38
	for <alsa-devel@alsa-project.org>; Tue, 09 Aug 2011 02:37:37 -0700 (PDT)
In-Reply-To: <s5h4o1ryrug.wl%tiwai@suse.de>
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

Current kernel message (using alsa-kernel, I'll clone and build your git
soon, got some internet problems at the moment):
[  147.334343] XXX HDMI pin_sense =3D 0x7fffffff
[  147.565059] XXX HDMI pin_sense =3D 0x7fffffff
[  153.248894] XXX HDMI pin_sense =3D 0xffffffff
[  153.250443] XXX HDMI pin_sense =3D 0xffffffff
[  189.475073] XXX HDMI pin_sense =3D 0x7fffffff
[  189.698017] XXX HDMI pin_sense =3D 0x7fffffff
[  196.664565] XXX HDMI pin_sense =3D 0xffffffff
[  196.666079] XXX HDMI pin_sense =3D 0xffffffff

It recognizes when I take the cable in and out, or toggles display output
(0xffffffff when connected).


On 9 August 2011 09:19, Takashi Iwai <tiwai@suse.de> wrote:

> At Tue, 9 Aug 2011 00:13:24 +0200,
> Andr=E9e 'Glaucous' wrote:
> >
> > Okay, after waking up and stopped being stupid, I cloned latest
> alsa-kernel,
>
> Use sound git tree:
>  git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound-2.6.git
>
> > this however still resulted in your patch failing, but I
> > managed to install it manually.
> >
> > I still can't run speaker-test with more than 2 channels.
>
> Give the kernel message.  It should show the raw value.
>
> > (HDMI is card1 now)
> > --
> > /proc/asound/card1/eld#0.0
> > monitor_present 1
> > eld_valid 1
> > monitor_name
> > connection_type HDMI
> > eld_version [0x0] reserved
> > edid_version [0x0] no CEA EDID Timing Extension block present
> > manufacture_id 0x0
> > product_id 0x0
> > port_id 0x0
> > support_hdcp 0
> > support_ai 0
> > audio_sync_delay 0
> > speakers [0xffff] FL/FR LFE FC RL/RR RC FLC/FRC RLC/RRC FLW/FRW FLH/FRH
> TC
> > FCH
> > sad_count 0
>
> So, this means it's likely 0xffffffff or such.
>
> > --
> >
> > Now monitor is present (which I should add, it also was when I updated =
to
> > kernel 3.0 without any alsa patch), and there are many more channels,
> > which is probably because due to your patch hardcoding the channel coun=
t.
>
> No, the speaker configs read above are irrelevant from the channel
> count.
>
>
> Takashi
>
