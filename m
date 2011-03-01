From: Arun Raghavan <arun.raghavan@collabora.co.uk>
Subject: CS4206 and S/PDIF (again)
Date: Tue, 01 Mar 2011 10:36:09 +0530
Message-ID: <1298955969.12314.12.camel@snowflake>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [93.93.128.226])
	by alsa0.perex.cz (Postfix) with ESMTP id E2E7424659
	for <alsa-devel@alsa-project.org>; Tue,  1 Mar 2011 06:06:12 +0100 (CET)
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

Hello,
I saw an earlier thread where someone with a MacBook Pro 6.2 couldn't
get S/PDIF working. I'm facing the same problem on my MacBook Pro 5.5. I
know this used to work at some point because the LED from the digital
out used to glow (but my last recollection of this is from ca. Jan 2010,
so not too helpful).

I tried jiggling some controls in hda-analyzer, but I don't yet know
enough about this to be sure what I was doing made any sense.

I've uploaded alsa-info [1] and codecgraph [2] outout, and would really
appreciate help figuring out how I can go about debugging this problem.

[1] http://people.collabora.co.uk/~arun/alsa-info.txt
[2] http://people.collabora.co.uk/~arun/cs4206-mbp55.svg

Cheers,
Arun

p.s.: fwiw, I'm testing with a: aplay -v -D iec958:CARD=NVidia,DEV=0
SURROUNDTEST_011212.wav
