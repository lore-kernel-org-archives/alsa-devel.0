From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: Unable to play MP3 using TinyCompress and
 bytcr-rt5640
Date: Wed, 30 Aug 2017 14:20:00 -0500
Message-ID: <8f328187-c23c-618c-3d62-73e6643a3e60@linux.intel.com>
References: <CAOmiHe+qmw34f_-yTqj6zy96bLXyGntd4qLAiQ8Aimmh5+rH=Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id E08572665D5
 for <alsa-devel@alsa-project.org>; Wed, 30 Aug 2017 21:20:05 +0200 (CEST)
In-Reply-To: <CAOmiHe+qmw34f_-yTqj6zy96bLXyGntd4qLAiQ8Aimmh5+rH=Q@mail.gmail.com>
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
To: Lambdadroid <lambdadroid@gmail.com>, alsa-devel@alsa-project.org
Cc: vinod.koul@intel.com
List-Id: alsa-devel@alsa-project.org

On 8/30/17 7:08 AM, Lambdadroid wrote:
> Hi,
> 
> I'm attempting to use TinyCompress to play a MP3 file on a Baytrail
> tablet (using bytcr-rt5640 on Linux 4.13-rc7) with ALSA's
> Compress-Offload API. After finding the right quirks and setting up
> the UCM files normal audio output is working, but I'm unable to play a
> MP3 file using the `cplay` tool included with TinyCompress.

The firmware available upstream does not contain MP3/AAC or proprietary 
libraries due to redistribution rights. Some of patents may start to 
expire soon but in general we steer clear of such components for freely 
available binary firmware. Not my choice btw, this is a minefield that's 
all too common for all open-source projects.

The benefits of mp3 offload on Baytrail are quite limited anyway due to 
internal SoC design choices, I wouldn't recommend you pursue this work 
if power optimization was the goal. Offload was mostly used for 
Medfield, Clovertrail, Merrifield and Anniedale platforms.

> 
> Note that `cplay` appears to be broken as of commit 50c2b03 "cplay:
> check the values of fread". fread returns the number of items that
> were read but the commit assumes it returns the number of bytes. I've
> simply changed the check to `read != 1` to fix it.

Indeed this looks wrong, thanks for reporting this point. Vinod, since 
you were the author of this patch can you check?
