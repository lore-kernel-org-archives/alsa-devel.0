From: "Pan, Xiuli" <xiuli.pan@linux.intel.com>
Subject: Re: [PATCH alsa-lib] conf/ucm: Add a UCM profile for
 Dell WD15 Dock USB-audio
Date: Thu, 3 May 2018 15:45:28 +0800
Message-ID: <568403fb-66b1-abd9-176a-0314552db260@linux.intel.com>
References: <20180502145431.4192-1-tiwai@suse.de>
 <s5ha7tinl2b.wl-tiwai@suse.de>
 <7a8c0202-87e7-69af-ab4e-05398a749432@linux.intel.com>
 <s5hmuxhdytx.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by alsa0.perex.cz (Postfix) with ESMTP id 95E1B266F46
 for <alsa-devel@alsa-project.org>; Thu,  3 May 2018 09:45:30 +0200 (CEST)
In-Reply-To: <s5hmuxhdytx.wl-tiwai@suse.de>
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
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org



On 5/3/2018 14:42, Takashi Iwai wrote:
> On Thu, 03 May 2018 07:20:53 +0200,
> Pan, Xiuli wrote:
>>
>>
>> On 5/2/2018 23:17, Takashi Iwai wrote:
>>> On Wed, 02 May 2018 16:54:31 +0200,
>>> Takashi Iwai wrote:
>>>> USB-audio device on Dell WD15 docking station provides two individual
>>>> PCM streams, one for headphone and another for line out.  A UCM
>>>> profile gives the proper roles for these.
>>>>
>>>> Signed-off-by: Takashi Iwai <tiwai@suse.de>
>>> The change in configure.ac was missing.  Below is the corrected one.
>>> Sorry for the mess.
>> The V1 patch seems to be merged in the master branch.
>> I send a patch to fix the build error based on your V2 version patch.
> I seem to have forgotten to refresh the git repo.  Grrr.
> Since it took too long, I applied the incremental fix commit instead
> of rebase, exactly same as what you sent.
Thanks for the fixing.
The master could compile now.

Thanks
Xiuli
>
> thanks,
>
> Takashi
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
