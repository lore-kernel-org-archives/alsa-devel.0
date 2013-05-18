From: Barry Song <21cnbao@gmail.com>
Subject: Re: [PATCH v2] ASoC: dfbmcs320: make the driver common
 for other BT modules
Date: Sat, 18 May 2013 19:03:24 +0800
Message-ID: <CAGsJ_4zjgLhNOiwGcTjvC6dP2XPqnmjzWF12pVPomU-ERH6YYg@mail.gmail.com>
References: <1368757177-15372-1-git-send-email-Baohua.Song@csr.com>
 <20130517111523.GM1627@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qe0-f52.google.com (mail-qe0-f52.google.com
 [209.85.128.52])
 by alsa0.perex.cz (Postfix) with ESMTP id BDE8E260319
 for <alsa-devel@alsa-project.org>; Sat, 18 May 2013 13:03:45 +0200 (CEST)
Received: by mail-qe0-f52.google.com with SMTP id 1so3223735qec.11
 for <alsa-devel@alsa-project.org>; Sat, 18 May 2013 04:03:45 -0700 (PDT)
In-Reply-To: <20130517111523.GM1627@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, lgirdwood@gmail.com, workgroup.linux@csr.com, Graeme Gregory <graeme@openmoko.org>, Barry Song <Baohua.Song@csr.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

2013/5/17 Mark Brown <broonie@kernel.org>:
> On Fri, May 17, 2013 at 10:19:37AM +0800, Barry Song wrote:
>> DFBM-CS320 is only one of bluetooth modules using CSR bluetooth chips,
>> we don't want everyone to have a seperate codec driver. anyway, the
>> feature of Bluetooth handsfree is same on all platforms, so this patch
>> makes the DFBM-CS320 driver become a common BT handsfree driver.
>
> Sorry, should have thought of this before but why are we calling this
> "handsfree"?  It's just a generic bluetooth link as far as the host
> system is concerned, "bt-sco" might be more appropriate?

agree. BT SCO should be more suitable.

>
> Otherwise this looks OK for ASoC though I'd expect to see a change to
> registration of the OpenMoko BT device (perhaps I missed it though).

sorry. i don't understand. i would think OpenMOKO can also use this driver?

-barry
