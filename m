From: "Gabriel M. Beddingfield" <gabrbedd@gmail.com>
Subject: Re: Can ASoC support SPDIF AC3 passthrough playback
 (non linear PCM) ?
Date: Sun, 22 Jul 2012 20:03:46 -0500
Message-ID: <500CA2F2.1090801@gmail.com>
References: <CANh+=Y-jvvhafmiTFr_XgiO2sBUKCa0Z=hzMvgxyJbry3L1YNw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ob0-f179.google.com (mail-ob0-f179.google.com
 [209.85.214.179])
 by alsa0.perex.cz (Postfix) with ESMTP id 8CBDB265018
 for <alsa-devel@alsa-project.org>; Mon, 23 Jul 2012 03:03:57 +0200 (CEST)
Received: by obbeh20 with SMTP id eh20so8137019obb.38
 for <alsa-devel@alsa-project.org>; Sun, 22 Jul 2012 18:03:58 -0700 (PDT)
In-Reply-To: <CANh+=Y-jvvhafmiTFr_XgiO2sBUKCa0Z=hzMvgxyJbry3L1YNw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, sangsu@gmail.com
Cc: android-platform@googlegroups.com
List-Id: alsa-devel@alsa-project.org

On 07/21/2012 10:39 AM, Sangsu Park wrote:
> Hi,
> We're developing a platform where we have SPDIF output.
> And we want to SPDIF AC3 playback (non linear PCM).
> Our CPU is a kind of ARM architecture one and it has a SPDIF that can
> support AC3 passthrough playback.
>
> I've already know that ALSA can support SPDIF AC3 passthrough playback
> like follows,
> http://www.mythtv.org/wiki/Configuring_Digital_Sound_with_AC3_and_SPDIF
> But, I can't find that any ARM architecture CPU can be supportable for
> SPDIF AC3 passthrough playback.
>
> Are there anyone who have a SPDIF AC3 passthrough playback?
> or anyone who know the clue about SPDIF AC3 passthrought playback
> supportable on ASoC?

I'm currently working on a similar project -- and I'm learning about 
this myself, too.

As I understand it, you have to package the AC-3 into IEC 61937 format 
first.  The S/PDIF driver will then encode it into the IEC 60958 (S/PDIF 
protocol).

You probably need/want a copy of IEC 61937-3.[1]  It looks pretty simple 
(add 4 headers to the front and some zero-padding at the end to meet the 
alignment requirements).  I don't know of any software examples for 
doing it[2] -- so if you find some, please share! :-)

As for feeding it to ALSA, I think that's what the 
SNDRV_PCM_FORMAT_IEC958_SUBFRAME is intended for.  However, in practice 
I've heard that you can usually configure the PCM device to something 
like an S16 format and things "just work."  (IEC 61937-3's payload is 
16-bit aligned.)

...and I think I've heard of some people shooting raw AC-3 and things 
"just work."  YMMV. :-)

-gabriel

[1] Digital Audio - Interface for non-linear PCM encoded audio 
bitstreams applying IEC 60958 - Part-3: Non-linear PCM bitstreams 
according to the AC-3 format.

[2] Nor do I know of anything in ALSA that will do it for you.
