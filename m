From: Steve Longerbeam <stevel@embeddedalley.com>
Subject: Re: a new synthesizer driver
Date: Thu, 19 Jul 2007 11:18:49 -0700
Message-ID: <469FAB09.7000807@embeddedalley.com>
References: <469EBE3A.30002@embeddedalley.com>
	<1184826757.2575.1200931737@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp101.biz.mail.mud.yahoo.com (smtp101.biz.mail.mud.yahoo.com
	[68.142.200.236]) by alsa0.perex.cz (Postfix) with SMTP id E1EF42433E
	for <alsa-devel@alsa-project.org>;
	Thu, 19 Jul 2007 20:18:57 +0200 (CEST)
In-Reply-To: <1184826757.2575.1200931737@webmail.messagingengine.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <cladisch@fastmail.net>
Cc: ALSA devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Clemens Ladisch wrote:
> Steve Longerbeam wrote:
>   
>> I'm embarking on a big task: writing a new synthesizer driver. My device 
>>     
>
> Which one?
>   

it's an embedded SOC, the LSI Zevio 1020, here's a link:

http://www.lsi.com/consumer_home/products_home/standard_product_ics/application_processors/zevio1020/index.html

>   
>> has all the ingredients for a MIDI wavetable sythesizer: 64 voices, each 
>> voice with envelope, pitch, and LFO controls. Also global effects like 
>> reverb. It's similar to the emu10k1.
>>
>> So my first question would be, is the synth code under synth/emux/ 
>> general enough to use for a different synthesizer chip? Ie, can I 
>> implement my own operators in 'struct snd_emux_operators' and pass that 
>> to snd_emux_register() ?
>>     
>
> Probably not.  The sound font loading code is somewhat generic, but that
> is because the sound font format was designed to be the equivalent of
> the Emu chips' hardware capabilities.
>
> All that code has been written for Emu hardware.  How much it must be
> changed depends on how different your hardware is.
>
>   
>> Would it be a simple matter to make synth/emux/ a generic synth layer, 
>> by moving all the source in synth/emux/ up one level to synth/, and then 
>> rename all functions and data structures starting with "snd_emux" to 
>> "snd_synth" ?
>>     
>
> I think it is possible to reuse some of that code, but it wouldn't be
> as easy as just renaming some things.
>
> (The generic synth code is supposed to be in core/seq/seq_midi_emul.c.
> The synth/emux directory just exists to factor out common code of the
> Emu8000 and Emu10k1 drivers.)
>   

ok, that's what it looked like.

Steve
