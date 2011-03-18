From: Jeff Chua <jeff.chua.linux@gmail.com>
Subject: Re: Microphone not working on PCI ID 8086:3b56
Date: Sat, 19 Mar 2011 01:55:10 +0800
Message-ID: <AANLkTinD-8Z-aLwUGArRJ4QPPVhGsEZks-5HCFoC693w@mail.gmail.com>
References: <Pine.LNX.4.64.1009302047410.25061@boston.corp.fedex.com>
	<s5hsk0rtlun.wl%tiwai@suse.de>
	<AANLkTinT3EU3aLSBt5WmA=qDOf1cFABUNG+RiT3Nvx3e@mail.gmail.com>
	<s5h4od7tf43.wl%tiwai@suse.de> <20100930154557.GD11399@localhost>
	<AANLkTinnTeseJY4RDuGNkTjNE--QJ0Mw_S8FVKy_RT7h@mail.gmail.com>
	<20101001021548.GA7115@localhost>
	<AANLkTi=1=jT5LnjjP9uGMx-Q9kM7X6kx5=NeKK6Sa9g8@mail.gmail.com>
	<s5h8w2irzb9.wl%tiwai@suse.de>
	<AANLkTinRVWhsiee=MPZy7VeMg9TVMHH0k+n=pbn3QrBh@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 5EB77103A0F
	for <alsa-devel@alsa-project.org>; Fri, 18 Mar 2011 18:55:12 +0100 (CET)
Received: by wyj26 with SMTP id 26so3749981wyj.38
	for <alsa-devel@alsa-project.org>; Fri, 18 Mar 2011 10:55:11 -0700 (PDT)
In-Reply-To: <AANLkTinRVWhsiee=MPZy7VeMg9TVMHH0k+n=pbn3QrBh@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Wu Fengguang <fengguang.wu@intel.com>, Linux Kernel <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Sat, Oct 2, 2010 at 1:10 AM, Jeff Chua <jeff.chua.linux@gmail.com> wrote:
> On Fri, Oct 1, 2010 at 6:18 PM, Takashi Iwai <tiwai@suse.de> wrote:
>
>>>
>>> Getting closer, but mic still not working.
>>
>> Jeff, give always alsa-info.sh output when you want someone else
>> looking into your HD-audio problem. =A0Without it, it's very hard to
>> follow what is wrong.
>> So, the mic is detected. =A0I guess you didn't set up the capture mixer
>> and else properly.
>
> Attached is the alsa-info output. I used alsamixer to set the Analog
> mic boost to 40db, and I can also see that alsa is detecting the
> external mic when I plug the mic in.
>
> - ALSA sound/pci/hda/patch_conexant.c:2354: CXT5066: external microphone =
absent
> + ALSA sound/pci/hda/patch_conexant.c:2348: CXT5066: external
> microphone detected
> Still no sound.

I just want to update you all now that I finally got the mic to work
on my X201s. It's the settings in the BIOS. Unlike earlier Thinkpad
models, the X201s BIOS has a special setting to enable/disable the
mic.  Bios setup: F1 -> Security -> I/O Ports -> Microphone -> Enable.
Since I trashed Windows on the X201s as soon as I power up the first
time  that could have disabled the mic by default.

Now, it's all working.

Thanks for all you help!

Jeff.
