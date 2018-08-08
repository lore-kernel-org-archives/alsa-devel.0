From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [PATCH v2 01/13] conf/ucm: bytcr-rt5645: Use the
 generic bytcr/PlatformEnableSeq.conf
Date: Wed, 8 Aug 2018 11:46:28 +0200
Message-ID: <9f440ac9-0767-aca6-9c19-fb42324946c2@perex.cz>
References: <20180808090543.15181-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 by alsa0.perex.cz (Postfix) with ESMTP id B09AA26786A
 for <alsa-devel@alsa-project.org>; Wed,  8 Aug 2018 11:46:32 +0200 (CEST)
In-Reply-To: <20180808090543.15181-1-hdegoede@redhat.com>
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
To: Hans de Goede <hdegoede@redhat.com>, alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

Dne 8.8.2018 v 11:05 Hans de Goede napsal(a):
> Use the generic Intel SSP bytcr/PlatformEnableSeq.conf file, it is
> identical to all the cset statements this commit removes.
> 
> Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  src/conf/ucm/chtrt5645/HiFi.conf | 116 +------------------------------
>  1 file changed, 1 insertion(+), 115 deletions(-)

I applied all 13 patches to the alsa-lib git tree. Thanks.

						Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
