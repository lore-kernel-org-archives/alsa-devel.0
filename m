From: Krzysztof Foltman <wdev@foltman.com>
Subject: Re: [PATCH 1/1] ALSA: usb-audio: add support for Akai
 MPD16
Date: Thu, 20 May 2010 08:49:14 +0100
Message-ID: <4BF4E97A.9020209@foltman.com>
References: <1274299579-12990-1-git-send-email-wdev@foltman.com>
	<4BF4E440.9030105@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from outbound-mail-158.bluehost.com (cpoproxy2-pub.bluehost.com
	[67.222.39.38]) by alsa0.perex.cz (Postfix) with SMTP id 06E2F103991
	for <alsa-devel@alsa-project.org>;
	Thu, 20 May 2010 09:49:18 +0200 (CEST)
Received: from [188.141.6.113] (helo=[192.168.1.12])
	by box517.bluehost.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.69) (envelope-from <wdev@foltman.com>) id 1OF0VI-00075J-08
	for alsa-devel@alsa-project.org; Thu, 20 May 2010 01:49:16 -0600
In-Reply-To: <4BF4E440.9030105@ladisch.de>
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

On 05/20/2010 08:26 AM, Clemens Ladisch wrote:

>  Not that it really matters, but if the port variable were unsigned,
>  you could just check for "port <= 1".

True.

>  It is possible that ALSA's buffer does not yet contain the entire
>  SysEx message; in this case, the driver would send off the partial
>  message without the 0x10 in the first byte.

In that case, the length wouldn't be updated to include the partial 
message, so it would send all the previous messages in the transmit 
buffer, but not the new (incomplete) message, and it would lose the 
incomplete message (because the code would then expect the message to 
end up at offset 0 instead of transfer_buffer_length, which isn't 
happening).

Anyway, the only correct solution is - as you say - to keep peeking 
until skippable content or a full valid SysEx is found. There are still 
some nasty corner cases here, too (for example, a SysEx that's longer 
than accepted maximum), but it should work. I'll try to implement it 
that way.

>  This MIDI port isn't an external port (which would imply that any
>  random device could be connected to it).  There is no macro for
>  internal ports; just use PORT_INFO(... _MIDI_GENERIC | _HARDWARE).

True. It isn't the other end of a MIDI socket, it's a USB version of the 
MIDI output of the device.

What about the oversized comment block about MPD16 SysEx messages - 
should it remain in the source file, or should I move it to a text file 
or remove it altogether?

Thanks  for the comments/ideas!

K.
