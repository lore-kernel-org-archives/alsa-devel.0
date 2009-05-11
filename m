From: =?UTF-8?B?T3phbiDDh2HEn2xheWFu?= <ozan@pardus.org.tr>
Subject: MacbookPro5,1 & hda-analyzer
Date: Mon, 11 May 2009 21:11:36 +0300
Message-ID: <4A086A58.3000107@pardus.org.tr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from pardus.org.tr (ns2.uludag.org.tr [193.140.100.220])
	by alsa0.perex.cz (Postfix) with ESMTP id 0D0782434E
	for <alsa-devel@alsa-project.org>;
	Mon, 11 May 2009 20:11:36 +0200 (CEST)
Received: from [192.168.1.2] (unknown [88.249.178.198])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested) (Authenticated sender: ozan)
	by pardus.org.tr (Postfix) with ESMTP id 7238A6694B09
	for <alsa-devel@alsa-project.org>;
	Mon, 11 May 2009 21:11:27 +0300 (EEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

I just bought a MacbookPro5,1 and having difficulties with the onboard
HDA chipset.

* No sound can be heard of it if model= is not set to mbp3:
  [   12.009422] hda_codec: Unknown model for ALC883, trying auto-probe
from BIOS...
  http://www.alsa-project.org/db/?f=4b2f257e72523bccafd3ace1d3c7044fb5f09ff8

* If model=mbp3 is given, it's possible to get sound from it but with
many annoying problems:

  - You have to switch to 6ch mode for getting sound, doesn't work with
2ch mode,
  - The sound quality is very very bad,
  - Once you switch to 6ch mode,
    - You have to increment the volume of *Line-in* to have hearable
sound from *internal speakers*,
    - You have to increment the volume of *Front* to have hearable sound
from *headphones*,
    - The two controls are not mutually exclusive, you have to mute one
of them, if you're using the other.

And then I decided to play with hda-analyzer. After a bit of playing, I
started to get sound from the board
without the model=mbp3. But the mixers are still behaving somewhat
strange. Before actually reporting any feedback
on what I've switched and did, what do you suggest me to do? Is setting
the model= to something, something similar to what
I was doing with hda-analyzer?


Thanks
Ozan Caglayan
