From: Timur Tabi <timur@tabi.org>
Subject: Re: [PATCH RFC 1/1] ASoC: fsl_ssi: Make fifo watermark and maxburst
 settings device tree options
Date: Thu, 14 Jan 2016 19:31:19 -0600
Message-ID: <56984BE7.2050303@tabi.org>
References: <1452788982-11583-1-git-send-email-caleb@crome.org>
 <20160114201858.GA17567@Asurada-Nvidia>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160114201858.GA17567@Asurada-Nvidia>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolin Chen <nicoleotsuka@gmail.com>, Caleb Crome <caleb@crome.org>
Cc: Xiubo Li <Xiubo.Lee@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Nicolin Chen wrote:
> I think DT maintainers may not give a consent towards these two
> properties as they are not to describe the hardware but to hack
> software configurations. (And it seems you haven't CCed them.)

I admit it's a grey area, but the hardware doesn't work if you use the 
wrong value, and it is a fixed value per device.  A p1022ds would use a 
different value than in in i.MX6, and once you pick a value, it's the 
same no matter which sample rate, buffer size, etc you choose.
