From: JoDaY <jo.day@laposte.net>
Subject: Re: us-122 firwareloader
Date: Mon, 31 May 2004 23:26:21 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <40BBA2FD.1020309@laposte.net>
References: <E1BUd3Y-0003tD-KA@sc8-sf-list2.sourceforge.net> <40BB5314.9080404@laposte.net> <20040531171809.GA640@tuba.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20040531171809.GA640@tuba.home>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Martin Langer <martin-langer@gmx.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Martin Langer wrote:
> On Mon, May 31, 2004 at 05:45:24PM +0200, JoDaY wrote:
> 
>>Hi all,
>>
>>I've 2 install of linux, the first one is the oldest where hotplug
>>is able to load firmware when I plug a Tascam us-122.
>>But if I use snd-usb-usx2y.o (seen in depmod), hotplug is not able to 
>>load the right firmware... The usb led is not lightened :(
> 
> 
> Sounds like you are using the old tascam-loader instead of usx2yloader. Have
> you installed both usx2yloader parts (in alsa-tools and alsa-firmware)?
> 

You're right, the one which is able to load the firmware and make the 
LED of the card lighting is an old version.

I've tried to change it with alsa-tools and alsa-firmware:

- snd-usb-usx2y module is loading when I plug the us-122 card
- I can see "Bus 002 Device 008: ID 1604:8007 Tascam US-122 Audio/Midi 
Interface" with lsusb

But the usb LED is always off :(


I can also see :
[USX2Y          ]: USB US-X2Y - TASCAM US-X2Y
                      TASCAM US-X2Y (1604:8007 if 0 at 002/008)
in /proc/asound/card

Is the LED off normal ? Am I near of the goal ? :)

Thanks you lot !

Jo



-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
