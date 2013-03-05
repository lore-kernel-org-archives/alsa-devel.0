From: Christine Spang <christine.spang@oracle.com>
Subject: Re: [PATCH] Make snd_BUG_ON() always evaluate and
 return the conditional expression.
Date: Tue, 05 Mar 2013 15:41:06 -0500
Message-ID: <51365862.9050401@oracle.com>
References: <1362434579-7733-1-git-send-email-christine.spang@oracle.com>
 <s5h8v62gqt0.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from userp1040.oracle.com (userp1040.oracle.com [156.151.31.81])
 by alsa0.perex.cz (Postfix) with ESMTP id DFA1D2652C4
 for <alsa-devel@alsa-project.org>; Tue,  5 Mar 2013 21:41:18 +0100 (CET)
In-Reply-To: <s5h8v62gqt0.wl%tiwai@suse.de>
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
Cc: Sasha Levin <sasha.levin@oracle.com>, alsa-devel@alsa-project.org, Jamie Iles <jamie.iles@oracle.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On 03/05/2013 04:05 AM, Takashi Iwai wrote:
> At Mon,  4 Mar 2013 17:02:59 -0500,
> Christine Spang wrote:
>> Having snd_BUG_ON() only evaluate its conditional when CONFIG_SND_DEBUG
>> is set leads to frequent bugs, since other similar macros in the kernel
>> have different behavior. Let's make snd_BUG_ON() act like those macros
>> so it will stop being accidentally misused.
>>
>> Signed-off-by: Christine Spang <christine.spang@oracle.com>
> Sounds reasonable.  The dependency on CONFIG_SND_DEBUG was for
> allowing more optimization, but since we use this for more places than
> expected, this change would be safer indeed.
>
> If no one has objection, I'll apply it for 3.10 kernel.
>
>
> thanks,
>
> Takashi

This ought to be considered for 3.9 and stable@ as
well. It fixes NULL derefs all over the place, e.g.

sound/core/device.c:126

    if (snd_BUG_ON(!card || !device_data))
        return -ENXIO;
    list_for_each_entry(dev, &card->devices, list) {
       [...]

If card == NULL and CONFIG_SND_DEBUG is off, this code will NULL deref.

There are some 600 other instances of snd_BUG_ON() being used dubiously
in the current tree. Some of these instances even perform extra cleanup
before returning in error conditions. It's really broken with
CONFIG_SND_DEBUG off, and no major distro ships production kernels with
this setting enabled.

Christine
