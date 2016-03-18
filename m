From: Vinod Koul <vinod.koul@linux.intel.com>
Subject: Re: [alsa-devel] [PATCH] ASoC: dapm: Do not traverse widget hooks to
 snd-soc-dummy
Date: Fri, 18 Mar 2016 10:47:12 +0530
Message-ID: <56EB8F58.6040609@linux.intel.com>
References: <1458127071-14417-1-git-send-email-harry.pan@intel.com>
 <20160317095438.GD2566@sirena.org.uk> <1458211115.965.13.camel@intel.com>
 <20160317112514.GE2566@sirena.org.uk> <56EAA4FC.5090408@metafoo.de>
 <20160317154236.GH2566@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160317154236.GH2566@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "tiwai@suse.com" <tiwai@suse.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "Pan, Harry" <harry.pan@intel.com>, "gs0622@gmail.com" <gs0622@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Thursday 17 March 2016 09:12 PM, Mark Brown wrote:
> On Thu, Mar 17, 2016 at 01:37:16PM +0100, Lars-Peter Clausen wrote:
>
>> I'd say as a quick fix for stable check that card is not NULL in
>> dapm_widget_show_component(). And as a longterm fix get rid of dapm_widget
>> file. Nobody should hopefully use it anymore with debugfs being available as
>> the far better alternative.
>
> Getting rid of the file is definitely not a bad idea but I'd still like
> to see us make the dummy component more consistent with other components
> in order to minimise the chances that we'll run into other special
> cases.

Right, I do see that we need dummy component to be fixed up. Today if we 
use dummy twice in a card it refers to same instance whereas IMO it 
should create separate instances. I will try something on these lines in 
next month or so...

-- 
~Vinod
