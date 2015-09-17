From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Subject: Re: Applied "ASoC: fsl-asoc-card: add AC'97 support"
 to the asoc tree
Date: Thu, 17 Sep 2015 20:48:24 +0200
Message-ID: <55FB0AF8.3020207@maciej.szmigiero.name>
References: <E1ZcItt-0007vf-Ba@finisterre>
 <20150917074148.GA62898@Asurada-CZ80> <20150917103709.GA12027@sirena.org.uk>
 <20150917180231.GC2544@Asurada-CZ80>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from vps-vb.mhejs.net (vi37-28-154-113.vibiznes.pl [37.28.154.113])
 by alsa0.perex.cz (Postfix) with ESMTP id 0FCB9261B19
 for <alsa-devel@alsa-project.org>; Thu, 17 Sep 2015 20:48:34 +0200 (CEST)
In-Reply-To: <20150917180231.GC2544@Asurada-CZ80>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nicolin Chen <nicoleotsuka@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Nicolin,

On 17.09.2015 20:02, Nicolin Chen wrote:
> On Thu, Sep 17, 2015 at 11:37:09AM +0100, Mark Brown wrote:
>> On Thu, Sep 17, 2015 at 12:41:49AM -0700, Nicolin Chen wrote:
>>
>>> This patch breaks my previous function:
>>> [    2.020415] wm8962 3-001a: customer id 0 revision D
>>> [    2.076388] fsl-asoc-card sound: failed to find codec platform device
>>> [    2.086166] fsl-asoc-card: probe of sound failed with error -22
>>
>>> It's actually weird that I didn't see the patch in my mailbox at all
>>> (I searched for it in my Gmail just now) as I found that Maciej put
>>> me in the CC list: http://www.spinics.net/lists/kernel/msg2066060.html
>>
>>> Is it possible for you to revert it provisionally?
>>
>> OK, done.
> 
> Thank you
> 
> @Maciej
> 
> Is it possible for you to fix the issue and send a v2? The problem
> should be related to the codec_pdev and codec_i2c_dev in your patch
> as the driver use codec_i2c_dev to fetch the device not codec_pdev.

Thanks for catching it.

Yes, I will send updated patch tomorrow.

Best regards,
Maciej Szmigiero
