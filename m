From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: multiple, non-physically accesible,
 HDMI devices listed for Intel IbexPeak ALC269VB
Date: Wed, 22 Feb 2012 15:52:06 -0600
Message-ID: <20120222215206.GA3517@burratino>
References: <CAH=dYrFudvU_CVkz6B7nz3mB8fyOx6HaiaxgukfAjNnW8MOLYw@mail.gmail.com>
	<74CDBE0F657A3D45AFBB94109FB122FF17BD8BC635@HQMAIL01.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-iy0-f179.google.com (mail-iy0-f179.google.com
	[209.85.210.179])
	by alsa0.perex.cz (Postfix) with ESMTP id F354A103ED6
	for <alsa-devel@alsa-project.org>; Wed, 22 Feb 2012 22:52:15 +0100 (CET)
Received: by iabz21 with SMTP id z21so657378iab.38
	for <alsa-devel@alsa-project.org>; Wed, 22 Feb 2012 13:52:13 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF17BD8BC635@HQMAIL01.nvidia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Stephen Warren <swarren@nvidia.com>
Cc: "tiwai@suse.de" <tiwai@suse.de>, Andres Cimmarusti <acimmarusti@gmail.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "660111@bugs.debian.org" <660111@bugs.debian.org>, "David Henningsson (david.henningsson@canonical.com)" <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

Stephen Warren wrote:

> As Takashi mentions, from a kernel perspective, this isn't really a
> regression at all, but simply exposing all the features of the HW that
> were previously hidden. Without that change, others can't use some HW
> usefully at all. Unfortunately, pulseaudio makes some rather simplistic
> assumptions about how HW works by default, and can be confused by the
> additional features that are exposed.

>From a distro perspective, it's a regression that happens to be
bundled with a feature.  Though from a distro perspective working
around this in pulseaudio and making sure even old releases get the
fix might be okay.

I thought that "no regressions" meant that the first sentence and not
the second sentence of the previous paragraph apply from a kernel
perspective.  No?  So I would be happiest if there is some way to
teach the kernel about this quirk until everyone already has had a
fixed pulseaudio for a year or two.

Jonathan
