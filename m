From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: am57xx-evm: linux-4.14.y b8b55f8fd937 build Failure
Date: Sat, 5 Jan 2019 15:30:25 +0100
Message-ID: <20190105143025.GA21624@kroah.com>
References: <CA+G9fYsMFCa8hpcVPnfGt_HJdPn3CMM2HGig=D6xov+MtPPU0A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CA+G9fYsMFCa8hpcVPnfGt_HJdPn3CMM2HGig=D6xov+MtPPU0A@mail.gmail.com>
Sender: stable-owner@vger.kernel.org
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: alsa-devel@alsa-project.org, perex@perex.cz, tiwai@suse.com, kailang@realtek.com, hui.wang@canonical.com, linux- stable <stable@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Sat, Jan 05, 2019 at 05:42:21PM +0530, Naresh Kamboju wrote:
> Build failure log of arm - BeagleBoard-X15 board while make modules
> 
> Git branch: linux-4.14.y
> Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
> Git commit: b8b55f8fd937348f867eb0e4098b6d658959d075
> 
> In file included from sound/pci/hda/patch_realtek.c:33:0:
> sound/pci/hda/patch_realtek.c:6381:48: error: 'ALC294_FIXUP_ASUS_SPK'
> undeclared here (not in a function); did you mean
> 'ALC256_FIXUP_ASUS_MIC'?
>   SND_PCI_QUIRK(0x1043, 0x10a1, "ASUS UX391UA", ALC294_FIXUP_ASUS_SPK),
>                                                 ^
> include/sound/core.h:415:43: note: in definition of macro 'SND_PCI_QUIRK'
>   {_SND_PCI_QUIRK_ID(vend, dev), .value = (val)}
>                                            ^~~
>   CC [M]  drivers/cpufreq/highbank-cpufreq.o
> scripts/Makefile.build:326: recipe for target
> 'sound/pci/hda/patch_realtek.o' failed
> make[5]: *** [sound/pci/hda/patch_realtek.o] Error 1

My fault, I added a patch I shouldn't have.  Will push out an updated
-rc tree in a few hours, thanks.

greg k-h
