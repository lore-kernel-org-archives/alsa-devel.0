From: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: What does 0dB refer to? (Logitech USB Speakers)
Date: Thu, 17 Apr 2008 23:30:39 +0200
Message-ID: <4807C17F.8030603@keyaccess.nl>
References: <20080411204610.GA32413@tango.0pointer.de>	<20080414172839.GA26513@tango.0pointer.de>	<4803C78A.3020109@superbug.co.uk>	<200804150552.13578.faber@faberman.de>
	<20080415131203.GA2818@localhost>
	<4804BCB8.9060707@keyaccess.nl> <48060D2F.2000701@keyaccess.nl>
	<480618F3.40707@keyaccess.nl> <48061D1F.6060809@keyaccess.nl>
	<4807B569.6000008@superbug.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq2.groni1.gr.home.nl (smtpq2.groni1.gr.home.nl
	[213.51.130.201])
	by alsa0.perex.cz (Postfix) with ESMTP id 2A50C24450
	for <alsa-devel@alsa-project.org>;
	Thu, 17 Apr 2008 23:27:38 +0200 (CEST)
In-Reply-To: <4807B569.6000008@superbug.co.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: James Courtier-Dutton <James@superbug.co.uk>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 17-04-08 22:39, James Courtier-Dutton wrote:

[ John: I never drop CCs unrequested as I really dislike it when people do 
that in a conversation I myself am reading but please say so if you don't 
care to be in this thread ]

> Rene Herman wrote:
>> On 16-04-08 17:19, Rene Herman wrote:
>>
>> For now last time that I reply to myself (promise):
>>
>>> On 16-04-08 16:29, Rene Herman wrote:
>>>
>>>> On 15-04-08 16:33, Rene Herman wrote:
>>
>>>> On that note, I just acquired an Audigy 2 (SB0240) that I'm testing 
>>>> with and now that I'm paying attention to it due to this thread -- 
>>>> its 0 dB setting is very significantly louder (with everything 
>>>> behind the line-out constant ofcourse) than the 0 dB setting on my 
>>>> TerraTec DMX.
>>>>
>>>> James, I believe you are the emu10k1 person? Data:
>>>>
>>>> TerraTec DMX = ESS Canyon3D (ES1970MS-3D) + Sigmatel STAC9704T
>>>>
>>>> Creative Audigy 2 (SB0240) = Creative CA0102-ICT + Sigmatel 
>>>> STAC9721T (+ Crystal CS4382-KQ which seems to provide digital 
>>>> attenuation as well)
>>>>
>>>> At 0 dB master the Audigy 2 is much louder than the DMX is and 
>>>> audibly distorts. Judging by hearing, keeping the master at -16 dB 
>>>> (60 in the integer scale) gets things about the same. Was that scale 
>>>> provided by datasheet or just guessed? Especially the distortion 
>>>> would seem to indicate that something is actually doing analogue 
>>>> amplification at the 0 dB ALSA setting...
>>>
>>> Expanding, with the 'Line' control at 0 dB (74 integer) and 'Analog 
>>> Mix' at 0 dB (100 integer) everything does sound right with both 
>>> 'Master Capture' and 'Master' at  full, and too faint with 'Master' 
>>> at -16 dB. I guess this indicates that it's something at the DSP side 
>>> only? (sort of loosing my way in this bewildering array of controls 
>>> so if I need to be guided to possibly say sensible things -- please do)
>>
>> When I do actually capture, -16 dB master is again the correct setting 
>> when playing back (with everything else still set to 0 dB as described 
>> above). It's then equally load as when directly monitored during 
>> recording. I expect then the Master dB scale needs to be adjusted 
>> down? If yes, I'll try to make very, very sure that -16 dB now is the 
>> correct new 0 dB.
> 
> Can we narrow this down a bit please.
> Run speaker-test -c2 -twav
> Do the test to each sound card with alsamixer set to 0dB for most 
> controls accept the master, and leave the master at a sensible setting 
> for your setup so that you can hear sound at a sensible level
> With the same dB values on the Andigy 2 and DMX, do you get the same 
> loudness of sound output to the speakers?

Very much not. Sorry, it seems the report (unsnipped above) got a little 
confusing due to the followups but with everything at 0 dB on both DMX and 
Audigy 2, the Audigy 2 is much louder and distorts.

DMX has 'PCM' -34.5 --> +12 dB and 'Master' -46.5 --> 0 dB. I always keep 
both at 0 dB for a good, comfortable level (adjusted further externally).

Audigy 2 'Front' and 'Wave' are both  at 0 dB (max) (everything default in 
fact) and with 'Master' at 0 dB, it's much louder then the DMX. Setting 
'Master' to -16 dB (60) gets things the same.

> I would like to find out if the problem is in the playback path, or the 
> capture path.

Playback I'd say and I personally consider DMX right here, due to the 
distortion from the Audigy.

Only introduced capture into the story above as "additional evidence" where 
I could do a a comparison using only the Audigy itself and not the DMX: with 
everything at 0 dB in the capture direction, a captured file needs to be 
played back at -16 dB 'Master' to be equally loud to what I hear _during_ 
capturing as well ("hear" from 'Analog Mix' at 0 dB). So I get the feeling 
it's a simple matter of transposing 0 dB on the Master scale for the Audigy 
(ie, new 0 dB is old -16 dB).

I should have another emu10k1 driven card here somewhere. Is it useful if I 
try to dig it up and see if the story's the same on it?

Rene.
