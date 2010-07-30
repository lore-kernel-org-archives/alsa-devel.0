From: sudarshan bisht <bisht.sudarshan@gmail.com>
Subject: ALSA Mixer issue
Date: Fri, 30 Jul 2010 16:23:44 +0300
Message-ID: <AANLkTi=5Cxxv6bCuFZ9TB7wOKo0m1FrNTvHiOqmhXMAu@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-px0-f179.google.com (mail-px0-f179.google.com
	[209.85.212.179])
	by alsa0.perex.cz (Postfix) with ESMTP id D837F1039E1
	for <alsa-devel@alsa-project.org>;
	Fri, 30 Jul 2010 15:23:45 +0200 (CEST)
Received: by pxi2 with SMTP id 2so607790pxi.38
	for <alsa-devel@alsa-project.org>; Fri, 30 Jul 2010 06:23:44 -0700 (PDT)
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

Hi ,

I wanted to know that can we use multiple handlers for the same ALSA mixer ?

My use case is something like this .

I have two modules and having two different handlers for ALSA mixer.  First
module does some volume change , and I try to read the latest volume using
my second handler ( of first second module) .

But I am not getting the most recent value in second handler ( the volume
set by the first module )  so I feel there is some inconsistency when I use
two handlers from two different modules in order to fetch volume information
from the ALSA mixer.




-- 
Regards,

Sudarshan Bisht
