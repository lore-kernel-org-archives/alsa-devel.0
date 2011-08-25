From: Kristian Amlie <kristian@amlie.name>
Subject: Re: How to add a new MIDI device to the usbaudio driver
Date: Thu, 25 Aug 2011 13:28:33 +0200
Message-ID: <4E5631E1.7050400@amlie.name>
References: <4E5234F0.8000502@amlie.name>	<CACTFLAMA08qqaNALA1dksxVN_yAwXnONxXadeuUb1Owkz6VwsA@mail.gmail.com>	<4E52401C.8030605@amlie.name>	<4E537524.9010303@ladisch.de>	<4E537BE9.4050004@amlie.name>	<CACTFLAPzug5yxmhxDKocdLt-eoHXr6nOwmyOqWkEJ_vjqNff6w@mail.gmail.com>	<4E53959A.7090702@amlie.name>	<CACTFLAMh2Brji5NBOZjtDmyP-DPR3S4HCP93SO0sE9J7xEn3NQ@mail.gmail.com>	<4E53A748.4070404@amlie.name>	<CACTFLANSwy66KAyLbxyy=pB9Z+K+r7ur564Frx7ep1W_JY=XCQ@mail.gmail.com>	<4E53AAE4.2070303@amlie.name>
	<CACTFLANav3woJuXjdpsYEqvvbbTb53S0d2MtVoq9EByv-j-cxw@mail.gmail.com>
	<4E555646.2030209@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from oproxy6-pub.bluehost.com (oproxy6-pub.bluehost.com
	[67.222.54.6]) by alsa0.perex.cz (Postfix) with SMTP id 79C9524466
	for <alsa-devel@alsa-project.org>;
	Thu, 25 Aug 2011 13:33:11 +0200 (CEST)
In-Reply-To: <4E555646.2030209@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

Gentlemen, I believe we've got ourselves a new driver!

It turns out the problem I was having earlier where MIDI events didn't
arrive, was a pilot error (reloading the wrong module). With my latest
patch, both MIDI input and output works. I'll send it in a separate
email for review.

Thanks a lot to Daniel and Clemens! Your help was a invaluable!

One caveat I have discovered with the patch: If you keep the instrument
plugged in, but reload the driver, then the driver gets out of sync with
the MIDI messages and won't report any. This seems to be because, in the
stream, the message type is cached and subsequent messages do not report
what type of message they are unless they are switching to a new type
(going from control message to note message, for example). You can reset
the stream by manually generating MIDI messages of different types (turn
the volume knob while pressing a few notes), or eventually the
instrument will reset itself and send the type anyway. So it's not
critical, but would be nice to fix. I'm not sure how to solve it though...

On 08/24/11 21:51, Clemens Ladisch wrote:
>> +		/* reset the port */
>> +		err = snd_usbmidi_ftdi_command(umidi, 0, 0);
>> +		if (err < 0)
>> +			break;
>> +
>> +		/* set mctrl */
>> +		err = snd_usbmidi_ftdi_command(umidi, 1, 0x303);
>> +		if (err < 0)
>> +			break;
> 
> The chip reads its initial configuration from the EEPROM, so these
> commands might not be necessary.

You're right, they're not.

>> +		/* set baud rate */
>> +		err = snd_usbmidi_ftdi_command(umidi, 3, 0xc04e);
> 
> Replace 0xc04e with 0x60 to get exactly 31250 baud.

That did the trick! Thanks!

> Furthermore, the FT232RL chip sends two modem status bytes in its
> packets, so we need something like this to prevent them from being
> interpreted as MIDI:

Done!

-- 
Kristian
