From: Arun K S <arunks@mistralsolutions.com>
Subject: Re: Please help in adding ams-delta support to ASoC
Date: Thu, 18 Jun 2009 20:50:06 -0700
Message-ID: <df7d0fbb0906182050x1f58da96u9bac334a363bbed0__45768.7503578656$1245383427$gmane$org@mail.gmail.com>
References: <4A1BEBE3.8010306@tis.icnet.pl>
	<20090605165531.7d0c4522.jhnikula@gmail.com>
	<200906060028.01600.jkrzyszt@tis.icnet.pl>
	<20090608094028.415e6ec3.jhnikula@gmail.com>
	<4A2E7921.7090200@tis.icnet.pl> <4A364B1A.5040905@tis.icnet.pl>
	<20090615181633.4570426f.jhnikula@gmail.com>
	<4A37AFA9.4080403@tis.icnet.pl>
	<20090618090712.8f8ecd53.jhnikula@gmail.com>
	<4A3A27C8.60005@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <4A3A27C8.60005@tis.icnet.pl>
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
Cc: linux-omap@vger.kernel.org, alsa-devel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Thu, Jun 18, 2009 at 4:40 AM, Janusz
Krzysztofik<jkrzyszt@tis.icnet.pl> wrote:
> Jarkko Nikula wrote:
>>
>> Hmm, recall, did you try hacking the ASoC driver at the same commit
>> d8376cc482b241701f7606c81ad578b90853e175 where older driver still
>> exists and works? There has been ASoC OMAP fixes and changes since
>> then but nothing which can explain why it doesn't work now for 1510.
>>
>> There we would know that clock framework, register access etc. works for
>> McBSP on 1510.
>
> Yes, after realizing that possible lack of OMAP1510 McBSP1/3 / DSP support
> in the mainline tree could be the reason of my problem, I got back to omap
> tree. First I retried the new driver on commit
> 90e758af52ba803cba233fabee81176d99589f09 and confirmed the prevoiusly seen
> hangup. I found that it was omap_mcbsp_request() never returning back fro=
m.

I faced the same issue while writing ASoC driver for tlv320aic23b codec.

You can have a look at this thread:
http://www.mail-archive.com/linux-omap@vger.kernel.org/msg03852.html

It may help.

>
> Then I retired the same on the commit
> d8376cc482b241701f7606c81ad578b90853e175 and got similiar hangup. Next, I
> moved mcbsp initialization to a boot time hook and finally heard a sound =
and
> got my first DMA interrupt!
>
> So it seams I have finally managed to take all necessary steps back, and =
now
> I can go forward, I hope :).
>
> Thanks,
> Janusz
> --
> To unsubscribe from this list: send the line "unsubscribe alsa-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
