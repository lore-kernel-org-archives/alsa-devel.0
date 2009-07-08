From: VDR User <user.vdr@gmail.com>
Subject: Re: Problems with snd-hda-intel and Asus M2NPV-VM.
	Please help!
Date: Wed, 8 Jul 2009 06:47:03 -0700
Message-ID: <a3ef07920907080647x16160ab2u52b0f9eac2f8d5f6@mail.gmail.com>
References: <a3ef07920906241108u786a6c89j80f2ad89eebf7dcd@mail.gmail.com>
	<a3ef07920906241134m2f84ac06pef7465ce356f893f@mail.gmail.com>
	<s5hvdmfv6s6.wl%tiwai@suse.de>
	<a3ef07920906291028q670ed146t1451650d0c2a4713@mail.gmail.com>
	<s5hzlbq83o8.wl%tiwai@suse.de>
	<a3ef07920906301030p7f84d4c4xe6c0590f436b4de9@mail.gmail.com>
	<s5heit1bjki.wl%tiwai@suse.de>
	<a3ef07920907010726o6e06dd8dn25b33d4ee5b6c42c@mail.gmail.com>
	<a3ef07920907060844o50d8be15s16bc1bca8acf72b6@mail.gmail.com>
	<75b66ecd0907071914n5e29c83co168b6b0ca91357f5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vw0-f189.google.com (mail-vw0-f189.google.com
	[209.85.212.189])
	by alsa0.perex.cz (Postfix) with ESMTP id B603B103899
	for <alsa-devel@alsa-project.org>;
	Wed,  8 Jul 2009 15:47:08 +0200 (CEST)
Received: by vwj27 with SMTP id 27so4023642vwj.16
	for <alsa-devel@alsa-project.org>; Wed, 08 Jul 2009 06:47:04 -0700 (PDT)
In-Reply-To: <75b66ecd0907071914n5e29c83co168b6b0ca91357f5@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Lee Revell <rlrevell@joe-job.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Jul 7, 2009 at 7:14 PM, Lee Revell<rlrevell@joe-job.com> wrote:
> On Mon, Jul 6, 2009 at 11:44 AM, VDR User<user.vdr@gmail.com> wrote:
>>> My mainboard doesn't have HDMI out but it did come with an HDTV module
>>> for HDTV output, could it still be that something in my xorg.conf is
>>> missing that is causing this not to work? =A0How can I tell (or could
>>> you tell by my logs) if the codec registers are good? =A0I'm not sure
>>> how to proceed from here aside of buying a new mainboard.
>>
>> Anyone? =A0Any suggestions at all?
>
> This probably cannot work in a headless environment. =A0Thanks to DRM,
> the video driver has to do some magic to make HDMI work.
>
> I assume your video card is Nvidia. =A0Even though you plan to run
> headless you probably have to set up X server with proprietary nvidia
> driver to have any chance of this working.

As I've said, my mainboard doesn't have HDMI, it has DVI.  But I'm not
using the on-board video anyway.  I've got an Nvidia video card
capable of vdpau which has SPDIF_IN so I'm going from the SPDIF_OUT on
the mainboard into that. It's true that I have to have Xorg set up but
that's all.  No desktop/windows manager.  The only software the box
has installed is: Xorg, lirc, VDR, mplayer-nogui, Nvidia video drivers
(of course!), xine-lib + vdr-xine.  I have another box running the
same setup (different mainboard though, where spdif IS working) and it
runs great.

The problem isn't what I'm trying to do, I already know the setup
works fine.  The problem is that alsa is broken for the chipset
(AD1989a) on that mainboard since the exact same setup works on a
different mainboard/chipset (ALC883).
