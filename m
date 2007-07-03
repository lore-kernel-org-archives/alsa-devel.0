From: "Howdy Pierce" <howdy@cardinalpeak.com>
Subject: Re: left/right bleed or crossover
Date: Tue, 3 Jul 2007 17:02:49 -0600
Message-ID: <004d01c7bdc6$47e60660$6a00a8c0@cardinalpeak.com>
References: <s5hk5thakd8.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp113.plus.mail.re1.yahoo.com
	(smtp113.plus.mail.re1.yahoo.com [69.147.102.76])
	by alsa0.perex.cz (Postfix) with SMTP id B09A3103879
	for <alsa-devel@alsa-project.org>;
	Wed,  4 Jul 2007 01:03:23 +0200 (CEST)
In-Reply-To: <s5hk5thakd8.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: 'Takashi Iwai' <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> Howdy Pierce wrote:
>> I'm encountering the following problem on Fedora Core 6 running on a Dell
>> Optiplex 745.  This is a pretty vanilla computer with an ICH8 chipset and
>> integrated AD1983 sound capabilities. 
>> 
>> I have wired up a funky line-input cable so that I have completely 
>> separate audio sources playing on the left and right inputs.
>> 
>> When I either play these through to the speaker output directly (using
>> alsamixer), or record the audio using arecord, the result is that there 
>> is a slight bit of bleeding or crossover, so I can faintly hear the left 
>> input on the right channel, and vice versa.  If I record a wav file and 
>> then play it on another computer, the left/right bleeding follows the wav

>> file, so it seems that the problem is in the capture process somehow.
>>
>> When I install Windows XP onto the same machine, the problem disappears, 
>> so I can rule out hardware errors.
>> 
>> The application I'm working on relies on being able to reliably capture 
>> the right and left channels of audio independently.  Since the problem 
>> can be seen using the standard arecord/aplay tools, though, I don't think

>> it's my code.
>> 
>> I've tried all the possible combinations inside alsamixer, and I don't 
>> think there's anything I've messed up there.
>
> To investigate where the problem exists, try to use "hw" PCM first
> without alsa-lib plugins.  If the problem still remains, it's in the
> driver (that I don't expect since your codec dump looks sane to me).

Thanks for the response.

I assume you want me to record something with 
    arecord --device=hw:0,0
?

The problem still exists with that command line.  Where do I need to look
next -- the kernel driver?  Any theories as to what might be happening here?
Has anyone seen something similar before, perhaps on other hardware?

--Howdy 

  =============================
  Howdy Pierce
  Managing Partner
  Cardinal Peak, LLC

  work:  (303) 665-3962 x101
  cell:  (303) 589-1645
  email: howdy@cardinalpeak.com
  web:   www.cardinalpeak.com
  =============================
