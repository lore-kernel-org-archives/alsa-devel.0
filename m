From: Grzegorz Chwesewicz <grzegorz.chwesewicz@chilan.com>
Subject: Re: No recording on hda-intel (AD1981HD)
Date: Tue, 12 Feb 2008 18:59:44 +0100
Message-ID: <200802121859.44416.grzegorz.chwesewicz@chilan.com>
References: <200802032017.38614.grzegorz.chwesewicz@chilan.com>
	<681812960802120600p68c4d8f5s16971db6654038b1@mail.gmail.com>
	<s5hve4utgms.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.chilan.com (mail.chilan.com [82.160.213.101])
	by alsa0.perex.cz (Postfix) with ESMTP id 2C369244AA
	for <alsa-devel@alsa-project.org>; Tue, 12 Feb 2008 18:59:55 +0100 (CET)
In-Reply-To: <s5hve4utgms.wl%tiwai@suse.de>
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
To: alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>, chilek@chilan.com
List-Id: alsa-devel@alsa-project.org

Tuesday 12 of February 2008 15:04:59 Takashi Iwai napisa=B3(a):
> At Tue, 12 Feb 2008 16:00:51 +0200,
>
> Ustun ERGENOGLU wrote:
> > I have read the whole thread and I have the same exact problem of
> > recording with a realtek ALC861 codec on a ATI chipset board. My
> > harddisk controller is also using sata_sil module. I have this problem
> > for a long time too. Would the same patch solve the problem for me as
> > well?
>
> Well, the patch does have effect only when you enable MSI.  And, MSI
> is disabled on many ATI chipsets as default unless you patch the
> kernel.  I suggest it just to check whether any unknown IRQs are
> issued or the hardware is just screwed up.
>
> It looks like this is a generic problem of ATI SB chipset.  Which
> model is it?  SB450, SB460 or SB600?

Below are results of my tests with patch from Takashi (and MSI enabled). =


Using arecord everytime ends in freezing machine. My laptop freezes exactly =

when recording stops working. My test procedure looks like this:

1) on one console run arecord and see the output (You should see some garba=
ge)
2) on another console run cat /etc/*
3) wait for freeze ;)

Here is section from /var/log/messages (text in <> can be seen only on =

console, syslog doesn't catch to save it to disk, and machine freezes):

1232171 Feb 12 18:38:15 ensima-hp [   63.888029] ALSA =

sound/pci/hda/hda_intel.c:1258: azx_pcm_prepare: bufsize=3D0x10000, =

fragsize=3D0x2000, format=3D0x21
1232172 Feb 12 18:38:15 ensima-hp [   63.888081] ALSA =

sound/pci/hda/hda_codec.c:682: hda_codec_setup_stream: NID=3D0x4, stream=3D=
0x1, =

channel=3D0, format=3D0x21
1232173 Feb 12 18:38:22 ensima-hp [   70.913893] ALSA =

sound/pci/hda/hda_codec.c:682: hda_codec_setup_stream: NID=3D0x4, stream=3D=
0x0, =

channel=3D0, format=3D0x0
1232174 Feb 12 18:38:27 ensima-hp [   75.885448] ALSA =

sound/pci/hda/hda_intel.c:1258: azx_pcm_prepare: bufsize=3D0x10000, =

fragsize=3D0x2000, format=3D0x21
1232175 Feb 12 18:38:27 ensima-hp [   75.885490] ALSA =

sound/pci/hda/hda_codec.c:682: hda_codec_setup_stream: NID=3D0x4, stream=3D=
0x1, =

channel=3D0, format=3D0x21
####### Recording stops to work and machine freezes #######
<XXX hda-intel: status=3D0>
<XXX hda-intel: status=3D0>
<XXX hda-intel: status=3D0>
<XXX hda-intel: status=3D0>

-- =

Greetings
Grzegorz Chwesewicz, Chilan =

mailto:grzegorz.chwesewicz@chilan.com
