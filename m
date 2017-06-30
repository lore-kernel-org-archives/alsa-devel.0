From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Subject: Re: [PATCH v2] ALSA: x86: fix error return code in
 hdmi_lpe_audio_probe()
Date: Fri, 30 Jun 2017 15:41:30 -0500
Message-ID: <20170630154130.Horde.Tvqi2HI2iHiR3ahhDO2rRKU@gator4166.hostgator.com>
References: <20170630151244.Horde.nPNra38wHbiLkXMM9mTTsxB@gator4166.hostgator.com>
 <20170630201841.GA8057@embeddedgus> <s5hy3s943xj.wl-tiwai@suse.de>
 <20170630153132.Horde.yKnCrx-eIdMDEfUpCJ07mLx@gator4166.hostgator.com>
 <s5hvand43dd.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"; DelSp="Yes"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from gateway20.websitewelcome.com (gateway20.websitewelcome.com
 [192.185.47.18])
 by alsa0.perex.cz (Postfix) with ESMTP id EDFDC267574
 for <alsa-devel@alsa-project.org>; Fri, 30 Jun 2017 22:41:31 +0200 (CEST)
Received: from cm14.websitewelcome.com (cm14.websitewelcome.com [100.42.49.7])
 by gateway20.websitewelcome.com (Postfix) with ESMTP id 75F644017231B
 for <alsa-devel@alsa-project.org>; Fri, 30 Jun 2017 15:41:30 -0500 (CDT)
In-Reply-To: <s5hvand43dd.wl-tiwai@suse.de>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


Quoting Takashi Iwai <tiwai@suse.de>:

> On Fri, 30 Jun 2017 22:31:32 +0200,
> Gustavo A. R. Silva wrote:
>>
>> Hi Takashi,
>>
>> Quoting Takashi Iwai <tiwai@suse.de>:
>>
>> > On Fri, 30 Jun 2017 22:18:41 +0200,
>> > Gustavo A. R. Silva wrote:
>> >>
>> >> Also,
>> >> notice that platform_get_irq() no longer returns 0 on error.
>> >
>> > There is no change by your patch in this regard, right?
>> >
>>
>> You are correct. I just pointing it out. This is the commit that
>> changed the platform_get_irq code:
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e330b9a6bb35dc7097a4f02cb1ae7b6f96df92af
>
> OK, applied now to for-next branch.
> Thanks.
>

Great :)

Thank you
--
Gustavo A. R. Silva
