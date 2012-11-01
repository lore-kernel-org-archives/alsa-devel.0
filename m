From: David Henningsson <david.henningsson@canonical.com>
Subject: UCM/DAPM - saving power when idle?
Date: Thu, 01 Nov 2012 11:39:01 +0100
Message-ID: <50925145.4070706@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id A25D5261720
 for <alsa-devel@alsa-project.org>; Thu,  1 Nov 2012 11:39:02 +0100 (CET)
Received: from [91.224.175.20] (helo=[10.155.5.236])
 by youngberry.canonical.com with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david.henningsson@canonical.com>)
 id 1TTsAw-0001Kh-8F
 for alsa-devel@alsa-project.org; Thu, 01 Nov 2012 10:39:02 +0000
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

I don't deal much with ASoC, so sorry if I'm missing something obvious 
here...

When a certain use case is activated, that would then activate some DAPM 
widgets, causing the codec to consume more power. So, we should 
essentially avoid this unless we're actually playing back/recording. 
But, why isn't there a "disable all use cases" command, or possibly an 
"idle" command? (That, essentially, e g pulseaudio should set whenever 
playback/recording stops)

Or; the option would be that the codec is actually powered down, but 
only activates itself when there is a stream; but this looks like it 
could cause problem with loopback paths (e g listening to FM radio, 
where there are no streams passing through CPU/main memory).

-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic
