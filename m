From: Colin Guthrie <gmane@colin.guthr.ie>
Subject: Re: "default" device. Is there a way to detect if it's
 a plugin, and if so which one?
Date: Mon, 04 Apr 2011 12:22:36 +0100
Message-ID: <4D99A9FC.3080102@colin.guthr.ie>
References: <in9oqa$46g$1@dough.gmane.org> <s5hhbaethc3.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from summit.brent.tribalogic.net (brent.tribalogic.net
	[78.86.109.144]) by alsa0.perex.cz (Postfix) with ESMTP id D85D02435F
	for <alsa-devel@alsa-project.org>;
	Mon,  4 Apr 2011 13:22:39 +0200 (CEST)
In-Reply-To: <s5hhbaethc3.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

'Twas brillig, and Takashi Iwai at 04/04/11 11:57 did gyre and gimble:
> At Sun, 03 Apr 2011 13:22:34 +0100,
> Colin Guthrie wrote:
>>
>> Hi,
>>
>> If the user opens the "default" device in alsa, is there a way to find
>> out if that "device" is actually a plugin?
>>
>> i.e. is it possible to tell if you have opened the pulseaudio plugin via
>> alsa?
>>
>> There are various hacky ways (e.g. checking hints etc.) but that relies
>> on downstream packaging which certainly isn't fool proof.
> 
> There is no clean way, AFAIK.
> A new API would be needed.  For example, something like:
> 	snd_pcm_contains_type(pcm, SND_PCM_TYPE_EXTPLUG);
> 
> But checking whether PA-plugin is used is difficult with the API above
> because pulse plugin has no unique PCM type but it's a sub-plugin
> of extplug plugin...

Yeah I didn't think there was an easy way.

I guess just "strongly recommending" the distros use a hint when they
redirect the "default" makes sense.

I do this:
aplay      aplaymidi
[colin@jimmy build-master (master)]$ aplay -L
null
    Discard all samples (playback) or generate zero samples (capture)
pulse
    PulseAudio Sound Server
default
    Default ALSA Output (currently PulseAudio Sound Server)

....

SO that the "default" hint contains the word "PulseAudio" which apps
could check. It's obviously not fool proof, but if this is only for
"hinting" purposes at the app level anyway, then it's maybe good enough.

(FWIW, it's for a situation where hinting to the user that they are
going via ALSA, when an optional but more specific pulse output is
supported by the app and may be more appropriate).

Thanks for the info.

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
