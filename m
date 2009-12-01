From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: testing mic-in for tlv320aic33
Date: Tue, 1 Dec 2009 10:09:04 +0200
Message-ID: <20091201100904.b4f8f036.jhnikula@gmail.com>
References: <1932e3c30911301059s23ad8110rd5f106d44d331f71@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f217.google.com (mail-bw0-f217.google.com
	[209.85.218.217])
	by alsa0.perex.cz (Postfix) with ESMTP id 7AF421037FC
	for <alsa-devel@alsa-project.org>; Tue,  1 Dec 2009 09:08:00 +0100 (CET)
Received: by bwz9 with SMTP id 9so10097874bwz.32
	for <alsa-devel@alsa-project.org>; Tue, 01 Dec 2009 00:07:59 -0800 (PST)
In-Reply-To: <1932e3c30911301059s23ad8110rd5f106d44d331f71@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: vivek kaushik <vic.techlist@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi

On Tue, 1 Dec 2009 00:29:53 +0530
vivek kaushik <vic.techlist@gmail.com> wrote:

> Hi All,
> 
> I am testing MIC IN on tlv320aic33. but getting the following error:
> arecord: pcm_read:1338: read error: Input/output error
> 
> On my custom board tlv320aic33 is connected mcbsp-1 of omap3530, i am
> configuring tlv as mater and omap3530 as slave.aplay is working fine for me
> but getting the above error in case of arecord.
> 
> I am testing MIC IN with following command
> 
> arecord -fdat record.wav
> 
> when i probe signals I am getting proper MCLK, WCLK(48khz) and BCLK(1.5Mhz)
> but there is no toggling on data line.
> 
I believe the reason is that OMAP expects to get McBSP1 receiver clocks
from its own CLKR and FSR pins. Does it work if you configure the McBP1
receiver to use CLKX and FSX pins?

You could look help from following commit and file in sound-2.6.git
tree:
commit d2c0bdaa9362c4b2ab7416420d034a0a2d1ec979
sound/soc/omap/am3517evm.c

-- 
Jarkko
