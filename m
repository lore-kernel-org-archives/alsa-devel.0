From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: gmplayer error with ALSA output plugin
Date: Mon, 26 Jul 2004 11:35:55 +0200 (METDST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0407261134000.1841-100000@studcom.urz.uni-halle.de>
References: <1090793916.14951.107.camel@mindpipe>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <1090793916.14951.107.camel@mindpipe>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Lee Revell <rlrevell@joe-job.com>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Lee Revell wrote:
> When I select the 'ALSA 0.9.x/1.0.x' option for audio output in
> gmplayer, the sound seems to work, but I get tons of popup windows with
> this error:
>
> alsa-control: mixer attach /dev/mixer: no such file or directory

"/dev/mixer" is an OSS device.  The ALSA mixer would have a device
name like "hw:0".

Apparently, gmplayer doesn't change the device name when changing the
device type.


Regards,
Clemens




-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
