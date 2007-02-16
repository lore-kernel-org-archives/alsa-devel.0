From: Jean-Michel =?ISO-8859-1?Q?Pour=E9?= <jmpoure@free.fr>
Subject: Re: Default device with fallback
Date: Fri, 16 Feb 2007 11:01:56 +0100
Message-ID: <1171620116.9130.6.camel@localhost>
References: <75b66ecd0702151749r7df799f1pe4cd832af58ae443@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <75b66ecd0702151749r7df799f1pe4cd832af58ae443@mail.gmail.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Lee Revell <rlrevell@joe-job.com>
Cc: Alsa Dev <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Dear Lee,

I am really new to Alsa, so my opinion may not matter:

I have three sound card : one Edirol UA-25 and two Terratec Aureon USB
MK2. The problem is that when unplugin one or several devices, the
plughw:x,y number may change. This is the main problem.

In the best approach, I would prefer to be able to set plughw:x,y
numbers once for all. I hope this can be done using Udev, but I am not
sure.

Would it be possible to address devices using product IDs directly. I
know this sounds incredible, but each device usually has a unique ID
somewhere.

So in place of writing plughw:x,y, we would write productid:xyzzer. This
would allow plughw:x,y to continue to behave like today. The only
difference is that users would really have a unique way of naming
hotplugable devices.

Kind regards,
Jean-Michel


> Lately there's been a lot of discussion on linux audio lists about the
> best way to handle the default device, in the face of multiple cards
> some of which could be hot-pluggable and might even be identical.
> 
> Module indices can help in a pinch but are no solution - they require
> root access and can't change the default device without requiring all
> sound apps to be restarted.
> 
> gnome-sound-properties comes closest to solving the problem - it
> creates an .asoundrc that defines the "default" device for each user
> (compare KDE which does not even try).  But if the default device is
> defined to a USB audio interface, when the device is unplugged apps
> will fail rather than falling back to the next available device.
> 
> How hard would it be to extend ALSA to allow defining a default PCM
> that automatically falls back to the first device present if
> unplugged?
> 
> As far as I can tell this would solve the ALSA device selection
> problem completely (ignoring OSS emulation which is increasingly
> irrelevant with the new Flash and Skype releases).


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
