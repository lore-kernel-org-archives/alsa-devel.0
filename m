From: Andrew Gaydenko <a@etver.com>
Subject: alsa + midi == system hangs
Date: Mon, 23 Aug 2004 01:08:44 +0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200408230108.44078@goldspace.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,

I have tried to get an answer from the alsa users mailng list without success.
My last hope is here.

The problem is very simple: while trying to start any midi-related
application (rosegarden, qsynth, fluid itself, MuseScore-from-CVS, ...),
a system hangs absolutely. It seems like:

- the problem doesn't depend on driver: my friend has another card
  with the same problem exactly,
- the problem doesn't depend on particular kernel version: 2.6.5, 2.6.7,
  2.6.8.1, 2.6.8.1-ck4 and voluntary preemption patch P5 for 2.6.8.1 were
  tried (kernel alsa driver was disabled).

Other alsa related parts/apps work well: playing back to analogue/spdif out,
capturing from analog in, qamixer with own xml file, jack-enabled apps,
and so on.

The problem takes place with both 1.0.5a and 1.0.6a versions. I use ice1724
driver for Aureon Space.

All worked at those old days with kernel 2.4.x and alsa 1.0.4.

Must I supply any additional info?

Thanks in advance,
Andrew


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
