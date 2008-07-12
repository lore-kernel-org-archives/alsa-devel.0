From: "Grant Likely" <grant.likely@secretlab.ca>
Subject: Re: [Fwd: Re: [PATCH 2/3] ALSA SoC: Add mpc5200-psc
	I2S driver]
Date: Sat, 12 Jul 2008 10:24:34 -0600
Message-ID: <fa686aa40807120924x2ec5c1dfwa9b38698571a29d6@mail.gmail.com>
References: <1214995877.4882.58.camel@localhost.localdomain>
	<20080712065340.GE23213@secretlab.ca> <1215873096.6634.70.camel@odin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.249])
	by alsa0.perex.cz (Postfix) with ESMTP id C3254103821
	for <alsa-devel@alsa-project.org>;
	Sat, 12 Jul 2008 18:24:35 +0200 (CEST)
Received: by an-out-0708.google.com with SMTP id d31so773164and.80
	for <alsa-devel@alsa-project.org>; Sat, 12 Jul 2008 09:24:34 -0700 (PDT)
In-Reply-To: <1215873096.6634.70.camel@odin>
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
To: Liam Girdwood <lg@opensource.wolfsonmicro.com>, alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Sat, Jul 12, 2008 at 8:31 AM, Liam Girdwood
<lg@opensource.wolfsonmicro.com> wrote:
> On Sat, 2008-07-12 at 00:53 -0600, Grant Likely wrote:
>> On Wed, Jul 02, 2008 at 11:51:17AM +0100, Liam Girdwood wrote:
>
>> >
>> > Fwiw, I usually separate out the DMA from I2S so it can be used by AC97,
>> > PCM interfaces etc. If your hardware only has I2S the it's not required.
>>
>> Agreed.  However, I don't think I have my mind sufficiently wrapped
>> around ASoC yet to split it up without making a royal mess out of it.
>>
>> Would you be okay with merging it without the split?  I know that
>> at least two others people are actively playing with this driver, and
>> it will be easier to collaborate on adding features if it is in
>> mainline.
>>
>
> I've no objections if it's something on your roadmap for the future. I
> suppose the AC97 parts will only be written (and I2S de-merged) when
> mpc5200 AC97 hardware is available.

Oh, absolutely.  It is definitely something on my roadmap.

Thanks,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
