From: Troy Kisky <troy.kisky@boundarydevices.com>
Subject: Re: [PATCH 0/5] [RFC] ALSA ASoC Support for TLVaic23b
 audio codec
Date: Mon, 29 Sep 2008 09:47:10 -0700
Message-ID: <48E1068E.7020908@boundarydevices.com>
References: <dfeb90390809290241h2219ef57q2a7401aebf47efe5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpauth00.csee.onr.siteprotect.com
	(smtpauth00.csee.onr.siteprotect.com [64.26.60.144])
	by alsa0.perex.cz (Postfix) with ESMTP id 718EA24487
	for <alsa-devel@alsa-project.org>;
	Mon, 29 Sep 2008 18:47:29 +0200 (CEST)
In-Reply-To: <dfeb90390809290241h2219ef57q2a7401aebf47efe5@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Arun KS <arunks@mistralsolutions.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Arun KS wrote:
> Hi all,
> 
> The following patches adds ASOC driver for TLVaic23b audio codec.
> 
> Tested playback and capture on omap 5912osk board with some hacks in the
> omap platform and machine driver.
> 
> Thanks,
> Arun
> --

Great. I just finished the same thing for davinci but using spi.
I was waiting until the adc issue I mentioned yesterday was resolved before posting it.
I'm glad I won't have to now. But my board also has I2c, just not with this
codec. Can the I2c code be moved into the board directory? I have my spi code
in the board directory and just pass the write function pointer. i.e.

	codec->hw_write = setup_data->hw_write;


Can you email me some data captured by from your mic input?
I'm interested in seeing if you have the same trouble in dsp_a
mode.


Thanks,
Troy
