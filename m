From: Daniel Mack <zonque@gmail.com>
Subject: Re: How to add a new MIDI device to the usbaudio driver
Date: Wed, 24 Aug 2011 12:29:45 +0200
Message-ID: <CACTFLAPMg75au0VX_rAF3dLRsSyX8Wex+LFj7pfPXygvZrR7qw@mail.gmail.com>
References: <4E5234F0.8000502@amlie.name>
	<CACTFLAMA08qqaNALA1dksxVN_yAwXnONxXadeuUb1Owkz6VwsA@mail.gmail.com>
	<4E52401C.8030605@amlie.name> <4E537524.9010303@ladisch.de>
	<4E537BE9.4050004@amlie.name>
	<CACTFLAPzug5yxmhxDKocdLt-eoHXr6nOwmyOqWkEJ_vjqNff6w@mail.gmail.com>
	<4E53959A.7090702@amlie.name>
	<CACTFLAMh2Brji5NBOZjtDmyP-DPR3S4HCP93SO0sE9J7xEn3NQ@mail.gmail.com>
	<4E53A748.4070404@amlie.name>
	<CACTFLANSwy66KAyLbxyy=pB9Z+K+r7ur564Frx7ep1W_JY=XCQ@mail.gmail.com>
	<4E53AAE4.2070303@amlie.name>
	<CACTFLANav3woJuXjdpsYEqvvbbTb53S0d2MtVoq9EByv-j-cxw@mail.gmail.com>
	<4E54B1A5.5080507@amlie.name>
	<CACTFLAPkyYNxRkd=9R12U8_dBbkJQZ=LSXr9a8au_Kfc5R78fQ@mail.gmail.com>
	<4E54CF09.90001@amlie.name>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gy0-f179.google.com (mail-gy0-f179.google.com
	[209.85.160.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 9DB6524989
	for <alsa-devel@alsa-project.org>;
	Wed, 24 Aug 2011 12:29:46 +0200 (CEST)
Received: by gyd8 with SMTP id 8so743766gyd.38
	for <alsa-devel@alsa-project.org>; Wed, 24 Aug 2011 03:29:45 -0700 (PDT)
In-Reply-To: <4E54CF09.90001@amlie.name>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Kristian Amlie <kristian@amlie.name>
Cc: alsa-devel@alsa-project.org, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

On Wed, Aug 24, 2011 at 12:14 PM, Kristian Amlie <kristian@amlie.name> wrote:
> On 08/24/11 10:32, Daniel Mack wrote:
>> Hmm? Can you trace where this happens and which dereferenced pointer
>> is NULL? I don't see it, sorry.
>
> The attached patch solves the NULL pointer dereference. With this patch,
> the device shows up as a MIDI device, but still produces no events
> according to aseqdump.

Eh, quite obvious. Thanks for spotting.

> I did a more thorough examination of the calls to usb_control_msg() from
> the ftdi_sio driver, and this is what I came up with:
>
> Plugging it in:
>
> Calling usb_control_msg() from read_latency_timer(): value=0, index=0
> Calling usb_control_msg() from write_latency_timer(): value=1, index=0
> usb 3-2: FTDI USB Serial Device converter now attached to ttyUSB0
>
> Starting cu:
>
> Calling usb_control_msg() from ftdi_open(): value=0, index=0
> Calling usb_control_msg() from ftdi_set_termios(): value=8, index=0
> Calling usb_control_msg() from change_speed(): value=16696, index=0
> Calling usb_control_msg() from ftdi_set_termios(): value=0, index=0
> Calling usb_control_msg() from update_mctrl(): value=771, index=0
> Calling usb_control_msg() from ftdi_set_termios(): value=8, index=0
> Calling usb_control_msg() from change_speed(): value=49230, index=0
> Calling usb_control_msg() from ftdi_set_termios(): value=0, index=0
> Calling usb_control_msg() from ftdi_set_termios(): value=8, index=0
> Calling usb_control_msg() from change_speed(): value=49230, index=0
> Calling usb_control_msg() from ftdi_set_termios(): value=0, index=0
> Calling usb_control_msg() from ftdi_set_termios(): value=8, index=0
> Calling usb_control_msg() from change_speed(): value=49230, index=0
> Calling usb_control_msg() from ftdi_set_termios(): value=4881, index=1024

Ok - can you play around with these commands and add them to the MIDI
driver? The stubs are all there now, and  I think all that's missing
is the termios call and maybe write_latency_timer(). I could prepare
another patch, but I think it's faster if you just try around which
command sequence helps :)


Daniel
