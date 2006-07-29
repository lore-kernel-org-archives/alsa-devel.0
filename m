From: "Kip Warner" <Kip@thevertigo.com>
Subject: ALC883 Detection Issue
Date: Fri, 28 Jul 2006 20:59:53 -0700
Message-ID: <op.tdfmp3yxe8k94p@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: ALSA Developers <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Greetings,

I have an Intel HDA sound board with a Realtek ALC883 chipset. This is built into my four speaker ASUS A7J laptop.

When I modprobe snd-hda-intel, I see the following in the kernel log:

hda_codec: Unknown model for ALC882, trying auto-probe from BIOS...

I have tried experimenting with a number of different model strings for snd-hda-intel, all to no avail.

I hear sound, but only out of the front two speakers. Alsamixer shows that it thinks the chipset is the Realtek ALC882 and only gives a slider for Headphone, Front, Line, CD, Mic, ... but with no "Rear" channel.

"speaker-test -c4" confirms this because it only makes an audible hiss with the front two speakers but immediately goes silent with the back two. It looks like it is using the wrong chipset with the wrong speaker configuration.

I have been wrestling with this for weeks and to no avail. I am using Alsa 1.0.12.rc1 with kernel 2.6.17.3. In my kernel options I enabled sound but disabled Alsa. I compiled Alsa manually with ./configure --with-cards=hda-intel. I have also tried the latest source from the HG repository. Same thing.

Any help would be much appreciated.

--
Kip

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
