From: Thomas Rabe <raven@drehmoment.org>
Subject: Re: questions about usbmidi
Date: Thu, 10 Apr 2003 16:38:19 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3E9581DB.7060404@drehmoment.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


Clemens Ladisch wrote:
> Thomas Rabe wrote:
> 
>>Clemens Ladisch wrote:
   >>>Well, this may indicate that the MIDI part works and that the error
is in
>>>some other part of the driver. Does the oops still happen when you don't
>>>call snd_usb_create_midi_interface?
>>
>>the driver works fine without calling snd_usb_create_midi_interface (no
>>errors, all audiochannels are available).
> 
> 
> The initialization code does nothing USB-related except allocing some URBs
> and submitting the input URBs. Please try to remove the call to
> snd_usbmidi_submit_urb at the end of _create_midi_interface.

removing the snd_usbmidi_submit_urb call also oopses. i tried some
endpoint configs like below but each crashing my machine:

.data = & (const snd_usb_midi_endpoint_info_t) {
		  .out_ep =0x06,
		  .in_ep = 0x06,
		  .out_cables =	0x003,
		  .in_cables =	0x003
}

last msg:
created 2 output and 2 input ports


.data = & (const snd_usb_midi_endpoint_info_t) {
		  .out_ep =0x06,
		  .out_cables =	0x003,
		  }

last msg:
created 2 output and 0 input ports

.data = & (const snd_usb_midi_endpoint_info_t) {
		 }

last msg:
created 0 output and 0 input ports



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
