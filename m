From: Thomas Rabe <raven@drehmoment.org>
Subject: Re: questions about usbmidi
Date: Thu, 10 Apr 2003 09:29:49 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3E951D6D.2040304@drehmoment.org>
References: <Pine.HPX.4.33n.0304100837520.4179-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.HPX.4.33n.0304100837520.4179-100000@studcom.urz.uni-halle.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Clemens Ladisch <clemens@ladisch.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Clemens Ladisch wrote:
> Thomas Rabe wrote:
> 
>>Clemens Ladisch wrote:
>>
>>>If this is the only endpoint in the interface, you can omit the endpoint
>>>number and let the driver autodetect it.
>>
>>i don't really know if autodetection will work (for the lsusb see
>>below).
> 
> 
> All endpoints are in one interface, so it wouldn't work.

will i have more luck with snd_usbmidi_create_rawmidi? if yes, should i 
declare the relevant functions/structs needed for rawmidi in usbaudio.h 
or cut'n paste the stuff from usbmidi.c in my driver file?

>>the real problem are the kernel-oopses, the last message i get:
>>ports are created.
>>
>>8<------------------------------------------------------
>>Apr  9 17:57:05 konstruktor kernel: ALSA ../alsa-kernel/usb/usbmidi.c:782: created 2 output and 2 input ports
>>Apr  9 17:57:05 konstruktor kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000004
> 
> 
> Well, this may indicate that the MIDI part works and that the error is in
> some other part of the driver. Does the oops still happen when you don't
> call snd_usb_create_midi_interface?

the driver works fine without calling snd_usb_create_midi_interface (no 
errors, all audiochannels are available). i just wondering why there is 
no error return but the oops. it's very hard to try out hacks, because i 
have to reboot after the oops (can't rmmod the driver and other alsa 
modules).


> HTH
> Clemens


Greetings,

Thomas Rabe.



-- mail: raven at drehmoment dot org
-- home: http://hal9000.drehmoment.org
-- more: http://drehmoment.org



-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
