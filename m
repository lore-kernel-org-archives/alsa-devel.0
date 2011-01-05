From: Radivoje Jovanovic <radivojejovanovic@gmail.com>
Subject: Do I have to use plugin?
Date: Wed, 5 Jan 2011 10:43:23 -0800
Message-ID: <AANLkTimBooxhWj7AYRSjS7zkMRd28y2wWGeWfaPmhs8a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179]) by alsa0.perex.cz (Postfix) with ESMTP id 6A0D1244F9
	for <alsa-devel@alsa-project.org>; Wed,  5 Jan 2011 19:43:59 +0100 (CET)
Received: by wyi11 with SMTP id 11so15443808wyi.38
	for <alsa-devel@alsa-project.org>; Wed, 05 Jan 2011 10:43:56 -0800 (PST)
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
I have a system that is slow and cannot support overhead for re-sampling
input streams. The codec on the system supports all rates from 8K-48K and it
is continuous so pretty much any rate should work no problem. However, I
noticed that when I play a song that has weird rate that is not specified in
the constraint list aplay would come back saying that it cannot set hardware
parameters. If I play the same song using the virtual device through "plug"
plugin the thing works no problem. I guess that alsa-lib re-samples the data
to rate specified in the virtual device. Is there any way for me to force
alsa to forward any rate to the hardware driver?
On the other hand is there any way I can specify multiple rates in the plug?
For example my plug has:
rate 32000
I tried
rate 8000, 32000
and
rate 8000 32000
but non of these worked.

Cheers
Ogi
