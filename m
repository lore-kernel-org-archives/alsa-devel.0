From: Wolfgang Rosenauer <wolfgang@rosenauer.org>
Subject: Re: Alsa 32-64 bit issue
Date: Wed, 02 Jul 2008 14:40:06 +0200
Message-ID: <486B7726.1040608@rosenauer.org>
References: <486B6B02.4020202@rosenauer.org> <s5h1w2ccwj4.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ds9.rosenauer.org (ds9.rosenauer.org [78.47.28.164])
	by alsa0.perex.cz (Postfix) with ESMTP id 8D174245E1
	for <alsa-devel@alsa-project.org>;
	Wed,  2 Jul 2008 14:40:07 +0200 (CEST)
In-Reply-To: <s5h1w2ccwj4.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

Takashi Iwai wrote:
> At Wed, 02 Jul 2008 13:48:18 +0200,
> Wolfgang Rosenauer wrote:
>> Hi,
>>
>> I'm new to to this list (and also Alsa) so please forgive me some newbie =

>> questions you probably find ;-)
>>
>> I have an application which does simple PCM output to Alsa. It works so =

>> far (if pulseaudio is not used but that's another issue).
>> But if I try to run the app (which is compiled for 32bit) on a 64bit =

>> Linux system it fails at snd_pcm_start() with the following error:
>>
>> "Daten=C3=BCbergabe unterbrochen (broken pipe)"
> =

> It means that no data is present on the buffer.

That could perfectly be the case. But that isn't really a 64bit system =

thing, is it? I admit there is most likely something wrong with the app =

as it is now :-(
The thing is that we can't guarantee that there are always audio frames =

in the buffer since we get it as a stream from somewhere else and need =

to do A/V sync.
Currently we just snd_pcm_start() and only afterwards write to the =

buffer as the data comes in what as I understood now is not the way it's =

gonna work?

I've tried to set a sensible start_threshold and just leave out the =

snd_pcm_start() but that created a very distorted sound output (but no =

broken pipe indeed).

Wolfgang
