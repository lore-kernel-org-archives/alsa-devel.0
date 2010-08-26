From: Keith Chew <keith.chew@gmail.com>
Subject: Re: 5.1 surround on 3 jacks (retasking)
Date: Thu, 26 Aug 2010 18:35:35 +1200
Message-ID: <AANLkTinE8sjRWWsHYJYq1w_rLJu9Y91J4gs7k-Q_M3j-@mail.gmail.com>
References: <AANLkTin3DKSRuUZwARAadMTVPTrj17eHK8557bCsb3YM@mail.gmail.com>
	<4C75A7D9.1030604@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-iw0-f179.google.com (mail-iw0-f179.google.com
	[209.85.214.179])
	by alsa0.perex.cz (Postfix) with ESMTP id B19EA24945
	for <alsa-devel@alsa-project.org>;
	Thu, 26 Aug 2010 08:35:36 +0200 (CEST)
Received: by iwn4 with SMTP id 4so1297947iwn.38
	for <alsa-devel@alsa-project.org>; Wed, 25 Aug 2010 23:35:35 -0700 (PDT)
In-Reply-To: <4C75A7D9.1030604@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: David Henningsson <david.henningsson@canonical.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

> My first approach to that problem would be to try to tweak
> user_pin_configs, assuming that the generic parser (model=auto) is used.
> See sections 4.3 and 4.4 on this document for how to do that:
>
> http://mirror.leaseweb.com/kernel/people/tiwai/docs/HD-Audio.html
>
> That way you won't have to update the kernel code at all.
>
> To figure out the values of user_pin_configs, you'll need to know the
> pin widget NIDs (see your /proc/asound/card*/codec* file for that) and
> pin values (see official Intel HDA documentation, or read hda_proc.c).
>
Hi David

Thank you very much for your guidance, I have gotten a bit further,
and this is very exciting!

After reading HD-Audio.html, I used the hda-analyzer to configure NIDs
0x14, 0x19 and 0x1b to become outputs, and when I execute:

speaker-test -Dplug:surround51 -c6

I can hear sound on all 3 jacks, but only for Front left/right
channels. In other words, all 3 jacks are being treated as Front. To
confirm this, in alsamixer, the mute on Front (0x14) does mute all 3
jacks.

I guess I am missing the relationship between alsamixer and the codec.
How can I get aplay and speaker-test (with plug:surround51) to map to
Front/Mic2/Line2, now that I have configured them as outputs?

Regards
Keith
