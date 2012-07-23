From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: Can ASoC support SPDIF AC3 passthrough playback
 (non linear PCM) ?
Date: Mon, 23 Jul 2012 14:36:49 -0500
Message-ID: <500DA7D1.7060507@linux.intel.com>
References: <CANh+=Y-jvvhafmiTFr_XgiO2sBUKCa0Z=hzMvgxyJbry3L1YNw@mail.gmail.com>
 <500CA2F2.1090801@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
 by alsa0.perex.cz (Postfix) with ESMTP id 8D292260317
 for <alsa-devel@alsa-project.org>; Mon, 23 Jul 2012 21:36:50 +0200 (CEST)
In-Reply-To: <500CA2F2.1090801@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 7/22/2012 8:03 PM, Gabriel M. Beddingfield wrote:
> On 07/21/2012 10:39 AM, Sangsu Park wrote:
>> Hi,
>> We're developing a platform where we have SPDIF output.
>> And we want to SPDIF AC3 playback (non linear PCM).
>> Our CPU is a kind of ARM architecture one and it has a SPDIF that can
>> support AC3 passthrough playback.
>>
>> I've already know that ALSA can support SPDIF AC3 passthrough playback
>> like follows,
>> http://www.mythtv.org/wiki/Configuring_Digital_Sound_with_AC3_and_SPDIF
>> But, I can't find that any ARM architecture CPU can be supportable for
>> SPDIF AC3 passthrough playback.
>>
>> Are there anyone who have a SPDIF AC3 passthrough playback?
>> or anyone who know the clue about SPDIF AC3 passthrought playback
>> supportable on ASoC?
>
> I'm currently working on a similar project -- and I'm learning about 
> this myself, too.
>
> As I understand it, you have to package the AC-3 into IEC 61937 format 
> first.  The S/PDIF driver will then encode it into the IEC 60958 
> (S/PDIF protocol).
>
> You probably need/want a copy of IEC 61937-3.[1]  It looks pretty 
> simple (add 4 headers to the front and some zero-padding at the end to 
> meet the alignment requirements).  I don't know of any software 
> examples for doing it[2] -- so if you find some, please share! :-)
>
> As for feeding it to ALSA, I think that's what the 
> SNDRV_PCM_FORMAT_IEC958_SUBFRAME is intended for.  However, in 
> practice I've heard that you can usually configure the PCM device to 
> something like an S16 format and things "just work."  (IEC 61937-3's 
> payload is 16-bit aligned.)
>
> ...and I think I've heard of some people shooting raw AC-3 and things 
> "just work."  YMMV. :-)

There are two modes really
- one where you send 16-bit data with the 61937 format. somehow the 
hardware add the preambles and CUVP bits
- one where you create the complete 32-bit frame using the iec958 
alsa-lib plugin
Both work with my HDAudio output, the latter is more flexible if you 
want to set the C/U bits

Note that this is all supported in PulseAudio, and gstreamer can package 
AC3/DTS data for you. mplayer also does.
-Pierre
