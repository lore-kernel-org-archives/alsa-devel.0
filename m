From: Giuliano Pochini <pochini@shiny.it>
Subject: Re: addressing hardware directly?
Date: Wed, 09 Nov 2005 09:12:46 +0100 (CET)
Message-ID: <XFMail.20051109091246.pochini@shiny.it>
References: <1131359629.436f2d8d869ad@webmail.uni-halle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1131359629.436f2d8d869ad@webmail.uni-halle.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Clemens Ladisch <clemens@ladisch.de>
Cc: Alsa-devel@lists.sourceforge.net, David Smoot <davidsmoot@gmail.com>
List-Id: alsa-devel@alsa-project.org


On 07-Nov-2005 Clemens Ladisch wrote:
> David Smoot wrote:
>> If I am not developing a generic sound application but I specifically
>> want to talk to a single card, can I address a card directly in my
>> software rather than using the "default" or the "hw:0,0" interface?
>> My target platform is a very limited device, the less stuff I install,
>> the better.
>
> "hw" is the most direct ALSA interface.  If you want to be more direct,=
 you have
> to write your own driver.

He can also get rid of alsa-lib accessing alsa-kernel through
ioctl's. It's hard, but not as much as writing his own driver.


--
Giuliano.


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Downl=
oad
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
