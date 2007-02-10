From: Rui Nuno Capela <rncbc@rncbc.org>
Subject: Re: us428control 0.4.5 [RFC]
Date: Sat, 10 Feb 2007 15:37:29 +0000
Message-ID: <45CDE6B9.80804@rncbc.org>
References: <20070205065636.GA1652@elte.hu>
	<200702051525.49465.fzu@wemgehoertderstaat.de>
	<45CD2002.7070802@rncbc.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <45CD2002.7070802@rncbc.org>
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
Cc: Karsten Wiese <annabellesgarden@yahoo.de>, Karsten Wiese <fzu@wemgehoertderstaat.de>, Rui Nuno Capela <rncbc@rncbc.org>
List-Id: alsa-devel@alsa-project.org

Hi again,

Some more improvements [1], specially regarding BANK layer switching:
- when not in INPUT MONITOR mode, the SELECT, REC, MUTE/SOLO channel LED
states are preserved across four (4) layers, now switchable with the
BANK_R and BANK_L buttons.

Next steps will regard the proposed MMC Masked Write command traffic and
the NULL fader switch, although this last one is falling short of
usefulness on my mind :)

[1] http://www.rncbc.org/usx2y/us428control-0.4.5-2.tar.gz

Cheers.
-- 
rncbc aka Rui Nuno Capela
rncbc@rncbc.org

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier.
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
