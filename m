From: Denis Kuzmenko <linux@solonet.org.ua>
Subject: Re: Firmware during bootup
Date: Mon, 21 Nov 2011 20:01:34 +0200
Message-ID: <4ECA91FE.7010200@solonet.org.ua>
References: <1321542430-17971-1-git-send-email-pdeschrijver@nvidia.com> <74CDBE0F657A3D45AFBB94109FB122FF1740D74C1E@HQMAIL01.nvidia.com> <20111118120352.GZ19069@tbergstrom-lnx.Nvidia.com> <74CDBE0F657A3D45AFBB94109FB122FF1740D74E63@HQMAIL01.nvidia.com> <20111121122212.GL19069@tbergstrom-lnx.Nvidia.com> <1321889298.1760.8.camel@anish-Inspiron-N5050> <20111121153947.GA8102@x1.osrc.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20111121153947.GA8102@x1.osrc.amd.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>, anish kumar <anish198519851985@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 11/21/2011 05:39 PM, Borislav Petkov wrote:
> On Tue, Nov 22, 2011 at 12:28:18AM +0900, anish kumar wrote:
>> Hello Everyone,
>>
>> I have a hardware(Noise processing chip) for which I am 
>> writing the driver.Is it a good idea to download the 
>> firmware in probe function by spawing kthread?I can't download
>> the firmware using request_firmware api as this hardware
>> is required during bootup for boot-up sound and request_firmware
>> is out of question because of no support in user-space.
>>
>> Am i missing something?I am bit concerned about boot-up time
>> as well.
> 
> You could build it into the kernel, see CONFIG_EXTRA_FIRMWARE Kconfig
> help for this.
> 

You can also put it into intramfs and use usual request_firmware call.

-- 
Best regards, Denis Kuzmenko.
