From: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: What does 0dB refer to? (Logitech USB Speakers)
Date: Wed, 16 Apr 2008 17:19:15 +0200
Message-ID: <480618F3.40707@keyaccess.nl>
References: <20080411204610.GA32413@tango.0pointer.de>	<20080414172839.GA26513@tango.0pointer.de>	<4803C78A.3020109@superbug.co.uk>	<200804150552.13578.faber@faberman.de>
	<20080415131203.GA2818@localhost>
	<4804BCB8.9060707@keyaccess.nl> <48060D2F.2000701@keyaccess.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq1.groni1.gr.home.nl (smtpq1.groni1.gr.home.nl
	[213.51.130.200])
	by alsa0.perex.cz (Postfix) with ESMTP id E8ED4247D4
	for <alsa-devel@alsa-project.org>;
	Wed, 16 Apr 2008 17:16:19 +0200 (CEST)
In-Reply-To: <48060D2F.2000701@keyaccess.nl>
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

On 16-04-08 16:29, Rene Herman wrote:

> On 15-04-08 16:33, Rene Herman wrote:
> 
>> mute/minimal. Bit of a maintenance chore, and the usefulness depends 
>> on how much level variation there actually is generally. Are we in 
>> essence only talking about Lennart's buggy USB crap or is this more 
>> involved?
> 
> On that note, I just acquired an Audigy 2 (SB0240) that I'm testing with 
> and now that I'm paying attention to it due to this thread -- its 0 dB 
> setting is very significantly louder (with everything behind the 
> line-out constant ofcourse) than the 0 dB setting on my TerraTec DMX.
> 
> James, I believe you are the emu10k1 person? Data:
> 
> TerraTec DMX = ESS Canyon3D (ES1970MS-3D) + Sigmatel STAC9704T
> 
> Creative Audigy 2 (SB0240) = Creative CA0102-ICT + Sigmatel STAC9721T (+ 
> Crystal CS4382-KQ which seems to provide digital attenuation as well)
> 
> At 0 dB master the Audigy 2 is much louder than the DMX is and audibly 
> distorts. Judging by hearing, keeping the master at -16 dB (60 in the 
> integer scale) gets things about the same. Was that scale provided by 
> datasheet or just guessed? Especially the distortion would seem to 
> indicate that something is actually doing analogue amplification at the 
> 0 dB ALSA setting...

Expanding, with the 'Line' control at 0 dB (74 integer) and 'Analog Mix' at 
0 dB (100 integer) everything does sound right with both 'Master Capture' 
and 'Master' at  full, and too faint with 'Master' at -16 dB. I guess this 
indicates that it's something at the DSP side only? (sort of loosing my way 
in this bewildering array of controls so if I need to be guided to possibly 
say sensible things -- please do)

Rene.
