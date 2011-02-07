From: Anssi Hannula <anssi.hannula@iki.fi>
Subject: Re: ANNOUNCE: NVIDIA HDMI audio documentation
Date: Mon, 07 Feb 2011 22:49:02 +0200
Message-ID: <4D505ABE.60601@iki.fi>
References: <74CDBE0F657A3D45AFBB94109FB122FF0310C8EA6D@HQMAIL01.nvidia.com>
	<4D4DAD7B.20406@iki.fi>
	<74CDBE0F657A3D45AFBB94109FB122FF0310F5FC8D@HQMAIL01.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sirokuusama.dnainternet.net (sirokuusama.dnainternet.net
	[83.102.40.133]) by alsa0.perex.cz (Postfix) with ESMTP id BCB38244F9
	for <alsa-devel@alsa-project.org>; Mon,  7 Feb 2011 21:49:07 +0100 (CET)
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF0310F5FC8D@HQMAIL01.nvidia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Stephen Warren <swarren@nvidia.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 07.02.2011 19:39, Stephen Warren wrote:
> Anssi Hannula wrote:
>> On 04.02.2011 00:37, Stephen Warren wrote:
>>> I have written a document re: how to understand and trouble-shoot issues
>>> with audio-over-HDMI on NVIDIA GPUs. It's available at:
>>>
>>> ftp://download.nvidia.com/XFree86/gpu-hdmi-audio-document/gpu-hdmi-audio.html
>>
>> A nice document, thanks :)
>>
>> A couple of comments:
> 
> Thanks very much for the feedback.
> 
>> ...
>>> 12.4. Verify Your ELD Is Valid
>>
>> This section has "44100 48000 88200" multiple times.
> 
> I'm having trouble finding this. Can you quote a bit more text to highlight
> exactly where/what the problem is?

The examples have:
> sad0_rates          [0xe0] 44100 48000 88200
> HDMI: supports coding type LPCM: channels = 2, rates = 44100 48000 88200, bits = 16 20

While you are not claiming they are correct, it would probably be best
to mention that in the text (and/or in the issues chapter).

>> Maybe one should mention that those are currently shown incorrectly (as
>> per "[alsa-devel]  HDA - hdmi_show_short_audio_desc puts wrong rates in
>> eld#N").
> 
> Am I correct that this isn't patched yet? I couldn't see anything that
> touched this in the git log, nor any following to this email:
> 
> http://mailman.alsa-project.org/pipermail/alsa-devel/2011-January/035557.html

Yes, the issue is not yet fixed.

I planned to provide a patch but I haven't had the time to do it yet
after all.

> Thanks again.


-- 
Anssi Hannula
