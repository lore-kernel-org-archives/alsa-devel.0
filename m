From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: MAYA44 USB audio device doesn't work with  1.0.4.
Date: Thu, 27 May 2004 15:14:13 +0200 (METDST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0405271511470.6236-100000@studcom.urz.uni-halle.de>
References: <6.0.0.22.2.20040527223152.01f32510@mail.audioslack.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <6.0.0.22.2.20040527223152.01f32510@mail.audioslack.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Luke Yelavich <luke@audioslack.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Luke Yelavich wrote:
> below is the information I get when attempting to use this soundcard under
> a 2.6.6 kernel with alsa drivers 1.0.5rc1 and hotplug.
>
> dmes:
> usbaudio: device 3 audiocontrol interface 0 has 1 input and 1 output AudioStreaming interfaces

This is the OSS driver (audio).  Put the line

audio

into the file /etc/hotplug/blacklist to prevent it from loading (or
deactivate it in the kernel config).


HTH
Clemens




-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
