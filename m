From: Denis 'GNUtoo' Carikli <GNUtoo@no-log.org>
Subject: DMA problem with The GTA02 Machine.
Date: Wed, 28 Mar 2012 00:37:48 +0200
Message-ID: <1332887869-3527-1-git-send-email-GNUtoo@no-log.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp201.alice.it (smtp201.alice.it [82.57.200.97])
	by alsa0.perex.cz (Postfix) with ESMTP id 5345C24447
	for <alsa-devel@alsa-project.org>;
	Wed, 28 Mar 2012 00:38:00 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

There is a problem with DMA with the GTA02 machine:
instead of playing a wav file saying "incomming call..." 
it plays "in-in-in-co-co-co-mi-mi-mi...".

I don't know how that problem is called.

In any case I've bisected it during hours(the commit that broke 
  it was in an untestable area, so I had to bisect what made
  the area untestable too(it's already fixed in linux-next)).

Then after identifying the commit I've tried to narrow it more.
But I don't know how to narrow it even more than what I've in the 
  patch attached.

Denis.
