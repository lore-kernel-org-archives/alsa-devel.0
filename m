From: "Dmitry Baikov" <dsbaikov@gmail.com>
Subject: snd_ctl_open and snd_rawmidi_open conflict
Date: Mon, 31 Jul 2006 04:52:21 +0400
Message-ID: <70a871c80607301752w16c1c014v40f574d17603f08d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hello!

I'm writing a program that have to open all rawmidi ports, and
periodically remove nonexisting ones, and open new ones (read, deal
with usb-midi connect/disconnect).

For example, we have USB-midi interface with 2 ports: hw:1,0,0 and hw:1,0,1
To get the list, I make snd_ctl_open("hw:1), then walk through
devices/subdevices and try to open all rawmidi ports. The problem is,
that I can only open first one - hw:1,0,0, trying to open another
gives "Device or resource is busy".

If I do NOT have ctl opened, I can open all subdevices without trouble.

Another releated question is: how can I detect connection of a new
usb-midi device?
For now I use inotify on /dev/snd, but it's a kludge, cause I have to
add sleep(1) before actual rescan of devices, or I miss the update.

Best regards,
Dmitry.

P.S. Im not a subscriber, please cc me in your replies

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
