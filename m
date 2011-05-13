From: Pawel Siemienski <pawel.siemienski@gmail.com>
Subject: Re: Alsa Support for Korg Pandora Mini, Vox ToneLab ST
Date: Fri, 13 May 2011 11:25:09 +0200
Message-ID: <BANLkTint_ZLihv430qmBLQ949=vbceXeRA@mail.gmail.com>
References: <BANLkTikGDzzhXQLTpsHvqqJ=b30JgkumJQ@mail.gmail.com>
	<BANLkTinXgstKju=8-Ow7o542-zZxvKZdTQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pv0-f179.google.com (mail-pv0-f179.google.com
	[74.125.83.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 9DFBF103835
	for <alsa-devel@alsa-project.org>;
	Fri, 13 May 2011 11:25:10 +0200 (CEST)
Received: by pvf33 with SMTP id 33so1269862pvf.38
	for <alsa-devel@alsa-project.org>; Fri, 13 May 2011 02:25:09 -0700 (PDT)
In-Reply-To: <BANLkTinXgstKju=8-Ow7o542-zZxvKZdTQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

Thanks for information.
Sorry for taking your time.
I thought device will be able to work as audio interface because of
following interview from NAMM 2011:
http://www.youtube.com/watch?v=AHlSrLYslbQ

Cheers
Pawel

2011/5/12 Daniel Mack <zonque@gmail.com>

> Hi Pawel,
>
> sorry for the long delay.
>
> On Tue, Apr 19, 2011 at 9:39 AM, Pawel Siemienski
> <pawel.siemienski@gmail.com> wrote:
> > I am Ubuntu Studio user and I use also ALSA for driving my audio for
> > recording etc...
> > I have tested two devices with ALSA:
> > 1. Vox Tonelab ST - works with ALSA out of the box as USB audio interface
> > with no need of modifications, provides complete functionalities needed
> for
> > recording and playing audio
> > 2. Korg Pandora Mini - is detected as audio interface, but when selecting
> it
> > information that no controls are available is displayed, this device can
> not
> > work as audio interface in fact with Alsa.
>
> The "Korg Pandora Mini" is no audio interface, according to both your
> lsusb dump and the Korg website. The device is described as
> "Ultra-compact pocket-size multi-effect designed for both guitar and
> bass "[1] and exposes only a MIDI interface on USB, presumably for
> controlling internal parameters, dumping the configuration etc. It
> specifically not an USB audio interface, and hence it can not be used
> in a way that you wanted to.
>
> HTH,
> Daniel
>
> [1] http://www.korg.com/pandoramini
>
