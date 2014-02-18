From: Dylan Reid <dgreid@chromium.org>
Subject: Re: [PATCH 1/3] ALSA: hda - Remove dependency on
 bus->pci in hda_beep.c
Date: Tue, 18 Feb 2014 10:20:09 -0800
Message-ID: <CAEUnVG4nPchSJngmPY==0mN713Y1L5q8NNf2JfSR-9bmLJh87Q@mail.gmail.com>
References: <1392455855-10594-1-git-send-email-tiwai@suse.de>
 <s5hfvnkzq4y.wl%tiwai@suse.de> <5303A0A3.6050206@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qc0-f171.google.com (mail-qc0-f171.google.com
 [209.85.216.171])
 by alsa0.perex.cz (Postfix) with ESMTP id 8E66C2625E6
 for <alsa-devel@alsa-project.org>; Tue, 18 Feb 2014 19:20:30 +0100 (CET)
Received: by mail-qc0-f171.google.com with SMTP id x3so1137315qcv.30
 for <alsa-devel@alsa-project.org>; Tue, 18 Feb 2014 10:20:29 -0800 (PST)
In-Reply-To: <5303A0A3.6050206@wwwdotorg.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Feb 18, 2014 at 10:04 AM, Stephen Warren <swarren@wwwdotorg.org> wrote:
> On 02/15/2014 02:22 AM, Takashi Iwai wrote:
>> At Sat, 15 Feb 2014 10:17:33 +0100,
>> Takashi Iwai wrote:
>>>
>>> The default parent device can be obtained directly via card object, so
>>> we don't need to rely on pci->dev.parent.  Since there is no access to
>>> pci_dev, we can reduce the inclusion of linux/pci.h, too.
>>>
>>> Signed-off-by: Takashi Iwai <tiwai@suse.de>
>>
>> I forgot the cover page: these tree patches are trivial cleanups of
>> hda-codec drivers (not the controller) to work without PCI device
>> assignment. The idea was triggered by Dylan's question.
>
> The series seems fine to me, so briefly,
> Reviewed-by: Stephen Warren <swarren@nvidia.com>
>

Thanks Takashi,

I tested this series on a Haswell and IvyBridge system. Looks good to
me as well.
