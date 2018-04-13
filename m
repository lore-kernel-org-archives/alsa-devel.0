From: Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: Re: [PATCH] sound: soc: intel: bxt_da7219_max98357a:
 Replace GFP_ATOMIC with GFP_KERNEL in broxton_audio_probe
Date: Fri, 13 Apr 2018 18:54:15 +0800
Message-ID: <32138b5e-843b-3f37-28ee-62d7fa93f0db@gmail.com>
References: <1523270781-22627-1-git-send-email-baijiaju1990@gmail.com>
 <20180413104130.GA6854@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pg0-f65.google.com (mail-pg0-f65.google.com [74.125.83.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 0C513266BBC
 for <alsa-devel@alsa-project.org>; Fri, 13 Apr 2018 12:54:35 +0200 (CEST)
Received: by mail-pg0-f65.google.com with SMTP id v26so1777317pge.11
 for <alsa-devel@alsa-project.org>; Fri, 13 Apr 2018 03:54:35 -0700 (PDT)
In-Reply-To: <20180413104130.GA6854@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, tiwai@suse.com, lgirdwood@gmail.com, sathyanarayana.nujella@intel.com, Adam.Thomson.Opensource@diasemi.com
List-Id: alsa-devel@alsa-project.org



On 2018/4/13 18:41, Mark Brown wrote:
> On Mon, Apr 09, 2018 at 06:46:21PM +0800, Jia-Ju Bai wrote:
>> broxton_audio_probe() is never called in atomic context.
>> This function is only set as ".probe" in "struct platform_driver".
> Please submit patches using subject lines reflecting the style for the
> subsystem.  This makes it easier for people to identify relevant
> patches.  Look at what existing commits in the area you're changing are
> doing and make sure your subject lines visually resemble what they're
> doing.

Oh, sorry for my improper subjects.
Thanks for your very helpful advice :)
I looked at previous related patches, and find the subject should be 
"ASoC: Intel: ...."
I will follow it in my future patches.

Do I need to send V2 patches?


Best wishes,
Jia-Ju Bai
