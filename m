From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH] add aplaymidi & arecordmidi utils
Date: Tue, 24 Feb 2004 18:43:38 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0402241836390.5168-100000@studcom.urz.uni-halle.de>
References: <200402241726.RAA31256@liam2.demon.co.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <200402241726.RAA31256@liam2.demon.co.uk>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Will <walsac2@liam2.demon.co.uk>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Will wrote:
> How easy would it be to make aplaymidi be able to adjust the playback speed
> like playmidi?  (playmidi -t 0.5 music.mid plays at twice the default speed)

Very easy.

> How easy would it be to make aplaymidi be able to move forwards and backwards
> during playback, e.g. by pressing f or b, like Takashi Iwai's drvmidi?

Not so easy; even more so if you want to have correct controller
values.  Adjusting settings changed by sysexs would be almost
impossible.


However, these tools are meant as basic command-line utilities (and
examples).  I think your suggestions would fit better into some GUI
player.


Regards,
Clemens




-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
