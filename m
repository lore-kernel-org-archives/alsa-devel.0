From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: usbaudio won't do 24-bit or 32-bit i/o,
 and won't do 96000 frames per second
Date: Thu, 05 Dec 2002 16:19:22 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0212051549290.19058-100000@studcom.urz.uni-halle.de>
References: <3DEF3911.4060206@monmouth.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <3DEF3911.4060206@monmouth.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: "John S. Denker" <jsd@monmouth.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

John S. Denker wrote:
> Request #1: USB driver supporting 24-bit i/o.
> Request #2: USB driver supporting 96000 frames per second.

What you want is already supported by the snd-usb-audio driver. IIRC
Patrick Shirkey reported that 24bit@96kHz works with the M-Audio Quattro.

> I bought an Extigy, which is capable of 24-bit i/o. It is
> also capable of digitizing 96000 frames per second.
>
> The problem is, the alsa usbaudio driver seems to know
> nothing of such capabilities.

USB devices announce their capabilities in their descriptors. Please post
the output of lsusb and the output of "od -t x1 /proc/bus/usb/001/xxx"
(xxx is the device number; try all files there, the one I want to see has
"1E 04" somewhere in the first line).


HTH
Clemens



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
