From: Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [alsa-devel] future of sounds/oss
Date: Thu, 11 May 2017 13:36:15 -0700
Message-ID: <2e64b1c4-de07-addd-d3f6-f9f21a62370b@infradead.org>
References: <20170511082133.GA20304@lst.de> <s5hh90rhjbc.wl-tiwai@suse.de>
 <20170511091511.GA21055@lst.de> <s5hy3u32lhi.wl-tiwai@suse.de>
 <CA+55aFxofWfreZ1X6JA68-L=TSCWtO+xjBp1yX0RPnrfAive_g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CA+55aFxofWfreZ1X6JA68-L=TSCWtO+xjBp1yX0RPnrfAive_g@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>, Takashi Iwai <tiwai@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Jaroslav Kysela <perex@perex.cz>, "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." <alsa-devel@alsa-project.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On 05/11/17 13:28, Linus Torvalds wrote:
> On Thu, May 11, 2017 at 1:21 PM, Takashi Iwai <tiwai@suse.de> wrote:
>>
>> Since no one cried against it so far, I'll try to smuggle the
>> following patch into 4.12.
> 
> Can we instead just disable it with a one-liner that just makes
> SOUND_PRIME have a
> 
>      depends on n
> 
> in it, so that you can't select it.
> 
> Commenting out stuff in the Kconfig fine is not how we normally do
> these things..

Yeah, I was thinking of
	depends on BROKEN

but depends on n should be OK also.


-- 
~Randy
