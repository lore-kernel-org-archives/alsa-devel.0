From: kuldeep ghan <ghankp@gmail.com>
Subject: ALSA underruns for S32_LE format
Date: Fri, 19 Aug 2011 16:06:27 +0530
Message-ID: <CAL5CBvJBrk=euqXgOK=QWP4NC5yYKsm92Y+vC4dJiirgW1o_+A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179]) by alsa0.perex.cz (Postfix) with ESMTP id BED0C24608
	for <alsa-devel@alsa-project.org>;
	Fri, 19 Aug 2011 12:36:27 +0200 (CEST)
Received: by wyh22 with SMTP id 22so2129170wyh.38
	for <alsa-devel@alsa-project.org>; Fri, 19 Aug 2011 03:36:27 -0700 (PDT)
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

I am trying to play raw audio as S32_LE format and I am getting underruns.

*# aplay /userdata/raw -fS32_LE -r48000 -c2*
*Playing raw data '/userdata/raw' : Signed 32 bit Little Endian, Rate 48000
Hz, Stereo*
*underrun!!! (at least 0.055 ms long)*
*underrun!!! (at least 0.043 ms long)*
*underrun!!! (at least 0.040 ms long)*
*underrun!!! (at least 0.043 ms long)*
*underrun!!! (at least 0.043 ms long)*
*underrun!!! (at least 0.043 ms long)*
*underrun!!! (at least 0.040 ms long)*

I am able play it fine as S16_LE format. (aplay /userdata/raw -fS16_LE
-r48000 -c2)

I would like to get it working fine S32_LE format. Any help, suggestions to
get away with underruns is welcome.

Regards,
Kuldeep
