From: maarten van es <maarten.h.van.es@gmail.com>
Subject: salsa error message setting hwparams
Date: Thu, 23 Apr 2009 20:31:18 +0100
Message-ID: <bca65b460904231231n6eacecc4l783ba028030d4398@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.158])
	by alsa0.perex.cz (Postfix) with ESMTP id 59B081037F9
	for <alsa-devel@alsa-project.org>;
	Thu, 23 Apr 2009 21:31:19 +0200 (CEST)
Received: by fg-out-1718.google.com with SMTP id 16so53106fgg.21
	for <alsa-devel@alsa-project.org>; Thu, 23 Apr 2009 12:31:18 -0700 (PDT)
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

Hi everyone,

I am running out of ideas of why I am getting the error "operation not
permitted" when I try setting hw parameters with one of my audio
cards. I have a custom linux system based on uclibc with salsa for
audio and use the default device for playback. This sytem works fine
on a via C7 based pc with via audio. When I try an exact copy of the
system on an athlon64 based system with a HDPS9632 I get this error
message. The card works fine with other linux systems. I tested
several (recent) kernels with my system, all the same result. Any
ideas why I might be getting this message?

Maarten
