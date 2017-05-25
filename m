From: Michael Forney <mforney@mforney.org>
Subject: Re: Problems with the DP MST audio support patchset
Date: Thu, 25 May 2017 01:21:46 -0700
Message-ID: <CAGw6cBusfo6OjNWrbsGnDLx_D=K_DQ-X8aVfQ0awgG_tf8TBMA@mail.gmail.com>
References: <6800ee6e-31c2-b5eb-fbb2-6826d8c66dc9@pa-w.de>
 <bceb4859-6dc9-b7a8-4d3a-81ac2a1fa907@pa-w.de>
 <96A12704CE18D347B625EE2D4A099D19524850F3@SHSMSX103.ccr.corp.intel.com>
 <63a71394-1cd4-e3e3-7364-37c2da90c791@pa-w.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f67.google.com (mail-oi0-f67.google.com
 [209.85.218.67])
 by alsa0.perex.cz (Postfix) with ESMTP id 00FD4266D30
 for <alsa-devel@alsa-project.org>; Thu, 25 May 2017 10:21:48 +0200 (CEST)
Received: by mail-oi0-f67.google.com with SMTP id h4so36457636oib.0
 for <alsa-devel@alsa-project.org>; Thu, 25 May 2017 01:21:48 -0700 (PDT)
In-Reply-To: <63a71394-1cd4-e3e3-7364-37c2da90c791@pa-w.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Yang, Libin" <libin.yang@intel.com>
Cc: Libin Yang <libin.yang@linux.intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Pascal Wichmann <pascal.wichmann@pa-w.de>
List-Id: alsa-devel@alsa-project.org

On Thu, Mar 30, 2017 at 9:35 AM, Pascal Wichmann
<pascal.wichmann@pa-w.de> wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA256
>
> Hi,
>
>> Do you mean the issue is caused by the patches
>> 1480992519-108079-1-git-send-email-libin.yang@intel.com?
> I don't know whether the issues are caused directly by the
> specific patches; without them, digital audio does not work at
> all in my setup. Using analog audio however does not have the problems
> mentioned in my first email.
>
>> I can't see which patches are included you mentioned in the link.
> I am building my kernel from drm-tip. The relevant patches enabling DP M
> ST
> audio seem to be "ALSA: hda - add DP mst verb support" [0] as well as
> "ALSA: hda - add DP MST audio support" [1].

Hi,

I recently updated my kernel to 4.11, and am experiencing similar
problems as Pascal. I have a Skylake processor and DP output hooked up
with a DP to HDMI cable to an Onkyo SR-606 receiver.

I can't get audio to work at all through my receiver anymore. I tried
both DTS and PCM audio files. I bisected it to the above mentioned
commit 9152085defb6426ce8f9989ca27e4450daefbd89 (ALSA: hda - add DP
MST audio support).

>> Do you know if the DP MST audio mode is used in your case?

I don't know what DP MST is or how to tell if I'm using it. However, I
noticed that when it does work, `aplay -L` gives me

hdmi:CARD=PCH,DEV=0
    HDA Intel PCH, HDMI 0
    HDMI Audio Output
hdmi:CARD=PCH,DEV=1
    HDA Intel PCH, HDMI 1
    HDMI Audio Output

and when it doesn't, I get

hdmi:CARD=PCH,DEV=0
    HDA Intel PCH, Generic Digital
    HDMI Audio Output

> I think it is used; at least dp/hdmi audio does not work at all without
> building against drm-tip. (the outputs are all stated as unplugged
> and unavailable in pavucontrol for example)
> Is there any way to know for sure?

I tried building against drm-tip as well as v4.12-rc2, but observed
the same issue. I am not using pulseaudio, but alsa directly.

Any help would be appreciated.

Thanks,
Michael
