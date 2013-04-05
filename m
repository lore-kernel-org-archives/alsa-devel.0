From: Dylan Reid <dgreid@chromium.org>
Subject: Re: [PATCH v2] ALSA: hda/ca0132 - Update latency based
 on DSP state.
Date: Fri, 5 Apr 2013 10:01:52 -0700
Message-ID: <CAEUnVG7iLokj+biNXfrppp_z_toDCNPww-Y4QJXU3voC2a-FHg@mail.gmail.com>
References: <1365108909-13587-1-git-send-email-dgreid@chromium.org>
 <s5hehep4jt9.wl%tiwai@suse.de> <515EE730.6080705@linux.intel.com>
 <s5h4nfl2ea5.wl%tiwai@suse.de> <515EFBCA.9060101@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f42.google.com (mail-bk0-f42.google.com
 [209.85.214.42])
 by alsa0.perex.cz (Postfix) with ESMTP id 825A6261730
 for <alsa-devel@alsa-project.org>; Fri,  5 Apr 2013 19:02:13 +0200 (CEST)
Received: by mail-bk0-f42.google.com with SMTP id jc3so2193158bkc.15
 for <alsa-devel@alsa-project.org>; Fri, 05 Apr 2013 10:02:13 -0700 (PDT)
In-Reply-To: <515EFBCA.9060101@linux.intel.com>
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
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Apr 5, 2013 at 9:28 AM, Pierre-Louis Bossart
<pierre-louis.bossart@linux.intel.com> wrote:
>
>> I thought that the timestamp and the runtime delay are basically
>> independent parameters.  Why must the former be disabled?
>
>
> In HDA you have DPIB and LPIB. The position in the buffer is reported by
> DPIB and the # of samples rendered is reported by LPIB. The delay is the
> difference between the two when you use the LPIB_DELAY implementation. As a
> result, when you look-up the timestamps and query the delay, what you get is
> the current time as seen by the HDA interface. If you increment the runtime
> delay to add the codec delay, then you must also increment by the same
> amount in azx_get_wallclock_tstamp(). Just updating the runtime delay is not
> enough.

Thanks for the explanation Pierre, but I'm still a little confused.

Does the timestamp represent the time the last sample was put in the
buffer or the time the last sample was rendered to the bus?

Is the "current time" meant to be the timestamp that the next sample
sent will be rendered?  (timestamp + delay)

> One problem I also have with this approach is that the delay may be
> different if you have multiple streams processed with different algorithms,
> and that isn't exposed here.
> -Pierre
>
