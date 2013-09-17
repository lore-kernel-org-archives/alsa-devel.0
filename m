From: "Brandon Yates" <Brandon.Yates@adaptivedigital.com>
Subject: Variable Delay through ALSA driver
Date: Tue, 17 Sep 2013 16:07:15 -0400
Message-ID: <B02206F4ACA2904A8270028316B8DAFF01149AB8@mercury.corp.adaptivedigital.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.bemta8.messagelabs.com (mail1.bemta8.messagelabs.com
 [216.82.243.203])
 by alsa0.perex.cz (Postfix) with ESMTP id E3A0F265211
 for <alsa-devel@alsa-project.org>; Tue, 17 Sep 2013 22:07:16 +0200 (CEST)
Content-class: urn:content-classes:message
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

I have an application using the ALSA API that writes to playback device
and simultaneously reads from capture device.  My processing loop is :

1)Read from microphone (blocking)
2)Process Data
3)Write to speaker

I am measuring the delay from the time I play a series of frames to the
speaker until I detect the echo of this coming back in through the
microphone.  This delay seems to be changing every time I initialize the
devices with ALSA. I have measured in the range of 60-160ms delay.  I
know things like period size effect delay, but using the exact same
software and hardware configuration I would expect this to be constant
across runs.  What are some parameters that can help me make the delay
deterministic?

Thanks,
Brandon        
