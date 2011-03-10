From: Colin Guthrie <gmane@colin.guthr.ie>
Subject: Re: HDA: Problem with sound becoming corrupted
Date: Thu, 10 Mar 2011 12:31:54 +0000
Message-ID: <4D78C4BA.4030005@colin.guthr.ie>
References: <il858r$kce$1@dough.gmane.org>
	<AANLkTinP1ScPzoUqGbSdWRsUUiVhHSVBKvYkMtUKorq1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from summit.brent.tribalogic.net (brent.tribalogic.net
	[78.86.109.144]) by alsa0.perex.cz (Postfix) with ESMTP id D35C5244B9
	for <alsa-devel@alsa-project.org>; Thu, 10 Mar 2011 13:31:58 +0100 (CET)
In-Reply-To: <AANLkTinP1ScPzoUqGbSdWRsUUiVhHSVBKvYkMtUKorq1@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jean-Yves Avenard <jyavenard@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

'Twas brillig, and Jean-Yves Avenard at 10/03/11 02:41 did gyre and gimble:
> Hi
> 
> On 10 March 2011 02:10, Colin Guthrie <gmane@colin.guthr.ie> wrote:
>> The problem is that the sound suddenly goes nuts and starts sounding
>> awful. It's like some buffer pointer is just a little bit out for some
>> reason.
>>
>> I can fix the issue by closing and reopening the PCM device (as I use
>> PA, this is just a simple "pasuspender echo" away).
> 
> 
>>
>> The problem is very easy to reproduce - it happens about 20+ times a day
>> to me - to the extent that I have added a panel launcher with the above fix.
> 
> I have to raise my hand on this one too... It has puzzled me for a few
> months now.
> I had thought it was related to the new video/audio card I'm using a
> GT220 , but this is about the same time I upgraded alsa.
> 
> Every once in a while, the audio becomes slightly distorted. Voices
> sounds like they are gargling with mouthwash while talking.
> 
> Interestingly, it sounds the same for AC3 or DTS passthrough, it's
> slightly corrupted, but not enough to break the AC3 stream from being
> usable by the amp.
> 
> However, closing the PCM device and re-opening it doesn't fix the
> issue for me ; I need to reboot.
> 
> This is seen with MythTV using ALSA directly (I wrote the audio code in MythTV)
> 
> Few MythTV users have reported it, I can't explain what is causing it..

[Resend as I used the wrong email address the first time! Things have
changed since the first one tho' Jean-Yves!]

Sounds like it could be related indeed.

I've been trying an older kernel today: 2.6.36.2 with:
 Advanced Linux Sound Architecture Driver Version 1.0.23.

It worked well initially, but sadly I did get two occurrences of the
problem so far (both specifically triggered rather than happening
organically). This seems to tie in with my feeling that the problem
started off as a nuisance but has gotten significantly more problematic
with more recent kernels....

With a more recent kernel I can trigger it just changing the volume
rapidly (which triggers a "bloop" noise). With this older kernel I still
used this to trigger the problems, but it takes a while (it feels to
take a lot longer than the newer kernel). I cannot discount this being a
subjective comparison however.

I'll look further.

Col

-- 

Colin Guthrie
gmane(at)colin.guthr.ie
http://colin.guthr.ie/

Day Job:
  Tribalogic Limited [http://www.tribalogic.net/]
Open Source:
  Mageia Contributor [http://www.mageia.org/]
  PulseAudio Hacker [http://www.pulseaudio.org/]
  Trac Hacker [http://trac.edgewall.org/]
