From: "van der Linden" <ejvanderlinden@hetnet.nl>
Subject: arecord | aplay expected delay
Date: Sun, 16 Mar 2008 11:05:52 +0100
Message-ID: <00d301c8874d$51773ea0$0202a8c0@uw4b58d8528225>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hpsmtp-eml17.kpnxchange.com (hpsmtp-eml17.kpnxchange.com
	[213.75.38.117])
	by alsa0.perex.cz (Postfix) with ESMTP id 26BDD103832
	for <alsa-devel@alsa-project.org>; Sun, 16 Mar 2008 11:05:59 +0100 (CET)
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

I'm running arecord and aplay under uCLinux on a Blackfin DSP.

In this way I loopback my audio.

Does anyone know what delay I can expect between audio input and audio output?

I measure at my test board 50ms. I want to have about 1ms!

E-J
