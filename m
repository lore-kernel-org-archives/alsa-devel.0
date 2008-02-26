From: "Demian Martin" <demianm@attglobal.net>
Subject: Re: Via VT82xx VT1708 ICE1724HT and higher
Date: Tue, 26 Feb 2008 10:07:17 -0800
Message-ID: <004401c878a2$6cade570$d450a8c0@PDSMain2>
References: <mailman.2073.1204045163.2095.alsa-devel@alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from n27.bullet.mail.mud.yahoo.com (n27.bullet.mail.mud.yahoo.com
	[68.142.200.142]) by alsa0.perex.cz (Postfix) with SMTP id 794C624682
	for <alsa-devel@alsa-project.org>; Tue, 26 Feb 2008 19:09:18 +0100 (CET)
In-Reply-To: <mailman.2073.1204045163.2095.alsa-devel@alsa-project.org>
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

Pavel:
Thanks for the insight. I thought I was doing something wrong since no one
else has noticed.
I tried your suggestion to use plughw:0,1  and the verbose output looks
fine, the data rate shifts fine (I'm watching the L/R clock on the input to
the DAC on an external DAC)  but no audible sound comes out the converter
unless it's a 16 bit 44.1 file. The 24 bit stuff is not getting converted
into something useful to the DAC. Should I check to see if the data clock is
48X the LR clock? 

What info do you need from me to look deeper?

I can supply a sample clip of a 176.4 KHz recording from Reference
Recordings if it would be helpful. I'm also testing with the samples from
Linn and Gimmel.

I looked at the Plug plugin but have not been able to figure out how to
configure it for my needs. There is way too much marginal information on the
web and little that directs me to an optimum setting.
                           -Demian



From: Pavel Hofman <pavel.hofman@insite.cz>
Subject: Re: [alsa-devel] Via VT82xx VT1708 ICE1724HT and higher
	sample rate/bit depth files through SPDIF
To: Demian Martin <demianm_1@yahoo.com>
Cc: alsa-devel@alsa-project.org
Message-ID: <47C423E4.4060900@insite.cz>
Content-Type: text/plain; charset=windows-1252; format=flowed

Hi Martin,

> 
> First- sample rate
> 
> Even though the documents claim that it will play at 176.4 KHz and 192KHz
> whenever I play a file at these rates it down converts to ? the rate
(88200
> and 96000). I tested this with the ICE1724HT (Juli@) which has almost the
> same core, I never could get 176.4KHz at the SPDIF output. I confirmed
that
> the ICE1724 will play the file at 176.4KHz in Windows so its not a
hardware
> limitation. I tried to do the same with the VT1708 (on a Via CX700
chipset)
> and the Windows driver wouldn?t let me at anything other than 48000. 

I spent a few days on this issue and confirm that ICE1724HT cannot
output 176.4kHz from its internal SPDIF transmitter, WHEN clocked by its
internal clock circuits. A scope hooked to corresponding pins/outputs
revealed the following:

All I2S lines output correct 176.4kHz signal, i.e. D/A codecs receive
proper signal.

However, I did not find a way to force ICE1724 to output 176.4kHz, it
always drops to 88.2kHz, no matter what MT01/MT02 combination is. The 
same happens with windows drivers of my Prodigy 192. The sequence is: 
44.1, 48, 88.2, 96, 88.2, 192

I have not seen any manufacturer of Envy-based cards revealing this
deficiency. The "preliminary" datasheet we all use mentions only that
the chip forces the 128x mode when switched to 176.4kHz. I believe the 
output of 88.2kHz is an undocumented feature or perhaps even a bug of 
the chip.

Juli is a card whose manufacturer may be aware of the problem. It is not
clocked by ICE1724 internal clocks fed by the two crystals. Instead, the 
crystals also provide signal to external circuits generating
clock signals of required frequency, feeding the chip in slave mode. The 
circuitry is controlled by ice1724 GPIOs.

This way the ICE1724 is not aware of its clocking frequency and cannot 
thus mis-configure its SPDIF transmitter. The windows driver does
output proper 176.4kHz.

I am working on Juli driver and have been analyzing this beast for a
few nights. The special clocking is already working at home :)


> Second, the only way I can get the 24 bit files out in a form that the
card
> can play is to pass them through dmix. But I need to reconfigure dmix for
> each sample rate. And I?m not convinced that it isn?t resampling twice,
both
> at the input and the output. Or how to configure the buffers etc. to
prevent
> underruns even when the only conversion is to pass a 24 bit file to the
> card.

ICE cards use 32bits format. Try aplay -v -D plughw:0 24bit.wav and you
will see the conversion to 32 bits done by the plug plugin, no dmix
involved.


> 
> I?m trying to build a high quality music server that will pass the files
to
> either the internal or an external DAC at the bit depth and sample rate
they
> were recorded at. I have tried to understand the various plugs and
settings
> but it seems they are all focused on mixing various streams. I want to
send
> the files unmixed to the output. I can?t figure out what set of plugs and
> settings in asound.conf would enable this.

Check the plug plugin.

Regards,

Pavel Hofman.
-----------------
