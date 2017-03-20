From: Deweloper <deweloper@wp.pl>
Subject: hw/sw params API in alsa-lib miscompiled,
 result: unusable alsa-utils
Date: Mon, 20 Mar 2017 15:19:49 +0100
Message-ID: <20170320151949.1d7494b6@amazur-u.kat.adbgroup.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx4.wp.pl (mx4.wp.pl [212.77.101.12])
 by alsa0.perex.cz (Postfix) with ESMTP id 570FB266D9D
 for <alsa-devel@alsa-project.org>; Mon, 20 Mar 2017 15:19:53 +0100 (CET)
Received: from unknown (HELO amazur-u.kat.adbgroup.pl)
 (deweloper@wp.pl@[91.230.58.65]) (envelope-sender <deweloper@wp.pl>)
 by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
 for <alsa-devel@alsa-project.org>; 20 Mar 2017 15:19:53 +0100
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

Hi,

I built alsa-lib and alsa-utils (v.1.1.3) from sources, using GCC 6.
When I tried launching arecord, it failed due to lack of memory.
During analysis I found out that:
- the message is printed because realloc(buf, period_size) returns NULL
- realloc() returns NULL because period_size is 0
- period_size is 0 because snd_pcm_hw_params_get_period_size() puts 0
  to *frames (instead of 32768) and returns 32768 (instead of 0)
- snd_pcm_hw_params_get_period_size() misbehaves in this way because
  although a NEW API header is used, the OLD API implementation is
  actually called
So it seems that I've run into exactly the same problem which was
described by John Spencer in August 2013:
http://mailman.alsa-project.org/pipermail/alsa-devel/2013-August/065031.html
> my problem is that the old version is getting called instead of the
> new one

Did anything change in this matter since August, 2013?

-- 
