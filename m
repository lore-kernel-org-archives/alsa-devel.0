From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [RFC/RFT PATCH] ASoC: topology: Improve backwards
 compatibility with v4 topology files
Date: Wed, 23 May 2018 08:42:59 -0500
Message-ID: <521b23cd-f083-6a19-1374-fde7057c869b@linux.intel.com>
References: <20180522165842.233949-1-groeck@google.com>
 <fb9aebba-919a-2e80-aec7-2fd44e5e1861@linux.intel.com>
 <20180523082424.GA4828@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by alsa0.perex.cz (Postfix) with ESMTP id 9029826765F
 for <alsa-devel@alsa-project.org>; Wed, 23 May 2018 15:43:03 +0200 (CEST)
In-Reply-To: <20180523082424.GA4828@sirena.org.uk>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Guenter Roeck <groeck@google.com>, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Chintan Patel <chintan.m.patel@intel.com>, Guenter Roeck <groeck@chromium.org>
List-Id: alsa-devel@alsa-project.org

On 5/23/18 3:24 AM, Mark Brown wrote:
> On Tue, May 22, 2018 at 02:59:35PM -0500, Pierre-Louis Bossart wrote:
> 
>> I am also not convinced by the notion that maintaining topology files is
>> only a userspace/distro issue. This would mean some distros will have access
>> to the required topology files, possibly enabling DSP processing
>> capabilities, but other will not and will not be able to enable even basic
>> playback/capture. Just like we have a basic firmware with limited
>> functionality in /lib/firmware/intel, it would make sense to require a basic
>> .conf file in alsa-lib for every upstream machine driver - along possibly
>> with a basic UCM file so that audio works no matter what distro people use.
> 
> The point here is that people should be able to update their kernel
> without updating their userspace so things have to work with whatever
> they have right now - anything that relies on shipping new firmware or
> configuration files to userspace is a problem.

Agree.

My point was a bit different: distributions like Gallium start without 
the relevant topology files and UCM settings, and we should have a 
reference to quickly enable audio without having to borrow and modify 
files from another distro. I faced this issue when I worked with the 
Gallium folks to enable audio on Rambi and Cyan Chromebooks and ended-up 
creating this reference myself.
