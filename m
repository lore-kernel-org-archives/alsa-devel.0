From: "Dmitry Baikov" <dsbaikov@gmail.com>
Subject: Re: snd_ctl_open and snd_rawmidi_open conflict
Date: Wed, 2 Aug 2006 00:38:17 +0400
Message-ID: <70a871c80608011338n3b086594t82c6851215fe9221@mail.gmail.com>
References: <70a871c80607301752w16c1c014v40f574d17603f08d@mail.gmail.com>
	<20060801101841.GA4775@ifiu1.informatik.uni-halle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <20060801101841.GA4775@ifiu1.informatik.uni-halle.de>
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
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On 8/1/06, Clemens Ladisch <clemens@ladisch.de> wrote:
> The sequencer broadcasts notifications from the announce port when
> sequencer clients/ports are created or destroyed.  (You don't need to
> use the sequencer for your actual MIDI stuff.)

How can I get notifications about rawmidi ports?
Or I should rescan devices on every seq notification?

Dmitry.

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
