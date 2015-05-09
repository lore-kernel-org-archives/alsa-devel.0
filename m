From: sylvain.bertrand@gmail.com
Subject: USB-Audio.conf routing and dmix
Date: Sat, 9 May 2015 00:20:17 +0000
Message-ID: <20150509002017.GB18945@freedom>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f174.google.com (mail-wi0-f174.google.com
 [209.85.212.174])
 by alsa0.perex.cz (Postfix) with ESMTP id 8C41A2605CB
 for <alsa-devel@alsa-project.org>; Sat,  9 May 2015 02:20:27 +0200 (CEST)
Received: by wiun10 with SMTP id n10so43473064wiu.1
 for <alsa-devel@alsa-project.org>; Fri, 08 May 2015 17:20:26 -0700 (PDT)
Received: from localhost (spybox.legeek.net. [88.188.175.165])
 by mx.google.com with ESMTPSA id k2sm1172533wix.4.2015.05.08.17.20.25
 for <alsa-devel@alsa-project.org>
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 08 May 2015 17:20:25 -0700 (PDT)
Content-Disposition: inline
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

I have a bose USB audio 5.1 device, a generic USB audio device.

I noticed that the proper channels routing was missing from the default generic
USB pcm, but dmix was used. And for the surround pcms I noticed it was the
other way around!

I did modify the default pcm to include a routing plugin. I put 8 channels in
the routing plugin. I guess the proper way would be to detect the hw card
number of channels and select a route plugin configuration with the correct
count of channels (maybe their is a function to get that info?).

I linked the surround51 and surround71 pcms with the 'disable-able' dmix
section from the default pcm.

I did not touch the surround40* pcms, surround pcms which are specific to some
cards and the iec958 ones.

http://filebin.ca/214UTT8fBnUm/USB-Audio.conf


regards,

-- 
Sylvain BERTRAND
