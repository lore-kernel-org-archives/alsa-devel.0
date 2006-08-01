From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: snd_ctl_open and snd_rawmidi_open conflict
Date: Tue, 01 Aug 2006 12:18:41 +0200
Message-ID: <20060801101841.GA4775@ifiu1.informatik.uni-halle.de>
References: <70a871c80607301752w16c1c014v40f574d17603f08d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-reply-to: <70a871c80607301752w16c1c014v40f574d17603f08d@mail.gmail.com>
Content-disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Dmitry Baikov <dsbaikov@gmail.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Dmitry Baikov wrote:
> Another releated question is: how can I detect connection of a new
> usb-midi device?
> For now I use inotify on /dev/snd, but it's a kludge, cause I have to
> add sleep(1) before actual rescan of devices, or I miss the update.

The sequencer broadcasts notifications from the announce port when
sequencer clients/ports are created or destroyed.  (You don't need to
use the sequencer for your actual MIDI stuff.)


HTH
Clemens

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
