From: ajay khandelwal <ajay.lforum@gmail.com>
Subject: spdif: aplay -L output
Date: Tue, 8 Nov 2011 19:35:08 +0530
Message-ID: <CAL7V=_F_7wNjHb7DB8S0P3LaTf-dhyPN6t38cOyjw3xniTrOew@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gx0-f179.google.com (mail-gx0-f179.google.com
	[209.85.161.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 7A2071038E0
	for <alsa-devel@alsa-project.org>; Tue,  8 Nov 2011 15:05:09 +0100 (CET)
Received: by ggnq2 with SMTP id q2so639671ggn.38
	for <alsa-devel@alsa-project.org>; Tue, 08 Nov 2011 06:05:08 -0800 (PST)
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

Hi All,
 When I do aplay -L on my pc it gives following as mentioned below.
Name expoted for spdif is iec958:CARD=ICH6,DEV=0
Is this name coming from configuration file or is exported by driver.

# /usr/bin/aplay -L
null
    Discard all samples (playback) or generate zero samples (capture)
default:CARD=ICH6
    Intel ICH6, Intel ICH6
    Default Audio Device
front:CARD=ICH6,DEV=0
    Intel ICH6, Intel ICH6
    Front speakers
surround40:CARD=ICH6,DEV=0
    Intel ICH6, Intel ICH6
    4.0 Surround output to Front and Rear speakers
surround41:CARD=ICH6,DEV=0
    Intel ICH6, Intel ICH6
    4.1 Surround output to Front, Rear and Subwoofer speakers
surround50:CARD=ICH6,DEV=0
    Intel ICH6, Intel ICH6
    5.0 Surround output to Front, Center and Rear speakers
surround51:CARD=ICH6,DEV=0
    Intel ICH6, Intel ICH6
    5.1 Surround output to Front, Center, Rear and Subwoofer speakers
iec958:CARD=ICH6,DEV=0
    Intel ICH6, Intel ICH6 - IEC958
    IEC958 (S/PDIF) Digital Audio Output

Best Regards,
Ajay
