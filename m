From: =?ISO-8859-1?Q?S=F8ren?= Wedel Nielsen <swn@herlevkollegiet.dk>
Subject: envy24control and gtk2
Date: 24 Mar 2003 00:30:43 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1048462242.1151.40.camel@v304.herlevkollegiet.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,

I have upgraded the envy24control program to use gtk2.
To make the layout work I have changed it from fixed to hbox/vbox, but I
have tried not to change the structure og the gui-file envy24control.c.
It will also work with gtk1.

http://www.heko.dk/~swn/envy24control/envy24control-hboxvbox-230303.patch

To get it to use gtk2 I have changed the build configuration files.

http://www.heko.dk/~swn/envy24control/envy24control-gtk2-230303.patch


S=C3=B8ren Wedel Nielsen



-------------------------------------------------------
This SF.net email is sponsored by:Crypto Challenge is now open! 
Get cracking and register here for some mind boggling fun and 
the chance of winning an Apple iPod:
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0031en
