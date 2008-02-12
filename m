From: Matej Laitl <strohel@gmail.com>
Subject: Re: [ALSA] HDA: no sound in headphone-out caused by
	commit f889fa91ad47e (2.6.25-rc1 regression)
Date: Tue, 12 Feb 2008 13:06:08 +0100
Message-ID: <200802121306.08848.strohel@gmail.com>
References: <200802112158.41989.strohel@gmail.com>
	<s5h7ihav3nr.wl%tiwai@suse.de> <s5hzlu6tnl0.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.188])
	by alsa0.perex.cz (Postfix) with ESMTP id 2E332103901
	for <alsa-devel@alsa-project.org>; Tue, 12 Feb 2008 13:06:15 +0100 (CET)
Received: by nf-out-0910.google.com with SMTP id b21so1277408nfd.32
	for <alsa-devel@alsa-project.org>; Tue, 12 Feb 2008 04:06:14 -0800 (PST)
In-Reply-To: <s5hzlu6tnl0.wl%tiwai@suse.de>
Content-Disposition: inline
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
Cc: alsa-devel <alsa-devel@alsa-project.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> I wrote:
> > Thanks. =A0It seems that your device has two headphone jacks according
> > to the BIOS setup, and this seems to be the problem.
> >
> > Could you show the kernel messages like "autoconfig: line_outs..." for
> > both cases? =A0This appears when build with CONFIG_SND_DEBUG=3Dy.
>
> And the patch below may fix your problem. =A0Give it a try.

With your patch, the sound in headphone-out is working again, but surprisin=
gly =

the integrated loudspeakers stopped working! ;)

Also, new on/of control appeared in alsamixer - "Speaker", but unmuting it =

(and unmuting all playback controls, plugging-out headphones) didn't have a=
n =

effect on non-working integrated loudspeakers.

Some kernel mesgs with your patch:
hda_codec: Unknown model for ALC262, trying auto-probe from BIOS...
autoconfig: line_outs=3D1 (0x1b/0x0/0x0/0x0/0x0)
   speaker_outs=3D1 (0x14/0x0/0x0/0x0/0x0)
   hp_outs=3D1 (0x15/0x1b/0x0/0x0/0x0)
   mono: mono_out=3D0x0
   inputs: mic=3D0x18, fmic=3D0x19, line=3D0x0, fline=3D0x0, cd=3D0x0, aux=
=3D0x0

alsa-info.sh output:
http://pastebin.ca/901089

Matej
