From: Borislav Petkov <bp@alien8.de>
Subject: Re: Firmware during bootup
Date: Mon, 21 Nov 2011 16:39:47 +0100
Message-ID: <20111121153947.GA8102@x1.osrc.amd.com>
References: <1321542430-17971-1-git-send-email-pdeschrijver@nvidia.com>
 <74CDBE0F657A3D45AFBB94109FB122FF1740D74C1E@HQMAIL01.nvidia.com>
 <20111118120352.GZ19069@tbergstrom-lnx.Nvidia.com>
 <74CDBE0F657A3D45AFBB94109FB122FF1740D74E63@HQMAIL01.nvidia.com>
 <20111121122212.GL19069@tbergstrom-lnx.Nvidia.com>
 <1321889298.1760.8.camel@anish-Inspiron-N5050>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1321889298.1760.8.camel@anish-Inspiron-N5050>
Sender: linux-kernel-owner@vger.kernel.org
To: anish kumar <anish198519851985@gmail.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Nov 22, 2011 at 12:28:18AM +0900, anish kumar wrote:
> Hello Everyone,
> 
> I have a hardware(Noise processing chip) for which I am 
> writing the driver.Is it a good idea to download the 
> firmware in probe function by spawing kthread?I can't download
> the firmware using request_firmware api as this hardware
> is required during bootup for boot-up sound and request_firmware
> is out of question because of no support in user-space.
> 
> Am i missing something?I am bit concerned about boot-up time
> as well.

You could build it into the kernel, see CONFIG_EXTRA_FIRMWARE Kconfig
help for this.

-- 
Regards/Gruss,
   Boris
