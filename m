From: "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
Subject: Re: [PATCH 1/4] ASoC: dwc: I2S Controller instance param added
Date: Wed, 18 Apr 2018 15:11:30 +0530
Message-ID: <88fc41f1-79ee-5df1-3a23-e188c83c9d42@amd.com>
References: <1523941201-15665-1-git-send-email-Vijendar.Mukunda@amd.com>
 <1523941201-15665-2-git-send-email-Vijendar.Mukunda@amd.com>
 <20180417160908.GH8973@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180417160908.GH8973@sirena.org.uk>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Alex Deucher <alexander.deucher@amd.com>, Akshu Agrawal <akshu.agrawal@amd.com>, Lubomir Rintel <lkundrak@v3.sk>, Markus Elfring <elfring@users.sourceforge.net>, Jose Abreu <Jose.Abreu@synopsys.com>, "Gustavo A. R. Silva" <garsilva@embeddedor.com>, "moderated list:SOUND" <alsa-devel@alsa-project.org>, open list <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org



On Tuesday 17 April 2018 09:39 PM, Mark Brown wrote:
> On Tue, Apr 17, 2018 at 10:29:51AM +0530, Vijendar Mukunda wrote:
> 
>> +#define I2S_SP_INSTANCE		1
>> +#define I2S_BT_INSTANCE		2
> 
> This is obviously very specific to the system you're working with and
> therefore doesn't belong in the generic driver.  The device should be
> dealing with its own configuration, it shouldn't need to know about what
> specifically is connected to it.  It's not even clear what they're doing
> in this driver given that there doesn't appear to be any use of the
> information, it feels like this is something that the machine driver
> should be encapsulating.
> 
> Like I said with previous reviews this use of magic numbers for the
> interfaces is a bit of a red flag, internally within a driver they're
> fine but they shouldn't leak out too much except with things like
> numbering an array.
> 

I will remove macros from designware header file and I will re spin
the patch set
