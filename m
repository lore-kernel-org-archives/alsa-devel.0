From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: ENS1371 joystick problem, bug in driver?
Date: Mon, 13 Oct 2003 14:28:04 +0200 (METDST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0310131420490.21012-100000@studcom.urz.uni-halle.de>
References: <200310111315.21656.coding@reduz.com.ar>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <200310111315.21656.coding@reduz.com.ar>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Juan Linietsky <coding@reduz.com.ar>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Juan Linietsky wrote:
> I cant seem to get the joystick port to run under this card (Ensoniq 1371)
> under alsa 0.9.rc6.

You might have better luck with 0.9.7c.

> state.AudioPCI {
>         control.1 {
>                 comment.access 'read write'
>                 comment.type BOOLEAN
>                 iface CARD
>                 name 'Joystick Enable'
>                 value true
>         }
>         control.2 {
>                 comment.access 'read write'
>                 comment.type ENUMERATED
>                 comment.item.0 'port 0x200'
>                 comment.item.1 'port 0x208'
>                 comment.item.2 'port 0x210'
>                 iface CARD
>                 name 'Joystick Address'
>                 value 'port 0x200'
>         }
>
> I tried using all the values above, but nothing works, and higher values are
> ignored (error is reported).

The driver cannot change the gameport's port address while it's
enabled, so you have to disable the joystick, then change the port,
then enable it again.


HTH
Clemens




-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
SourceForge.net hosts over 70,000 Open Source Projects.
See the people who have HELPED US provide better services:
Click here: http://sourceforge.net/supporters.php
