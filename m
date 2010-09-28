From: Jeff Chua <jeff.chua.linux@gmail.com>
Subject: Re: Microphone not working on PCI ID 8086:3b56
Date: Tue, 28 Sep 2010 21:33:11 +0800
Message-ID: <AANLkTimHO7OLrr+MN4pYmtOS7gF1qiXGP34Jkien0MpO@mail.gmail.com>
References: <Pine.LNX.4.64.1009150615510.4515@boston.corp.fedex.com>
	<s5htylbxn6b.wl%tiwai@suse.de>
	<AANLkTimXBLM8POjeU6gET7twhV3SVxN0cS99ehLwf7DT@mail.gmail.com>
	<s5haan3hwxi.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 436D624159
	for <alsa-devel@alsa-project.org>;
	Tue, 28 Sep 2010 15:33:13 +0200 (CEST)
Received: by wwb28 with SMTP id 28so6054531wwb.20
	for <alsa-devel@alsa-project.org>; Tue, 28 Sep 2010 06:33:12 -0700 (PDT)
In-Reply-To: <s5haan3hwxi.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Wu Fengguang <fengguang.wu@intel.com>, Linux Kernel <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Tue, Sep 28, 2010 at 2:18 AM, Takashi Iwai <tiwai@suse.de> wrote:
> At Tue, 28 Sep 2010 01:56:44 +0800,
> Jeff Chua wrote:
>>
>> On Mon, Sep 27, 2010 at 10:42 PM, Takashi Iwai <tiwai@suse.de> wrote:
>> > At Wed, 15 Sep 2010 06:32:22 +0800 (SGT),
>> > Did you try to play with model option for snd-hda-intel driver?
>> > For example, model=lenovo-x200 ?
>>
>> Didn't know there's such option. But I'll try it now. Is there an
>> option to if the driver is not compiled as a module?
>
> Yes, you can pass via a boot option like MODULENAME.OPTIONNAME=xxx,yyy,...
> In this case, snd-hda-intel.model=lenovo-x200

Tried, still no mic. Perhaps I'm not using the right driver. Which one
should I enable?

CONFIG_SND_HDA_CODEC_CONEXANT
CONFIG_SND_HDA_CODEC_INTELHDMI
CONFIG_SND_HDA_CODEC_REALTEK


Thanks,
Jeff
