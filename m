From: Shaju Abraham <shaju@multitech.co.in>
Subject: Period Size in ymf724
Date: Mon, 23 Sep 2002 09:43:20 +0530
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3D8E94DF.E13DB0E8@multitech.co.in>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mtsslvpngway ([202.54.39.98])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with SMTP id GAA13437
	for <alsa-devel@alsa-project.org>; Mon, 23 Sep 2002 06:14:52 +0200
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: ALSA development <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

Hi all,
         We tried using a ymf724 pci sound card and observed that the
minimum period size we can get is 944 bytes.( with -F switch of aplay).
We had tried the same switch of aplay with a cmipci card and the minimum
period size we could get was about only 64 bytes.

Basically, we are trying this 'cos we want the card to raise interrupts
as frequently as possible.

Is this a h/w limitation of ymf724 card or is there any way we can get
to reduce the period size on a ymf724 card to around 64 bytes ?

Thanx in advance,
Shaju Abraham



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
