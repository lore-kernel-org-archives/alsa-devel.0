From: Patrick Shirkey <pshirkey@boosthardware.com>
Subject: Re: Re: How to support multiple open in low-level driver
Date: Tue, 07 Jan 2003 00:52:14 +0900
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3E19A62E.20402@boosthardware.com>
References: <Pine.LNX.4.33.0301061519390.551-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from www7.networkshosting.com (www7.networkshosting.com [66.96.128.106])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with SMTP id RAA02282
	for <alsa-devel@alsa-project.org>; Mon, 6 Jan 2003 17:04:17 +0100
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Jaroslav Kysela wrote:

> 
> We use subdevices mainly for hardware which can mix several streams 
> together. It's quite impractical to have 32 devices with exactly same 
> capabilities. The subdevices can be opened without a specific address, so 
> the first free subdevice is opened. Also, we temporary use subdevices for 
> hardware with alot of streams (I/O connectors) - for example MIDI. There 
> are several limits given by used minor numbers (8 PCM devices per card, 8 
> MIDI devices per card etc.).
> 

In the interest of correct documentation how is this explained:

hw:0,0

The first zero is the card number?
The second zero is the device number?

What happens for sound devices that are not cards? For example the usb 
quattro.

Up until now I have rationalised it as the first zero is the device, the 
second zero is the subdevice and the number of streams that the 
subdevice can do hardware mixing for would become the subsubdevices.

 From your message above do I understand we should call every sound 
device a sound card.

-- 
Patrick Shirkey - Boost Hardware Ltd.
For the discerning hardware connoisseur
Http://www.boosthardware.com
Http://www.djcj.org - The Linux Audio Users guide
========================================

Being on stage with the band in front of crowds shouting, "Get off! No! 
We want normal music!", I think that was more like acting than anything 
I've ever done.

Goldie, 8 Nov, 2002
The Scotsman



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
