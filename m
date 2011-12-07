From: Andrey Tataranovich <tataranovich@gmail.com>
Subject: Re: Support for GT440 HDMI audio
Date: Wed, 7 Dec 2011 15:59:56 +0300
Message-ID: <20111207125956.GD2128@debbox.it>
References: <20111206132918.GC2128@debbox.it>
	<74CDBE0F657A3D45AFBB94109FB122FF1750B7734F@HQMAIL01.nvidia.com>
Reply-To: Andrey Tataranovich <tataranovich@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
	[209.85.215.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 506E92433E
	for <alsa-devel@alsa-project.org>; Wed,  7 Dec 2011 13:59:24 +0100 (CET)
Received: by eaai13 with SMTP id i13so401308eaa.38
	for <alsa-devel@alsa-project.org>; Wed, 07 Dec 2011 04:59:23 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF1750B7734F@HQMAIL01.nvidia.com>
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

08:30 Tue 06 Dec    , Stephen Warren wrote:
> Andrey Tataranovich wrote at Tuesday, December 06, 2011 6:29 AM:
> >  Please include following patch to add support for NVidia GT440 HDMI audio.
> > This patch working for me on Debian Squeeze with patched alsa-source 1.0.23-dfsg+4.
> 
> > @@ -556,6 +556,8 @@ static struct hda_codec_preset snd_hda_p
> ...
> > +	{ .id = 0x10de0014, .name = "GT440 HDMI",
> > +	  .patch = patch_nvhdmi_8ch_89 },
> 
> That entry is already included in the latest driver; your patch was
> created against quite an old driver.

  Can I control volume level on this card? Now I adjust volume with TV remote.

-- 
WBR, Andrey Tataranovich
