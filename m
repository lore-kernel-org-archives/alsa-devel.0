From: Daniel Drake <drake@endlessm.com>
Subject: Re: snd_soc_set_dmi_name - Shouldn't it use SYS_VENDOR?
Date: Thu, 27 Apr 2017 14:13:30 -0600
Message-ID: <CAD8Lp44uqQW9+V_ZgB4LLXa8WFb+=CX8hT8PmWbZEGFhZGTvBw@mail.gmail.com>
References: <CAD8Lp454-BRKu7GZxpbO+4qgFfSTF0DviUcaUDtgNOVrzb2jLw@mail.gmail.com>
 <5aa36e3b-49f9-d7f6-df58-18dcfcda08e5@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-io0-f173.google.com (mail-io0-f173.google.com
 [209.85.223.173])
 by alsa0.perex.cz (Postfix) with ESMTP id CED60266C0A
 for <alsa-devel@alsa-project.org>; Thu, 27 Apr 2017 22:13:32 +0200 (CEST)
Received: by mail-io0-f173.google.com with SMTP id p80so34401373iop.3
 for <alsa-devel@alsa-project.org>; Thu, 27 Apr 2017 13:13:32 -0700 (PDT)
In-Reply-To: <5aa36e3b-49f9-d7f6-df58-18dcfcda08e5@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: liam.r.girdwood@linux.intel.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Apr 27, 2017 at 1:28 PM, Pierre-Louis Bossart
<pierre-louis.bossart@linux.intel.com> wrote:
> Not sure if we can really limit the conventions to type1 or type2 if we want
> the names to be somewhat meaningful.
>
> I can't recall why we selected DMI_BOARD_VENDOR instead of DMI_SYS_VENDOR
> though.

Is it too late to change to DMI_SYS_VENDOR? Or to have both present in
the string?

Thanks
Daniel
