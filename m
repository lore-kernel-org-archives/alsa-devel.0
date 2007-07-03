From: "Paul Kavan" <pkavan@gmail.com>
Subject: Application Coding
Date: Tue, 3 Jul 2007 10:09:30 -0500
Message-ID: <61c0054e0707030809sfd82699na4fec072cccfe899@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mu-out-0910.google.com (mu-out-0910.google.com [209.85.134.189])
	by alsa0.perex.cz (Postfix) with ESMTP id 3B4A924422
	for <alsa-devel@alsa-project.org>;
	Tue,  3 Jul 2007 17:09:32 +0200 (CEST)
Received: by mu-out-0910.google.com with SMTP id w8so2318732mue
	for <alsa-devel@alsa-project.org>; Tue, 03 Jul 2007 08:09:31 -0700 (PDT)
Content-Disposition: inline
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

Hello all:

Beginning to write my application code now that I have alsa SoC working
fairly well on my ARM development board. My audio application is fairly
simple. I will be doing raw, S8, samples at an 8k sample rate. Essentially I
need to do playback of a stream when signaled by an application to do so and
capture when signaled by a button press. Capture takes precedent over
playback.

I am really new to the alsa api and I am planning on using aplay as a
template. However, if anyone knows of an easier piece of code that may work
as a template, please feel free to point it out to me. I am using the API
documentation from the alsa-project website. If anyone knows of another good
piece of documentation, please feel free to let me know.

Thanks.

Paul



-- 
***************************************
Paul David Kavan
Project Engineer
GRH Electronics, Inc.
402-734-4900
pkavan@gmail.com
***************************************
