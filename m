From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: switching between mic and line-in
Date: Mon, 07 Nov 2005 11:29:59 +0100
Message-ID: <1131359399.436f2ca7b4781@webmail.uni-halle.de>
References: <6A09F73E2878E447BF6B87C43162C8270215463B@excwa1b2.sharpsec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <6A09F73E2878E447BF6B87C43162C8270215463B@excwa1b2.sharpsec.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: "Nambiar, Anil" <NambiarA@sharpsec.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Nambiar, Anil wrote:
> I need to switch between the mic and line-in based on what the user
> application selects. Now in AC97 codec chip, the capture input can be switched
> between mic and line-in by changing a few bits. Is there any IOCTL in alsa
> which I can use to switch between mic and line-in.

There is a mixer control for this.  Use the control API.

> The solution so far I have seen is to use two capture devices in the
> driver. Is that the only way?

These devices are for AC'97 controllers that support several streams, but those
are only used when there is more than one codec connected to the controller.


HTH
Clemens


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
