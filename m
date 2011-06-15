From: Stephen Warren <swarren@nvidia.com>
Subject: Re: Need Help About Submitting Updates to Existing
 ASoC Codec Driver [Re Post]
Date: Wed, 15 Jun 2011 08:57:02 -0700
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF04992C0569@HQMAIL01.nvidia.com>
References: <F56EA673D3E56E48804FE2B0D23EFD2D22FD94CFDE@KCINPUNHJCMS01.kpit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hqemgate04.nvidia.com (hqemgate04.nvidia.com [216.228.121.35])
	by alsa0.perex.cz (Postfix) with ESMTP id 1B58F2490A
	for <alsa-devel@alsa-project.org>;
	Wed, 15 Jun 2011 17:57:06 +0200 (CEST)
In-Reply-To: <F56EA673D3E56E48804FE2B0D23EFD2D22FD94CFDE@KCINPUNHJCMS01.kpit.com>
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
To: "Ashish P. Chavan" <Ashish.Chavan@kpitcummins.com>, "'alsa-devel@alsa-project.org'" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Ashish P. Chavan wrote at Tuesday, June 14, 2011 11:46 PM:
> Hi,
>    We are in the process of upgrading codec driver for Dialog's DA7210 codec
> (sound/soc/codecs/da7210.c). Existing driver in mainline is just bare minimum
> and doesn't support many of the chip's features. Our update would be a major
> functionality update in nature.
> 
> Our final goal is to get the updated driver merged into mainline kernel.
> For this we just want to make sure that we follow correct process. As far as I
> understood from alsa-project.org and other resources, the normal process is to
> submit the patch against alsa-kenel (git.alsa-project.org:alsa-kernel.git alsa-kernel)
> and get it reviewed by maintainers there. Once all maintainers are satisfied
> with the patch, it will be eventually put in to for-linus branch and get
> in to mainline.

For ASoC drivers specifically, you'll probably want to work off the
following git repository:

git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git

and in particular, branch for-3.1.

Yes, you'll want to post your changes to the mailing list, explicitly
CC'ing the maintainers of the ASoC subsystem (Mark and Liam; see the
MAINTAINERS file in the root of the kernel source tree).

Once the change is approved, Mark will check it into his repository.
Later, the overall ALSA maintainers will pull those changes into their
repository, and from there will be merged into Linus' mainline kernel
during the next merge window.

Good background reading can be found in the kernel source tree in the
Documentation/ directory:

SubmittingPatches
SubmitChecklist
development-process/*

-- 
nvpublic
