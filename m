From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: =?gb2312?B?UHJvYmxlbSBhYm91dCBQQ00gZGV2aWNlIG9uIGlNWDIxIGJvYXJk?=
Date: Wed, 12 Jan 2005 17:16:05 +0100 (MET)
Message-ID: <Pine.HPX.4.33n.0501121715350.22892-100000@studcom.urz.uni-halle.de>
References: <41E52C1D.000001.03386@TCLmail>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <41E52C1D.000001.03386@TCLmail>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: =?gb2312?B?c3Vkb25n?= <sudong@tcl.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

sudong wrote:
> I write an auido driver for iMX21 board based on ALSA. I have loaded the
> driver module and created the node in /dev/snd. But when I used aplay to play
> audio file , such as "aplay -D "hw:0,0" 1.wav", it said "Unknown the PCM
> hw:0,0".

Does the PCM device appear in /proc/asound/devices?

What is the exact error message?


Clemens



-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
