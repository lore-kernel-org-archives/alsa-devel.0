From: John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH] SOUND-OSS: Remove sh_dac_audio
Date: Wed, 22 Sep 2010 18:27:46 +0200
Message-ID: <AANLkTi=L9vJ9Bfek8HGb30c0U949H0EgiXX7oHxj-F_=@mail.gmail.com>
References: <1285156021-4973-1-git-send-email-jkacur@redhat.com>
	<20100922145737.GA12663@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20100922145737.GA12663@linux-mips.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ralf Baechle <ralf@linux-mips.org>
Cc: lkml <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Jaroslav Kysela <perex@perex.cz>, Frederic Weisbecker <fweisbec@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Sep 22, 2010 at 4:57 PM, Ralf Baechle <ralf@linux-mips.org> wrote:
> On Wed, Sep 22, 2010 at 01:47:01PM +0200, John Kacur wrote:
>
>> Remove the SH DAC oss driver since there is an equivalent alsa driver.
>> oss has been deprecated for years. Furthermore this driver has BKL code
>> which we are trying to remove. Rather than attempt to fix this, simply
>> remove the driver.
>>
>> Signed-off-by: John Kacur <jkacur@redhat.com>
>
> No idea why I was cc'ed as I have no interested in the driver but certainly
> support the motivation behind the patch:
>
> Acked-by: Ralf Baechle <ralf@linux-mips.org>
>

Thanks. FWIW, I cced you because you were part of the original conversation
back in the Stone Ages (or maybe it was just May) about removing certain
OSS drivers that had equivalent ALSA drivers.
