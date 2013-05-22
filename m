From: Barry Song <21cnbao@gmail.com>
Subject: Re: [PATCH v4] ASoC: dfbmcs320: make the driver common
	for other BT modules
Date: Wed, 22 May 2013 13:15:26 +0800
Message-ID: <CAGsJ_4x3QrvReOnFQFqRMWfUf-v-Js4+L_Vr8jht_wR-ApQJrg@mail.gmail.com>
References: <1368879900-28395-1-git-send-email-Baohua.Song@csr.com>
 <20130521181849.GG1627@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qe0-f43.google.com (mail-qe0-f43.google.com
 [209.85.128.43])
 by alsa0.perex.cz (Postfix) with ESMTP id 7CDC8261AEE
 for <alsa-devel@alsa-project.org>; Wed, 22 May 2013 07:15:47 +0200 (CEST)
Received: by mail-qe0-f43.google.com with SMTP id k5so902932qej.16
 for <alsa-devel@alsa-project.org>; Tue, 21 May 2013 22:15:46 -0700 (PDT)
In-Reply-To: <20130521181849.GG1627@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, lgirdwood@gmail.com, Workgroup.Linux@csr.com, Graeme Gregory <graeme@openmoko.org>, Barry Song <Baohua.Song@csr.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

2013/5/22 Mark Brown <broonie@kernel.org>:
> On Sat, May 18, 2013 at 08:25:00PM +0800, Barry Song wrote:
>> DFBM-CS320 is only one of bluetooth modules using CSR bluetooth chips,
>> we don't want everyone to have a seperate codec driver. anyway, the
>> feature of Bluetooth SCO is same on all platforms, so this patch
>> makes the DFBM-CS320 driver become a common BT SCO link driver.
>
> Applied, thanks.

thanks, Mark. can we also do something in omap-hdmi to make the HDMI
codec common as well?
i think it is in the same situation with BT SCO:
http://comments.gmane.org/gmane.linux.alsa.devel/108234

-barry
