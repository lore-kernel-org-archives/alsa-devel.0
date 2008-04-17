From: James Courtier-Dutton <James@superbug.co.uk>
Subject: Re: What does 0dB refer to? (Logitech USB Speakers)
Date: Thu, 17 Apr 2008 21:39:05 +0100
Message-ID: <4807B569.6000008@superbug.co.uk>
References: <20080411204610.GA32413@tango.0pointer.de>	<20080414172839.GA26513@tango.0pointer.de>	<4803C78A.3020109@superbug.co.uk>	<200804150552.13578.faber@faberman.de>
	<20080415131203.GA2818@localhost>
	<4804BCB8.9060707@keyaccess.nl> <48060D2F.2000701@keyaccess.nl>
	<480618F3.40707@keyaccess.nl> <48061D1F.6060809@keyaccess.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from anchor-post-32.mail.demon.net (anchor-post-32.mail.demon.net
	[194.217.242.90])
	by alsa0.perex.cz (Postfix) with ESMTP id 8F57F2447F
	for <alsa-devel@alsa-project.org>;
	Thu, 17 Apr 2008 22:39:07 +0200 (CEST)
In-Reply-To: <48061D1F.6060809@keyaccess.nl>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Rene Herman <rene.herman@keyaccess.nl>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Rene Herman wrote:
> On 16-04-08 17:19, Rene Herman wrote:
> 
> For now last time that I reply to myself (promise):
> 
>> On 16-04-08 16:29, Rene Herman wrote:
>>
>>> On 15-04-08 16:33, Rene Herman wrote:
> 
>>> On that note, I just acquired an Audigy 2 (SB0240) that I'm testing 
>>> with and now that I'm paying attention to it due to this thread -- 
>>> its 0 dB setting is very significantly louder (with everything behind 
>>> the line-out constant ofcourse) than the 0 dB setting on my TerraTec 
>>> DMX.
>>>
>>> James, I believe you are the emu10k1 person? Data:
>>>
>>> TerraTec DMX = ESS Canyon3D (ES1970MS-3D) + Sigmatel STAC9704T
>>>
>>> Creative Audigy 2 (SB0240) = Creative CA0102-ICT + Sigmatel STAC9721T 
>>> (+ Crystal CS4382-KQ which seems to provide digital attenuation as well)
>>>
>>> At 0 dB master the Audigy 2 is much louder than the DMX is and 
>>> audibly distorts. Judging by hearing, keeping the master at -16 dB 
>>> (60 in the integer scale) gets things about the same. Was that scale 
>>> provided by datasheet or just guessed? Especially the distortion 
>>> would seem to indicate that something is actually doing analogue 
>>> amplification at the 0 dB ALSA setting...
>>
>> Expanding, with the 'Line' control at 0 dB (74 integer) and 'Analog 
>> Mix' at 0 dB (100 integer) everything does sound right with both 
>> 'Master Capture' and 'Master' at  full, and too faint with 'Master' at 
>> -16 dB. I guess this indicates that it's something at the DSP side 
>> only? (sort of loosing my way in this bewildering array of controls so 
>> if I need to be guided to possibly say sensible things -- please do)
> 
> When I do actually capture, -16 dB master is again the correct setting 
> when playing back (with everything else still set to 0 dB as described 
> above). It's then equally load as when directly monitored during 
> recording. I expect then the Master dB scale needs to be adjusted down? 
> If yes, I'll try to make very, very sure that -16 dB now is the correct 
> new 0 dB.
> 
> Rene.

Can we narrow this down a bit please.
Run speaker-test -c2 -twav
Do the test to each sound card with alsamixer set to 0dB for most 
controls accept the master, and leave the master at a sensible setting 
for your setup so that you can hear sound at a sensible level
With the same dB values on the Andigy 2 and DMX, do you get the same 
loudness of sound output to the speakers?

I would like to find out if the problem is in the playback path, or the 
capture path.


James
