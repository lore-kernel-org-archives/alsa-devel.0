From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Problem with VIA VT1708S and git versions of
	alsa-driver.
Date: Mon, 11 Oct 2010 07:09:08 +0800
Message-ID: <AANLkTimcAUn=+1B3=LJbD7dBBZ3NvaeX_q+_sHP6QhB3@mail.gmail.com>
References: <AANLkTikaYCybUxW7dE3tizYZztT8pVo6Jeg-mh=e0NqZ@mail.gmail.com>
	<AANLkTi=UTy8tdLqL-90UJOXtU=Ks1+ZZrGV2nCbw=xjD@mail.gmail.com>
	<AANLkTinYcRqMwH2FSUjXiOxZg4x09q673FL9m15YvXEa@mail.gmail.com>
	<AANLkTik8HayTEADWn74PJ0NgjGunamsSAZpy_GanuZo3@mail.gmail.com>
	<AANLkTimz3iiXPhEarEUY1Gw5GxrTuv+UXgKKZS3ObzuS@mail.gmail.com>
	<AANLkTi=S20cpKy-CObvKB-OLDKbQ7FBhFrbnd448B+sO@mail.gmail.com>
	<AANLkTikyjZvD+ptCcgBrN2av-jQmKWOekbzvfXYAdpOV@mail.gmail.com>
	<AANLkTim_A5m2MryxmkEHtcc3gNFWTaRW8J3=dZC6wd67@mail.gmail.com>
	<AANLkTinUWD9Oq2iAbn_nc5E+M=y4yXx4u0Eff9jYSGyk@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com
	[209.85.215.51]) by alsa0.perex.cz (Postfix) with ESMTP id B559C2432F
	for <alsa-devel@alsa-project.org>;
	Mon, 11 Oct 2010 01:09:08 +0200 (CEST)
Received: by ewy9 with SMTP id 9so13949ewy.38
	for <alsa-devel@alsa-project.org>; Sun, 10 Oct 2010 16:09:08 -0700 (PDT)
In-Reply-To: <AANLkTinUWD9Oq2iAbn_nc5E+M=y4yXx4u0Eff9jYSGyk@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2010/10/11 Mark Goldstein <goldstein.mark@gmail.com>

> I noticed one visible change: Input Source had "Rear Mic" instead of "Mic".
>
>
spec->private_imux[1] is un-initialised before calling create_hp_imux()
however there is no node with connection list which can be used as input mix
for "independent HP" control

How about "Mic Boost" ?

if "Mic" is changed to "Rear Mic" , "Mic Boost Capture Volume" should also
be changed to "Rear Mic Boost Capture Volume "


static struct snd_kcontrol_new vt1708S_capture_mixer[] = {

         HDA_CODEC_VOLUME("Capture Volume", 0x13, 0x0, HDA_INPUT),
         HDA_CODEC_MUTE("Capture Switch", 0x13, 0x0, HDA_INPUT),
         HDA_CODEC_VOLUME_IDX("Capture Volume", 1, 0x14, 0x0, HDA_INPUT),
         HDA_CODEC_MUTE_IDX("Capture Switch", 1, 0x14, 0x0, HDA_INPUT),
         HDA_CODEC_VOLUME("Mic Boost Capture Volume", 0x1A, 0x0, HDA_INPUT),
         HDA_CODEC_VOLUME("Front Mic Boost Capture Volume", 0x1E, 0x0,
                          HDA_INPUT),
