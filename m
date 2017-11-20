From: Kalle Kankare <kalle.kankare@vincit.com>
Subject: Re: Again about regression introduced by commit 70d435ba1cd6 ("ASoC:
 imx-pcm-dma: simplify pcm_config")
Date: Mon, 20 Nov 2017 12:42:58 +0200
Message-ID: <CAFuYjm7-4SuCP-xkSB53PRCsY8dP7MOdCZwW+f=f2HWKYw7GmQ@mail.gmail.com>
References: <CAFuYjm4vdToNBsurLrDUruwnUTJGpj0qH_1b9+0g9jEmqtkbUg@mail.gmail.com>
 <1510929129.8104.1.camel@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1510929129.8104.1.camel@pengutronix.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Lucas Stach <l.stach@pengutronix.de>
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

2017-11-17 16:32 GMT+02:00 Lucas Stach <l.stach@pengutronix.de>:
> Hi Kalle,
>
> Am Freitag, den 17.11.2017, 16:27 +0200 schrieb Kalle Kankare:
>> Hi,
>>
>> The regression was previously discussed on this mailing list last
>> month (2017-10-04).
>>
>> As in the previous discussion, this commit restricts the supported
>> sound formats to S24_LE. This problem is experienced in our iMX6q
>> based hardware with SGTL5000 sound chip. I.e.:
>>
>> # arecord -l | grep 'card 0' -A2
>> card 0: imx6qba16sgtl50 [imx6q-ba16-sgtl5000], device 0: HiFi
>> sgtl5000-0 []
>>   Subdevices: 1/1
>>   Subdevice #0: subdevice #0
>>
>> In kernel 4.11.0:
>>
>> # arecord --dump-hw-params -D hw:0,0 2>&1 | grep '^FORMAT'
>> FORMAT:  S16_LE
>>
>> And in now in kernel 4.13.3:
>>
>> # arecord --dump-hw-params -D hw:0,0 2>&1 | grep '^FORMAT'
>> FORMAT:  S24_LE
>>
>> By reverting the mentioned commit 70d435ba1cd6, the format returned
>> to S16_LE. However, I'm unsure if that is the proper way to solve
>> this issue. I.e. does reverting the mentioned commit cause some other
>> unwanted effect ?
>>
>> What would be the best solution that would make the S16_LE format
>> supported again for SGTL5000 ?
>
> Please cherry-pick f9d4a398f121 (dmaengine: imx-sdma: Correct
> src_addr_widths and directions) from current Linus mainline tree.
>

Thank you. The commit fixes the issue.

> Regards,
> Lucas
