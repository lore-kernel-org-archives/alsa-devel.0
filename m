From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: behaviour of the trigger operation
Date: Mon, 07 Nov 2005 11:31:47 +0100
Message-ID: <1131359507.436f2d131d628@webmail.uni-halle.de>
References: <bf04f99c0511062057t599036d5g62582ee1cda7d050@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <bf04f99c0511062057t599036d5g62582ee1cda7d050@mail.gmail.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Tehn Yit Chin <tehn.yit.chin@gmail.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Tehn Yit Chin wrote:
> I am trying to understand how the trigger operation behaves.
>
> The behaviour that I am observing is that when ALSA starts up, it seems to
> be going through a few cycles of prepare, trigger_start and trigger_stop
> before it starts to streams data through to the codec. Is this normal
> behaviour?

No.  Which hardware and software are you using?


Regards,
Clemens


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
