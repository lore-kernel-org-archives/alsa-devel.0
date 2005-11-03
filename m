From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: USB audio - 10x too fast on 2.6.14
Date: Thu, 03 Nov 2005 11:28:33 +0100
Message-ID: <1131013713.4369e6518359d@webmail.uni-halle.de>
References: <5bdc1c8b0511021804m250a54dbx5b88e21acd4b74a6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <5bdc1c8b0511021804m250a54dbx5b88e21acd4b74a6@mail.gmail.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Mark Knecht <markknecht@gmail.com>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Mark Knecht wrote:
> However, when we tried our USB->TosLink device a 3:30 minute song plays in
> about 25 seconds.

A bug in the snd-usb-audio driver.  Using another playback program (using ALSA
instead of OSS) may work instead.  This has been fixed in CVS.


HTH
Clemens


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
