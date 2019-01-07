From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [RFC 0/2] conf/ucm: bytcht-es8316 support
Date: Mon, 7 Jan 2019 12:08:27 +0100
Message-ID: <7a570574-9ce3-441d-f82a-81d2705340fc@redhat.com>
References: <20190103135015.14669-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com
 [209.85.221.66])
 by alsa0.perex.cz (Postfix) with ESMTP id B3B54267946
 for <alsa-devel@alsa-project.org>; Mon,  7 Jan 2019 12:08:29 +0100 (CET)
Received: by mail-wr1-f66.google.com with SMTP id q18so42705415wrx.9
 for <alsa-devel@alsa-project.org>; Mon, 07 Jan 2019 03:08:29 -0800 (PST)
In-Reply-To: <20190103135015.14669-1-hdegoede@redhat.com>
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
To: alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>, linux@endlessm.com, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Daniel Drake <drake@endlessm.com>
List-Id: alsa-devel@alsa-project.org

Hi,

On 03-01-19 14:50, Hans de Goede wrote:
> Hi All,
> 
> Here is the UCM profile to match the kernel patches which I just submitted
> upstream. Note this series is RFC for now, since it depends on the name
> of a few controls added by the kernel series, as well as on the long_name
> set by the kernel series.
> 
> Once the kernel series has been merged into -next, this UCM profile series
> can be merged as well. I will send another mail when the kernel series has
> been accepted.

The kernel patches for this are in -next now, so the alsa-lib patches from
this series are now no longer RFC and can be merged now.

Regards,

Hans
