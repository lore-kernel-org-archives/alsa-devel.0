From: Bill Unruh <unruh@physics.ubc.ca>
Subject: Re: [Alsa-user] Creative Sound Blaster Audigy SE Mic
	problem
Date: Wed, 24 Nov 2010 06:35:38 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1011240630300.17550@info.physics.ubc.ca>
References: <28016_1290605977_1290605977_4CED1571.8090507@guest.arnes.si>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from info.physics.ubc.ca (info.physics.ubc.ca [142.103.234.23])
	by alsa0.perex.cz (Postfix) with ESMTP id A008424141
	for <alsa-devel@alsa-project.org>; Wed, 24 Nov 2010 15:35:41 +0100 (CET)
In-Reply-To: <28016_1290605977_1290605977_4CED1571.8090507@guest.arnes.si>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Grega Fajdiga <Gregor.Fajdiga@guest.arnes.si>
Cc: alsa-user@lists.sourceforge.net, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, 24 Nov 2010, Grega Fajdiga wrote:

> Hello,
>
> I am using Ubuntu 10.10 with a Creative Sound Blaster Audigy SE.
>
> The snd_ca0106 module is loaded.
>
> I have a Y-connector plugged in the green front left/right jack
> so that I can listen at the sound through speakers and the
> headphones at the same time. The microphone is plugged into the
> blue jack, consistent with the sound card specs:
>
> http://pdfguides.com/creative-labs-sound-blaster-audigy-se-features-specifications.html
>
> I go the sound working after getting a tip that both the digital
> and analog mixer might be turned on. After turning the digital
> control off, sound started to work.
>
> However, mic still isn't working in Linux, although it works just
> fine in Win 7.
>
> There are 7 input mixers available in alsamixer:
>
> -Line-in: set at 81/81 volume
> -Mic: 100/100
> -Phone 81/81
> -Aux: 0/0
> -Analog Source: set to Mic (no VU meter)
> -Digital Source: set to AC97 in (cannot seem to be muted)
> -Shared Mic/Line in  set to Line in
>
> If I set both Analog Source and Shared Mic/Line in to Mic, I get
> screeching sounds from speakers and headphones. If I set one of

That is probably what is called feedback.i It says yor microphone works.
  Unplug your headphones/speakers. 
Ie, turn off all output. So set both to Mic. 
Now record. Once you have recorded Turn off the inputs. and see if there is
some recording. Or use something like audacity and look at the input meter.


> them to Line in and one to Mic no sound is played back after I
> record some sound.
>
> Can anyone help?
>
> Thanks,
>

-- 
William G. Unruh   |  Canadian Institute for|     Tel: +1(604)822-3273
Physics&Astronomy  |     Advanced Research  |     Fax: +1(604)822-5324
UBC, Vancouver,BC  |   Program in Cosmology |     unruh@physics.ubc.ca
Canada V6T 1Z1     |      and Gravity       |  www.theory.physics.ubc.ca/
