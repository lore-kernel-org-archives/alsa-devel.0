From: "John Twideldum" <twideldums_throwaway@gmx.at>
Subject: no sound on Haswell Lenovo T440s with 3.12-rc5
Date: Tue, 22 Oct 2013 11:54:59 +0200 (CEST)
Message-ID: <trinity-b51ca9da-a4d1-40fc-b921-baf720a5e8f9-1382435699391@3capp-gmx-bs50>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 by alsa0.perex.cz (Postfix) with ESMTP id D39C92652D7
 for <alsa-devel@alsa-project.org>; Tue, 22 Oct 2013 11:54:59 +0200 (CEST)
Received: from 3capp-gmx-bs50.server.lan ([172.19.170.103]) by
 mrigmx.server.lan (mrigmx001) with ESMTP (Nemesis) id
 0M2rpw-1VoZvR27FO-00shuL for <alsa-devel@alsa-project.org>; Tue, 22 Oct 2013
 11:54:59 +0200
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

Hi all...

There is a shiny new Lenovo T440s on my desk, which is a Haswell generation Ultrabook.

Configuration dump running 3.12-rc5:
http://www.alsa-project.org/db/?f=2eec0890ae63625c1b47a7e7cbcbb1722c8c5080

Symptoms:
I have console beep, but no sound.
Specifically,
a) it appears "Intel Haswell HDMI" on displayport appears to be picked as default output,
b) alternative output 2 "HDA Intel PCH/Realtek ALC292" has no PCM control.

So my wild guess would be
a) PCH needs to be default and
b) the PCM controls are missing due to a bug

Is there a patch already queued for 3.13?

If not - willing to test, but may take some time as I'm travelling...

Thank you!
