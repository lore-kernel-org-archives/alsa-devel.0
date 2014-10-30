From: dE <de.techno@gmail.com>
Subject: opengl 'leaking' sound to input.
Date: Thu, 30 Oct 2014 15:20:02 +0530
Message-ID: <545209CA.1070307@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pd0-f171.google.com (mail-pd0-f171.google.com
 [209.85.192.171])
 by alsa0.perex.cz (Postfix) with ESMTP id CBD9E2605E3
 for <Alsa-devel@alsa-project.org>; Thu, 30 Oct 2014 10:50:30 +0100 (CET)
Received: by mail-pd0-f171.google.com with SMTP id r10so4841869pdi.2
 for <Alsa-devel@alsa-project.org>; Thu, 30 Oct 2014 02:50:29 -0700 (PDT)
Received: from [192.168.1.2] ([117.208.69.53])
 by mx.google.com with ESMTPSA id p10sm6626722pds.37.2014.10.30.02.50.26
 for <Alsa-devel@alsa-project.org>
 (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
 Thu, 30 Oct 2014 02:50:27 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

I'm trying to record audio from the analog input device of my card, but 
whenever there seems to be some graphics intensive activity like 
glxgears, OpenGL assisted window manager, audacity graphs etc... a noise 
appears in the recording which sounds like some kind of sparking 
disturbance.

I've recorded audio many times on this box before, but this started to 
happen suddenly (maybe after an ugprade, but old live CDs with 
proprietary nvidia drivers installed or newer nouveau drivers seem to 
have the same issue).

Just to confirm, is this a hardware issue?
