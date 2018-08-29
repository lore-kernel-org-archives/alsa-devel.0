From: Luca Ceresoli <luca@lucaceresoli.net>
Subject: Re: [PATCH 0/1] Fix ADI axi-i2s + Xilinx AXI-DMA capture
Date: Wed, 29 Aug 2018 09:16:12 +0200
Message-ID: <f11d102e-7a72-30f3-e308-394ad20b9bc0@lucaceresoli.net>
References: <20180824160430.10222-1-luca@lucaceresoli.net>
 <20180828185829.GL2414@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180828185829.GL2414@sirena.org.uk>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Lars-Peter Clausen <lars@metafoo.de>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Hi Mark,

On 28/08/2018 20:58, Mark Brown wrote:
> On Fri, Aug 24, 2018 at 06:04:29PM +0200, Luca Ceresoli wrote:
>> Hi,
>>
>> here is a fix for a nasty audio capture problem when the axi-i2s
>> output stream is fed to a Xilinx AXI-DMA.
> 
> Please don't send cover letters for single patches, if there is anything
> that needs saying put it in the changelog of the patch or after the ---
> if it's administrative stuff.  This reduces mail volume and ensures that 
> any important information is recorded in the changelog rather than being
> lost. 

OK, will do. Actually I usually do as you suggest, but in this case I
thought it deserved a little extra visibility. Sorry about that.

-- 
Luca
