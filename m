From: Stephen Warren <swarren@nvidia.com>
Subject: Re: multiple, non-physically accesible,
 HDMI devices listed for Intel IbexPeak ALC269VB
Date: Wed, 22 Feb 2012 16:39:08 -0800
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF17BD8BC877@HQMAIL01.nvidia.com>
References: <CAH=dYrFudvU_CVkz6B7nz3mB8fyOx6HaiaxgukfAjNnW8MOLYw@mail.gmail.com>
	<74CDBE0F657A3D45AFBB94109FB122FF17BD8BC635@HQMAIL01.nvidia.com>
	<20120222215206.GA3517@burratino>
	<CAH=dYrGuG0WfBFAMVmJdT28pckZ3TXutRq61-K++ui5VXSr+YQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hqemgate03.nvidia.com (hqemgate03.nvidia.com [216.228.121.140])
	by alsa0.perex.cz (Postfix) with ESMTP id 6C095103FEA
	for <alsa-devel@alsa-project.org>; Thu, 23 Feb 2012 01:39:22 +0100 (CET)
In-Reply-To: <CAH=dYrGuG0WfBFAMVmJdT28pckZ3TXutRq61-K++ui5VXSr+YQ@mail.gmail.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Andres Cimmarusti <acimmarusti@gmail.com>, Jonathan Nieder <jrnieder@gmail.com>
Cc: "tiwai@suse.de" <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "660111@bugs.debian.org" <660111@bugs.debian.org>, "David Henningsson (david.henningsson@canonical.com)" <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

Andres Cimmarusti wrote at Wednesday, February 22, 2012 5:02 PM:
> First of all, thank you for your feedback. It's been quite helpful / insightful
...
> > There are ways to configure pulseaudio to allow the user to select which
> > PCM device to use on a given sound card. David Henningsson made this work
> > for NVIDIA GPUs at least in Ubuntu, and I imagine the same technique
> > could be applied to Intel devices too.
> 
> Mmm.. just in Ubuntu? was this work submitted upstream? It appears
> there are some related fixes shown in the Ubuntu pulseaudio changelog:

I think the following Ubuntu bug covers the patch:

https://bugs.launchpad.net/ubuntu/+source/pulseaudio/+bug/716371
See the patch in comment #2.

Hopefully David will chime in on upstreaming status etc.

The following might be interesting; at least some of it will apply to
non-NVIDIA graphics cards:

ftp://download.nvidia.com/XFree86/gpu-hdmi-audio-document/gpu-hdmi-audio.html

-- 
nvpublic
