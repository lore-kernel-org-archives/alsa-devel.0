From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: [PATCH 0/30] ALSA: HDA VIA: patch series
Date: Sun, 11 Oct 2009 10:56:48 -0600
Message-ID: <51f3faa70910110956t3b537401p51a4053102f94a2c@mail.gmail.com>
References: <4AD06ADD.4000308@viatech.com.cn> <s5h8wfhewf1.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-iw0-f198.google.com (mail-iw0-f198.google.com
	[209.85.223.198])
	by alsa0.perex.cz (Postfix) with ESMTP id CB323243C6
	for <alsa-devel@alsa-project.org>;
	Sun, 11 Oct 2009 18:56:49 +0200 (CEST)
Received: by iwn36 with SMTP id 36so5230466iwn.24
	for <alsa-devel@alsa-project.org>; Sun, 11 Oct 2009 09:56:48 -0700 (PDT)
In-Reply-To: <s5h8wfhewf1.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, LydiaWang@viatech.com.cn, Logan Li <loganli@viatech.com.cn>, HaraldWelte@viatech.com
List-Id: alsa-devel@alsa-project.org

On Sun, Oct 11, 2009 at 10:18 AM, Takashi Iwai <tiwai@suse.de> wrote:
> At Sat, 10 Oct 2009 19:07:09 +0800,
> Logan Li wrote:
>>
>> Following patch series mainly includes:
>> =A0- support VT1718S, VT2002P, VT1812S, VT1716S, ...
>> =A0- support smart 5.1
>> =A0- add jack detection for VT1708
>> =A0- power saving functions
>
> Thanks for the patches. =A0They are all well formatted now.
>
> I applied your patches except for 17,
> =A0 =A0 =A0 =A0ALSA: HDA VIA: Add 2nd S/PDIF out for VT1708S and VT1702
> as Robert reported a regression.
>
> This is likely because of the behavior change by this patch. =A0Now
> the second SPDIF has to be specified manually with the explicit
> substream number. =A0This itself is fine, but I see the problem with
> pulseaudio, for example. =A0There is no good way to specify this substream
> automatically for PA with some symbols like "spdif" or "hdmi".
>
> This is basically a problem of the current ALSA core and HD-audio core
> implementation. =A0So, we should solve all together.

Actually, the latest posted version didn't have the mixer problem I
had before (I haven't looked in detail at what was different). But I
agree using a different substream for a different output isn't ideal
since there's no way for software to detect that this is the case. Can
it be a separate PCM like hw:0,2 or something?

Hopefully VIA will also look into the SPDIF no-output problem I have
with VT1828S..

>
> On most machines, it's not too big deal to have it the secondary digital
> as a slave. =A0If this really matters, we can add another hint to make
> the individual digital substreams conditionally.
>
> Anyway, please check the latest sound GIT tree (or alsa-driver snapshot)
> whether it works. =A0I only tested the compilation, so far.
>
>
> thanks,
>
> Takashi
>
