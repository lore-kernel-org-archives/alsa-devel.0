From: Curtis R Anderson <gleepy@gleepy.net>
Subject: TASCAM US-144 and usx2y
Date: Wed, 14 Feb 2007 21:09:58 -0500
Message-ID: <45D3C0F6.9010306@gleepy.net>
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
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Yes, I have a not (yet?) supported TASCAM US-144.

As I started to go through source code in alsa-firmware and elsewhere, I 
see we need to get an Intel HEX firmware file for the unit, like 
us144fw.ihx, made from some kind of source. I would have to know how to 
extract these from the Windows or Mac stuff TASCAM releases.

The USB identification is 0644:800f, which would have to be added into 
the hotplug driver.

I can plug my unit back into the USB and get information like the output 
of lsusb -v or /proc/bus/usb/devices if that would help anyone here.
-- 
Curtis R. Anderson, Co-creator of "Gleepy the Hen", still
"In Heaven there is no beer / That's why we drink it here ..."
http://www.gleepy.net/      mailto:gleepy@intelligencia.com
mailto:gleepy@gleepy.net (and others)  Yahoo!: gleepythehen

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
