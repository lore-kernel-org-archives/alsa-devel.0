From: Shaju Abraham <shaju@multitech.co.in>
Subject: exactly when is interrupt raised?
Date: Wed, 25 Sep 2002 10:41:25 +0530
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3D91457D.D42CCBBD@multitech.co.in>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mtsslvpngway ([202.54.39.98])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with SMTP id HAA21698
	for <alsa-devel@alsa-project.org>; Wed, 25 Sep 2002 07:12:55 +0200
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
        We are working with a cm8738 which is built into the
motherboard. We could not find the data sheets for the chipset. If
someone could direct us to the data sheets of cm8738 it will be great
else one doubt that we have about the card is -

when exactly does the card raise the interrupt in playback mode. Is it
after physically playing out and thus finishing the period_size number
of frames or is it after the period_size number of frames are copied
into the hw buffers(?) of the card?

Exactly at what point does the cm8738 card raise an interrupt?

--Shaju Abraham



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
