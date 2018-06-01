From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v2 1/3] ASoC: topology: Improve backwards
 compatibility with v4 topology files
Date: Fri, 1 Jun 2018 06:17:05 -0700
Message-ID: <0015aace-fe32-9707-d3c9-0dea6f5fc48c@roeck-us.net>
References: <1527191363-21021-1-git-send-email-linux@roeck-us.net>
 <20180601102506.GB8677@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pg0-f66.google.com (mail-pg0-f66.google.com [74.125.83.66])
 by alsa0.perex.cz (Postfix) with ESMTP id EB583267715
 for <alsa-devel@alsa-project.org>; Fri,  1 Jun 2018 15:17:10 +0200 (CEST)
Received: by mail-pg0-f66.google.com with SMTP id 15-v6so10950370pge.2
 for <alsa-devel@alsa-project.org>; Fri, 01 Jun 2018 06:17:10 -0700 (PDT)
In-Reply-To: <20180601102506.GB8677@sirena.org.uk>
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
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org, Chintan Patel <chintan.m.patel@intel.com>, Guenter Roeck <groeck@chromium.org>
List-Id: alsa-devel@alsa-project.org

On 06/01/2018 03:25 AM, Mark Brown wrote:
> On Thu, May 24, 2018 at 12:49:21PM -0700, Guenter Roeck wrote:
>> From: Guenter Roeck <groeck@chromium.org>
>>
>> Commit dc31e741db49 ("ASoC: topology: ABI - Add the types for BE
>> DAI") introduced sound topology files version 5. Initially, this
>> change made the topology code incompatible with v4 topology files.
> 
> No review on these from anyone at Intel?
> 

The only actionable feedback I have seen is that the header file
changes should be in uapi, which is done in patches 2 and 3.

Other than that, there was a question if this is a Linux issue or
a Chromebook issue (it appears that only Chromebooks shipped with
v4 configuration files). I took that as rhetorical since upstream
kernels (at least v4.4 and v4.5) support topology v4 configuration
files, and it should not matter which products shipped using those.

Guenter
