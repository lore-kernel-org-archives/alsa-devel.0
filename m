From: Jeff Chua <jeff.chua.linux@gmail.com>
Subject: Re: Microphone not working on PCI ID 8086:3b56
Date: Thu, 30 Sep 2010 23:34:44 +0800
Message-ID: <AANLkTi=pdvGeLgcp8+Kwgu-o7BnYJ-ELKfq_8OTHrYqN@mail.gmail.com>
References: <Pine.LNX.4.64.1009302047410.25061@boston.corp.fedex.com>
	<20100930132937.GA5728@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id CADE110381B
	for <alsa-devel@alsa-project.org>;
	Thu, 30 Sep 2010 17:34:44 +0200 (CEST)
Received: by wyb42 with SMTP id 42so2011174wyb.38
	for <alsa-devel@alsa-project.org>; Thu, 30 Sep 2010 08:34:44 -0700 (PDT)
In-Reply-To: <20100930132937.GA5728@localhost>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Wu Fengguang <fengguang.wu@intel.com>
Cc: Takashi Iwai <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Linux Kernel <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Thu, Sep 30, 2010 at 9:29 PM, Wu Fengguang <fengguang.wu@intel.com> wrote:

> Intel HDMI audio selects SND_DYNAMIC_MINORS because it runs out of the
> static minor numbers. I initially proposed an extended static
> allocation scheme here:
> http://comments.gmane.org/gmane.linux.alsa.devel/72916 however the
> idea was rejected.
>
>> Do I really need udev to get mic to work?
>
> You can disable SND_HDA_CODEC_INTELHDMI for now. You don't need it.

Does not make sense to force everyone to use udev. Any chance to make
it work without udev?

Thanks,
Jeff
