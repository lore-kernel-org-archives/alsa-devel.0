From: David Henningsson <david.henningsson@canonical.com>
Subject: Alsamixertest (was: how to mandate the use of PCM
	plugin?)
Date: Mon, 04 Oct 2010 09:51:27 +0200
Message-ID: <4CA9877F.7060009@canonical.com>
References: <4C9F6409.6010400@aknet.ru>
	<20100927005858.GD21247@sirena.org.uk>	<4CA0221D.6030208@aknet.ru>
	<i7qltg$bph$1@dough.gmane.org>	<AANLkTi=9gcs0A6s55wSS-RP4NucvUqkxCoYynezdF+5g@mail.gmail.com>	<4CA306CB.1090305@canonical.com>
	<AANLkTi=h+ZKXNdhmC1BtTbBaGF6_V+uD2ZO7sx4WMJMW@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from adelie.canonical.com (adelie.canonical.com [91.189.90.139])
	by alsa0.perex.cz (Postfix) with ESMTP id 800A824149
	for <alsa-devel@alsa-project.org>;
	Mon,  4 Oct 2010 09:51:27 +0200 (CEST)
Received: from hutte.canonical.com ([91.189.90.181])
	by adelie.canonical.com with esmtp (Exim 4.69 #1 (Debian))
	id 1P2fpW-0001Gj-Qj
	for <alsa-devel@alsa-project.org>; Mon, 04 Oct 2010 08:51:26 +0100
Received: from c-83-233-18-148.cust.bredband2.com ([83.233.18.148]
	helo=[192.168.8.102]) by hutte.canonical.com with esmtpsa
	(TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32) (Exim 4.69)
	(envelope-from <david.henningsson@canonical.com>) id 1P2fpW-0002C0-Fu
	for alsa-devel@alsa-project.org; Mon, 04 Oct 2010 08:51:26 +0100
In-Reply-To: <AANLkTi=h+ZKXNdhmC1BtTbBaGF6_V+uD2ZO7sx4WMJMW@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 2010-10-02 04:11, Raymond Yau wrote:
> 2010/9/29 David Henningsson<david.henningsson@canonical.com>
>
>> On 2010-09-28 06:07, Raymond Yau wrote:
>>> 2010/9/28 Colin Guthrie<gmane@colin.guthr.ie>
>>>
>>>>
>>>>
>>>> And today, one of the Canonical guys published his version of a tool to
>>>> help here:
>>>> http://thread.gmane.org/gmane.comp.audio.pulseaudio.general/7542
>>>>
>>>> Hope this helps.
>>>>
>>>> Col
>>>>
>>>>
>>>>
>>> why did runtest.sh use a format  FLOAT64_LE which was not supported by PA
>> ?
>>
>> runtest.sh isn't meant to be used directly in that way, you're supposed
>> to run "alsamixertest". Try "alsamixertest -r" and "alsamixertest -h" to
>> get started. (Perhaps I should rename the .sh file to something else.)
>>
>> That said, if you find a good use case where you want to use it directly
>> and need a different sample format - patches welcome (as long as they
>> don't break something else).
>>
>>
> I just try to see whether this tool can help me to calibrate the 10 band
> gain/atten controls of the hardware equalizer of au8830.

Hmm...there is currently no way to specify control name(s) manually, 
perhaps I should add such a test/switch.

> Have anyone test your tool on the sound card with ac97 codec ?

I don't think so, no.

> It seem that the program keep complain about those controls without dB scale
> (e.g. AC97 3D Control - depth and rear depth , .) with the emulated intel8x0
> driver  and no volume control with the emulated sb16 in virtualbox

It's a righteous warning if you ask me - all volume controls should 
provide dB information, or we don't know what they actually do. It 
doesn't disturb the rest of the test as long as you have set the value 
manually to something that does not destroy the audio.

> Your program seem really behave as same as pulseaudio server , set the dB
> value of control but don't verify the dB value can be set by re-reading the
> value since dB ->  volume conversion

Yes, I do verify: I read back the set value because it is not always the 
same as the actual value I tried to set.

> Even though your program start at 0dB  , ac97 volume controls are in 1.5dB
> per step but your program use 2 dB step

I just released a new version where you can set the step size at the 
command line:

https://edge.launchpad.net/~diwic/+archive/maverick/+files/alsamixertest_48.11.tar.gz

If 1.5 dB is pretty standard in both HDA and AC'97, I should probably 
change it to 1.5 dB by default.

> Still finding why the program running into infinite loop and try to set dB
> to -7xx dB , however amixer does output the min dB when 0%

If you're still having an infinite loop in the 48.11 version, could you 
please send the output of the tool with the -v (verbose) switch to me 
privately? Thanks!

-- 
David Henningsson, Canonical Ltd.
http://launchpad.net/~diwic
