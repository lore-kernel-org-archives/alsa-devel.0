From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v2 0/3] ASoC: Intel: boards: fix
 compilation and quirk handling
Date: Sat, 20 Apr 2019 00:50:28 +0200
Message-ID: <5a489e37-6111-19c1-1113-040f3b048fee@redhat.com>
References: <20190419201218.19821-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ed1-f68.google.com (mail-ed1-f68.google.com
 [209.85.208.68])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5993AF801D9
 for <alsa-devel@alsa-project.org>; Sat, 20 Apr 2019 00:50:30 +0200 (CEST)
Received: by mail-ed1-f68.google.com with SMTP id g6so5472230edc.8
 for <alsa-devel@alsa-project.org>; Fri, 19 Apr 2019 15:50:30 -0700 (PDT)
In-Reply-To: <20190419201218.19821-1-pierre-louis.bossart@linux.intel.com>
Content-Language: en-US
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, alsa-devel@alsa-project.org
Cc: tiwai@suse.de, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

Hi,

On 19-04-19 22:12, Pierre-Louis Bossart wrote:
> Fix compilation warning and align quirk override handling between
> machine drivers.
> 
> V2: use default -1 in all cases as discussed with Hans de Goede

Thank you, series looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans
