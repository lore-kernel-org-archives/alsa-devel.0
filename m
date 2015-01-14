From: Qais Yousef <qais.yousef@imgtec.com>
Subject: Re: [PATCH v2] ALSA: ASoC: soc-compress.c: fix NULL dereference
Date: Wed, 14 Jan 2015 07:53:00 +0000
Message-ID: <54B6205C.7060608@imgtec.com>
References: <1421147933-21802-1-git-send-email-qais.yousef@imgtec.com> <20150113145931.GD3085@intel.com> <54B536BA.3070001@imgtec.com> <20150113162004.GR4160@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150113162004.GR4160@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Vinod Koul <vinod.koul@intel.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On 01/13/2015 04:20 PM, Mark Brown wrote:
> On Tue, Jan 13, 2015 at 03:16:10PM +0000, Qais Yousef wrote:
>> On 01/13/2015 02:59 PM, Vinod Koul wrote:
>>>> being NULL, hence when trying to set rtd a few lines below we get an oops.
>>> It is a good practice to add the oops here
>> Will this really be helpful? I think it'll be more clutter (the backtrace on
>> metag arch is not great):
> It's better in general to leave it out unless it's adding something (for
> example sometimes the particular call path is important) and even there
> edit it down to relevant details - the splat from the full oops normally
> overwhelms the commit message.

I think the commit message explains what's going. So unless Vinod 
insists I'll send v3 with the other 2 requested fixes.

Thanks for the review!
