From: "Andrew Paprocki" <andrew@ishiboo.com>
Subject: Re: Embedded I2S / 192khz
Date: Sat, 10 May 2008 14:15:33 -0400
Message-ID: <76366b180805101115o3f057d49j7fb78ef53bd04d10@mail.gmail.com>
References: <76366b180805080650p615851afi272602115ca1660a@mail.gmail.com>
	<20080508140856.GC23041@sirena.org.uk>
	<1210256561.20475.16.camel@odin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rv-out-0708.google.com (rv-out-0708.google.com [209.85.198.245])
	by alsa0.perex.cz (Postfix) with ESMTP id EE7B824493
	for <alsa-devel@alsa-project.org>;
	Sat, 10 May 2008 20:15:35 +0200 (CEST)
Received: by rv-out-0708.google.com with SMTP id f25so1592673rvb.32
	for <alsa-devel@alsa-project.org>; Sat, 10 May 2008 11:15:34 -0700 (PDT)
In-Reply-To: <1210256561.20475.16.camel@odin>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lg@opensource.wolfsonmicro.com>
Cc: ALSA development <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Has anyone heard of this BridgeCo DM850 chip? It seems powerful, but
I'm not sure if there is any ALSA support from the company.. from the
datasheet:

"There are up to four Audio I/O ports, each with four I2S/I8S
interfaces operating at up to 192 kHz in both I2S and I8S
modes.

There are up to eight SPDIF interfaces operating at up to
192 kHz."

http://www.bridgeco.com/pdfs/850/adp_dm850_02_pma_chip-overv.pdf

-Andrew

On Thu, May 8, 2008 at 10:22 AM, Liam Girdwood
<lg@opensource.wolfsonmicro.com> wrote:
> On Thu, 2008-05-08 at 15:08 +0100, Mark Brown wrote:
>> On Thu, May 08, 2008 at 09:50:32AM -0400, Andrew Paprocki wrote:
>>
>> > Is anyone aware of a Linux/ALSA capable chip that can drive 192khz
>> > I2S? I poked through the ASoC code and could only see 96khz
>> > capability.
>>
>> The PowerPC code in sound/soc/fsl (as of 2.6.25) supports up to 192kHz,
>> though it appears to require the codec to clock the bus.  The SuperH and
>> Alchemy code in:
>>
>>    git://opensource.wolfsonmicro.com/linux-2.6-asoc
>>
>> says they support up to 192kHz too.  PXA3xx should support this too when
>> it's done.
>
> heh, shows how much attention I've been paying lately to commits.
>
> PX2xx (SSP) and i.MX3x (SSI) should also do 192kHz too. Interestingly
> pxa2xx I2S almost manages (datasheet max is 48kHz) 192kHz but underruns
> a bit!
>
>
