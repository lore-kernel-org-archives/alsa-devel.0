From: Charles Eidsness <charles.eidsness@ieee.org>
Subject: Re: S24_LE Mode for USB Driver
Date: Wed, 13 Aug 2008 08:39:29 -0400
Message-ID: <48A2D601.8070009@ieee.org>
References: <489B5A4E.3040903@ieee.org>
	<s5htzdpi62s.wl%tiwai@suse.de>	<48A2C2D8.4040401@ladisch.de>
	<s5h63q59k2u.wl%tiwai@suse.de>
Reply-To: charles.eidsness@ieee.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp110.rog.mail.re2.yahoo.com (smtp110.rog.mail.re2.yahoo.com
	[206.190.37.0]) by alsa0.perex.cz (Postfix) with SMTP id CEBF3244F4
	for <alsa-devel@alsa-project.org>;
	Wed, 13 Aug 2008 14:39:31 +0200 (CEST)
In-Reply-To: <s5h63q59k2u.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> At Wed, 13 Aug 2008 13:17:44 +0200,
> Clemens Ladisch wrote:
>> Takashi Iwai wrote:
>>> Charles Eidsness wrote:
>>>> It looks like the parse_audio_format_i_type function at line 2369 of usbaudio.c
>>>> (linux v2.6.23) doesn't support the case where  bSubframeSize (fmt[5]) = 4 bytes
>>>> and  bBitResolution (fmt[6]) = 24 bits, which should correspond to a S24_LE (or
>>>> BE) type. I'm developing a new USD DAC which supports this mode (24-bit sample
>>>> in a 4 byte package). Right now Linux sends me S32_LE formated data, which is
>>>> wrong. Would it be possible to expand this function to support S24_LE/BE? It
>>>> would only require adding a few lines of code.
>>> Yes, it's possible, of course.
>>>
>>> BTW, is this behavior strictly defined?  I fail to find in the
>>> usb-audio spec that bBitResolution specifies the lower bits, not the
>>> higher bits...
>> The spec assumes that 24-bit samples use S24_3LE.  24-bit samples in
>> 32-bit words are an extension that must be handled with some device-
>> specific code (like with the UA-1000).
>>
>> (The audio 2.0 spec allows 32-bit words, and the wording seems to imply
>> that samples are aligned to the most significant bit, i.e., that S32_LE
>> would be used in this case.)
> 
> OK, thanks for clarification.
> 

Right, I guess I should have read the spec a little closer (for anyone following 
along without the Spec handy), from section 2.2.2 of the USB Audio Data Formats 
Spec (page 9 of http://www.usb.org/developers/devclass_docs/frmts10.pdf):

"AudioStreaming endpoints must be constructed in such a way that a valid 
transfer can take place as long
as the reported audio subframe size (bSubframeSize) is respected during 
transmission. If the reported bits
per sample (bBitResolution) do not correspond with the number of significant 
bits actually used during
transfer, the device will either discard trailing significant bits 
([actual_bits_per_sample] >
bBitResolution) or interpret trailing zeros as significant bits 
([actual_bits_per_sample] <
bBitResolution)."

Unfortunately for me this means that if I want to avoid the extra discretization 
distortion that comes with truncating those bottom 8-bits I'll have to add a 
dither function to my DAC.

Thanks!
Charles
