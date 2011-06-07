From: Eliot Blennerhassett <linux@audioscience.com>
Subject: alsa-driver build problem : no lola dir
Date: Tue, 07 Jun 2011 13:36:40 +1200
Message-ID: <4DED80A8.5000502@audioscience.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp4.clear.net.nz (smtp4.clear.net.nz [203.97.37.64])
	by alsa0.perex.cz (Postfix) with ESMTP id 416962433F
	for <alsa-devel@alsa-project.org>;
	Tue,  7 Jun 2011 03:36:43 +0200 (CEST)
Received: from [192.168.36.2]
	(121-72-250-62.cable.telstraclear.net [121.72.250.62])
	by smtp4.clear.net.nz (CLEAR Net Mail)
	with ESMTP id <0LME005V7CH44B00@smtp4.clear.net.nz> for
	alsa-devel@alsa-project.org; Tue, 07 Jun 2011 13:36:40 +1200 (NZST)
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
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

(resend from address subscribed to alsa-devel)

Trying to build alsa-driver git fails:

make[2]: Leaving directory
`/home/eliot/src/alsagit/alsa-driver/pci/korg1212'
make: Entering an unknown directory
make: *** lola: No such file or directory.  Stop.
make: Leaving an unknown directory
make[1]: *** [prepare] Error 1
make[1]: Leaving directory `/home/eliot/src/alsagit/alsa-driver/pci'
make: *** [dep] Error 1
~/src/alsagit/alsa-driver$

my alsa-kernel links point to a current sound-2.6 git tree.

-- 
Eliot Blennerhassett
AudioScience Inc.
