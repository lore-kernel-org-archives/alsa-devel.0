From: Arun K S <arunks@mistralsolutions.com>
Subject: Re: Please help in adding ams-delta support to ASoC
Date: Fri, 19 Jun 2009 11:55:33 -0700
Message-ID: <df7d0fbb0906191155u75e3c8bdlee26dce267889287__31405.8035066866$1245438058$gmane$org@mail.gmail.com>
References: <4A1BEBE3.8010306@tis.icnet.pl>
	<20090608094028.415e6ec3.jhnikula@gmail.com>
	<4A2E7921.7090200@tis.icnet.pl> <4A364B1A.5040905@tis.icnet.pl>
	<20090615181633.4570426f.jhnikula@gmail.com>
	<4A37AFA9.4080403@tis.icnet.pl>
	<20090618090712.8f8ecd53.jhnikula@gmail.com>
	<4A3A27C8.60005@tis.icnet.pl>
	<df7d0fbb0906182050x1f58da96u9bac334a363bbed0@mail.gmail.com>
	<4A3B7485.5060601@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <4A3B7485.5060601@tis.icnet.pl>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Tony Lindgren <tony@atomide.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Peter Ujfalusi <peter.ujfalusi@nokia.com>, linux-omap@vger.kernel.org, alsa-devel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Fri, Jun 19, 2009 at 4:20 AM, Janusz
Krzysztofik<jkrzyszt@tis.icnet.pl> wrote:
> Tony Lindgren wrote:
>>
>> * Janusz Krzysztofik <jkrzyszt@tis.icnet.pl> [090618 14:52]:
>>>
>>> Tony Lindgren wrote:
>>>>
>>>> On omap1, DSP needs to be powered and idled before some mcbsp clocks c=
an
>>>> be used. Or at least needs to be powered up.
>>>
>>> AFAICS there is no DSP code in mainline at all, so the answer is no, DSP
>>> =A0was likely not powered up at all. For several weeks I was trying to =
do
>>> =A0what was impossible :/. But fortunatelly, I have learned a lot ;).
>>
>> We at least used to have code to power and idle the DSP even without the
>> dspgateway compiled in.. Sorry I don't remember the details. But most
>> likely you need to have the dspgateway patch enabled.
>
> Tony,
> Thanks for clarifying things.
>
> Arun K S wrote:
>>
>> On Thu, Jun 18, 2009 at 4:40 AM, Janusz
>> Krzysztofik<jkrzyszt@tis.icnet.pl> wrote:
>>>
>>> ... I retried the new driver on commit
>>> 90e758af52ba803cba233fabee81176d99589f09 and confirmed the prevoiusly
>>> seen
>>> hangup. I found that it was omap_mcbsp_request() never returning back
>>> from.
>>
>> I faced the same issue while writing ASoC driver for tlv320aic23b codec.
>>
>> You can have a look at this thread:
>> http://www.mail-archive.com/linux-omap@vger.kernel.org/msg03852.html
>>
>> It may help.
>
> Arun,
> Thanks, it's good to hear not only me having this problem ;). So what is =
the
> current status of your osk driver? What tree do you use, what extra patch=
es
> do you apply to make it actually working?

Currently osk driver works fine on 2.6.31. Initially i used to add the
omap_mcbsp_request()
at the boot time, other wise it hangs up. Audio in current mainline
tree works fine for osk5912
with out any such hacks. I believe there are some patches from Russel
for the DSP memory mapping during
2.6.29 kernel.

>
> ---------------------------
>
> After all, could someone please give me an advise, what tree, even with
> buggy omap1510 mcbsp/dsp support, should I base my work on for best resul=
ts?
> Omap? Sound? Mainline? I mean not only easy getting the driver working, b=
ut
> also giving it the best possible path into the mainline.

You have to use current omap tree with the patches from current sound
tree(ASoC omap platform drivers changes) for
testing the driver.
Somebody correct me if i am wrong.

>
> Thanks,
> Janusz
>
