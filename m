From: Yisheng Xie <xieyisheng1@huawei.com>
Subject: Re: [PATCH v2 16/21] ASoC: max98088: use match_string() helper
Date: Thu, 31 May 2018 20:25:39 +0800
Message-ID: <8009e494-9ba0-bff3-e900-37f8923886a0@huawei.com>
References: <1527765086-19873-1-git-send-email-xieyisheng1@huawei.com>
 <1527765086-19873-17-git-send-email-xieyisheng1@huawei.com>
 <20180531114921.GD13319@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180531114921.GD13319@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org, andy.shevchenko@gmail.com, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Mark,

On 2018/5/31 19:49, Mark Brown wrote:
> On Thu, May 31, 2018 at 07:11:21PM +0800, Yisheng Xie wrote:
>> match_string() returns the index of an array for a matching string,
>> which can be used instead of open coded variant.
> 
> I don't have either the cover letter or the rest of the series here so
> I've no context - what is the story here with regard to dependencies and
> things?
Sorry about that I should have sent cover letter to you, but for too many maintainer
to sent, I ignore this to avoid make too much noisy.

Anyway, Here is the cover letter of v1 and I have add v2's cover letter to you:
  https://lkml.org/lkml/2018/5/21/303

Each patch in this patchset is a separate one, for what this patchset want to do
is use match_string() helper for echo subsystem.

Thanks
Yisheng
> 
