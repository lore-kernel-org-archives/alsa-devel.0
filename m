From: Rask Ingemann Lambertsen <rask@sygehus.dk>
Subject: Questions about sound/isa/sb/sb8_main.c
Date: Tue, 27 Feb 2007 21:49:15 +0100
Message-ID: <20070227204914.GA6906@sygehus.dk>
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
Cc: Uros Bizjak <uros@kss-loka.si>
List-Id: alsa-devel@alsa-project.org

   Hi.

   I'm looking at sound/isa/sb/sb8_main.c from linux 2.6.20. In
snd_sb8_capture_prepare(), a line reads:

        if (chip->capture_format != SB_DSP_OUTPUT) {

   Shouldn't this be SB_DSP_INPUT instead?

   The only two stereo sample rates allowed by the driver are 11025 Hz and
22050 Hz. Is this a hardware limitation or is the necessary support for
other sample just not implemented?

-- 
Rask Ingemann Lambertsen

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
