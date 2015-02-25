From: "Alexander E. Patrakov" <patrakov@gmail.com>
Subject: Re: Issues and/or possible bugs in alsa
Date: Wed, 25 Feb 2015 13:36:18 +0500
Message-ID: <54ED8982.3050802@gmail.com>
References: <CACui-2k8j3ZWtmvwiE3V5apuQ0g-dn=wN-h4miExDYLLR4diWA@mail.gmail.com>
 <54ED8466.7020102@gmail.com> <54ED881F.7070102@perex.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lb0-f173.google.com (mail-lb0-f173.google.com
 [209.85.217.173])
 by alsa0.perex.cz (Postfix) with ESMTP id A80912605D1
 for <alsa-devel@alsa-project.org>; Wed, 25 Feb 2015 09:36:21 +0100 (CET)
Received: by lbvn10 with SMTP id n10so2285212lbv.6
 for <alsa-devel@alsa-project.org>; Wed, 25 Feb 2015 00:36:21 -0800 (PST)
In-Reply-To: <54ED881F.7070102@perex.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>, Yomi Ogunwumi <abyomi0@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

25.02.2015 13:30, Jaroslav Kysela wrote:
> Dne 25.2.2015 v 09:14 Alexander E. Patrakov napsal(a):
>> 25.02.2015 03:46, Yomi Ogunwumi wrote:
>>> Third. This is just a question. Is this :
>>> https://bugs.freedesktop.org/show_bug.cgi?id=86676 actually a pulseaudio
>>> bug, or is it an issue with alsa?
>>> I'm only asking since Raymond linked something that seemed to belong to the
>>> alsa project.
>>>
>> This is a bug both in ALSA and in PulseAudio.
>>
>> The ALSA part (from the user viewpoint) is that the softvol plugin does
>> not reprocess the already-submitted but buffered samples when the volume
>> changes. But it can't, because that would require an additional thread
>> for monitoring the software volume changes, and such thread does not exist.
>>
>> The PulseAudio part of the bug is that it does not deactivate softvols,
>> even though it can apply volume in software itself. In October 2014, in
>> Dusseldorf, a general agreement has been reached on the following arguments:
>>
>>    * ALSA has no API to definitely distinguish softvols from other controls.
>>    * ALSA has the snd_ctl_elem_info_is_user() API function that tells
>> whether this is a userspace control.
>>    * All softvols are userspace controls.
>>    * There are other kinds of userspace controls, but they are rare.
>>    * If a control is named PCM Playback Volume and is a userspace
>> control, then it's likely a softvol. Not bulletproof, but a good-enough
>> heuristic.
>>    * On finding a softvol, PulseAudio should set it to 100% (so that it
>> doesn't eat CPU) and don't touch from that point on.
>>
>> But nobody has implemented this so far.
> PulseAudio should open PCM with the SND_PCM_NO_SOFTVOL mode. In this
> case, the PCM device does not add the softvol plugin to the internal
> plugin chain. These mode flags was introduced a long time ago (discussed
> with Lennart) and I thought that PA uses it.
>
> 					Jaroslav
>

Well, that can be done, but the "don't attempt to control the softvol" 
part of the bug needs to be solved first. SND_PCM_NO_SOFTVOL by itself 
is not sufficient.

-- 
Alexander E. Patrakov
