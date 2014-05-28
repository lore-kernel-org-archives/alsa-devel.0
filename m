From: "Alexander E. Patrakov" <patrakov@gmail.com>
Subject: Re: On non-rewindability of resamplers
Date: Wed, 28 May 2014 21:38:57 +0600
Message-ID: <53860311.3000007@gmail.com>
References: <5356A9B6.9060405@gmail.com>	<5358FCF0.2040701@ladisch.de>	<53597BA2.8080201@gmail.com>	<5359FE72.8050605@canonical.com>	<535A6C96.7040109@gmail.com>	<CAN8ccibLsqb6oxai=+XOAhZ1dPwZmVVD2r3teDsz2a2_CthoOA@mail.gmail.com>	<535B83E4.5050303@gmail.com>	<CAN8ccibXtR=jc3NJjFMn88stytAhSxjNqbD5QsREDppbKDNg9Q@mail.gmail.com>	<535E908C.4030509@gmail.com>	<CAN8ccib7E7SQFo=Ro5Hksaj74Nn9NtHA1VSQpKX3ARHQDE_QHQ@mail.gmail.com>	<535FDEA8.7010206@gmail.com>	<CAN8cciYoR25LDZnr6R9Bn_ek4rX1q8XoRPT+H4Mpp3ecZJF85w@mail.gmail.com>	<5364CE4D.7040506@gmail.com>	<CAN8cciYB-vD0Oeigv=rGt1XDSZvqGm_KpyV_HwARCg8LLFEQjg@mail.gmail.com>	<536E26A4.1060002@gmail.com>	<CAN8ccibugnc_8FEf_184PTWGBHdt4Wa0Af=A8AwT1_uFSJZX_g@mail.gmail.com>	<53705396.3070406@gmail.com>	<CAN8cciZGaFs2dPq0FJzhqyrtn9-irGBv6wmTjG1aRcJcCviu
 Hg@mail.gmail.com>	<537F9AAC.2030204@gmail.com>
 <CAN8cciZaSZ0C7VoN=jtw_BN5zc=K_4yhqd0N8yuT74qz0kjKEQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-la0-f45.google.com (mail-la0-f45.google.com
 [209.85.215.45])
 by alsa0.perex.cz (Postfix) with ESMTP id CAEBA265087
 for <alsa-devel@alsa-project.org>; Wed, 28 May 2014 17:39:00 +0200 (CEST)
Received: by mail-la0-f45.google.com with SMTP id gl10so7509110lab.4
 for <alsa-devel@alsa-project.org>; Wed, 28 May 2014 08:39:00 -0700 (PDT)
In-Reply-To: <CAN8cciZaSZ0C7VoN=jtw_BN5zc=K_4yhqd0N8yuT74qz0kjKEQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Raymond Yau <superquad.vortex2@gmail.com>
Cc: sergemp@mail.ru, ALSA Development Mailing List <alsa-devel@alsa-project.org>, Clemens Ladisch <clemens@ladisch.de>, david.henningsson@canonical.com
List-Id: alsa-devel@alsa-project.org

28.05.2014 13:58, Raymond Yau wrote:
>  >>
>
>  > Yes. The test program is attached. For stereo S16_LE output, it
> reports 32 samples (i.e. 128 bytes) as the minimum period size.
>
> your program segfault when using NULL plugin

Bug in the null plugin. snd_pcm_null_fast_ops lacks the .rewindable 
field initialization, thus this callback gets defaulted to NULL. Thanks 
for reporting.

>
>  >
>
>  >> what other events pulseaudio need to rewind beside
>  >>
>  >> 1) change in volume of sink/source
>
> Volume change of the sink is supposed to be real time event
>
> User are allowed to change the volume slider even when the sink is not
> playing or source is not capturing
>
> If the requested volume cannot be satisfied by changing hardware volume
> controls , does pulseaudio keep the calculated software volume
> adjustment when the sink start playing while the hardware volume is
> supposed to be updated immediately ?

The answer depends on the volume mode.

In the flat-volume mode, there is in fact no independent sink volume. If 
at least one stream is playing, then the volume of the loudest stream is 
applied as a sink volume, and other streams are attenuated accordingly. 
So the answer to your question is "no", because starting the stream 
changes the total volume of the sink, including the hardware part.

In the non-flat volume mode, the answer is "yes".

>
> when user specify ignore_DB=1 or codec does not have any volume control
> (e.g. SPDIF stereo playback) which force pulseaudio to use software volume.
>
> The software volume will be same as the requested volume(volume slider
> in sound preference) even when there is no playing stream.
>
> Do this software volume setting  saved in pulseaudio database when
> shutdown and  restore on pulseaudio next startup by
> module-device-restore for the SPDIF stereo profile ?

The volume is saved and restored as a whole. module-device-restore does 
not care what part of the volume is software and what part is hardware.

>
>
>  >> 2) change in volume of streams
>
> since there may be multiple streams (clients)  playing at the same time,
> Do pulseaudio still keep copies of unmixed audio of all connected clients ?

Yes. Each sink input keeps some past audio in a memblockq, just in case 
if the sink re-asks it.

>
>
>  >> 3) change in latency
>  >> 4) sync slaves of combined sinks
>  >
>  >
>  > I don't think that (4) is valid. It is handled by resampling, not
> rewinding.
>  >
>  > 5) explicit rewrite request from the client (if the sink has already
> rendered the rewritten data into its buffer)
>
>  > 6) state change ("If we are added for the first time...") of the sink
> input
>
> If the stream is the first client ,
>
> How about a low latency client connect to server when a high latency
> client is already playing ?
>
> Do pulseaudio still rewind the sink when low latency client is playing
> and a  high latency client connect to server ?

Every new connection (and by "added for the first time" the comment 
means exactly this) causes a full rewind.

>
>  > 7) corking/uncorking
>
> Do you mean pause of the playing stream while other stream is still
> playing ?

Yes. The other case is when a music stream is paused automatically while 
another stream (e.g. VoIP) is about to be played.

>
>  > 8) end of underrun (for specific sink inputs)
>
> if appl_ptr is behind hw_ptr , you need to use snd_pcm_forward to
> advance the appl_ptr to a suitable position which you write enough data
> so that final appl_ptr is at least one period ahead of hwptr
>
> Why do end of underrun need rewind ?

Because we mean different kinds of underrun. You mean ALSA-level 
underrun. The comment means PulseAudio-level underrun - i.e. one of the 
streams failed to supply data in time, while the ALSA card got data 
without the contribution from that stream.

So PulseAudio mixed a lot of data ahead without that stream, filled in 
the ALSA buffer, and new data for that stream shows up. Obviously, it 
needs to be heard right away, and thus already-mixed data should be 
discarded by an ALSA-level rewind.

>
>  > 9) moving streams between sinks
>
> What happen when the sinks have different buffer size ?
>
> Do all playing streams need to re-adjust latency ?
>

In theory, yes. The total latency is the sum of the latency of the sink 
and the latency specific to the sink input. This sum needs to be 
redistributed amongst these two parts.

However, the big comment after "case PA_SINK_MESSAGE_START_MOVE:" in 
src/pulsecore/sink.c contains some FIXMEs about known bugs in this process.

-- 
Alexander E. Patrakov
