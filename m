From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [PATCH 2/2] ALSA: pcm: implement the ioctl/mmap
 filter for the anonymous dup
Date: Wed, 30 Jan 2019 13:05:40 +0100
Message-ID: <9c2fbe4e-9fca-aadf-e295-0efd73b32968@perex.cz>
References: <20190130084733.979-1-perex@perex.cz>
 <20190130084733.979-3-perex@perex.cz> <s5h5zu6e67b.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 by alsa0.perex.cz (Postfix) with ESMTP id 311D9267455
 for <alsa-devel@alsa-project.org>; Wed, 30 Jan 2019 13:05:47 +0100 (CET)
In-Reply-To: <s5h5zu6e67b.wl-tiwai@suse.de>
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
Cc: ALSA development <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Phil Burk <philburk@google.com>, Leo Yan <leo.yan@linaro.org>, Baolin Wang <baolin.wang@linaro.org>
List-Id: alsa-devel@alsa-project.org

Dne 30.1.2019 v 12:27 Takashi Iwai napsal(a):
> On Wed, 30 Jan 2019 09:47:33 +0100,
> Jaroslav Kysela wrote:
>>
>> Create seven control bits to allow the various restrictions for the
>> anonymous file descriptor.
>>
>> Signed-off-by: Jaroslav Kysela <perex@perex.cz>
> 
> I think we need to check SNDRV_PCM_PERM_RW for read/write ops, too.

Yes, it will be in v3. Thanks for the review.

				Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
