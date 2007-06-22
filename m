From: "Pharaoh ." <pharaoh137@gmail.com>
Subject: Query regarding pointer callback
Date: Sat, 23 Jun 2007 04:08:03 +0530
Message-ID: <61445c750706221538j414508e0hcf2b9eeff9fbd47b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 6581610380F
	for <alsa-devel@alsa-project.org>;
	Sat, 23 Jun 2007 00:38:06 +0200 (CEST)
Received: by wa-out-1112.google.com with SMTP id m33so941950wag
	for <alsa-devel@alsa-project.org>; Fri, 22 Jun 2007 15:38:04 -0700 (PDT)
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

Hi

In Writing an ALSA driver, it is said that
pointer callback is called usually from the buffer-update routine in
the pcm middle layer, which is invoked when snd_pcm_period_elapsed()
is called in the interrupt routine. Then the pcm middle layer updates
the position and calculates the available space, and wakes up the
sleeping poll threads, etc

What are the other places from where pointer callback is called? If it
is not called from any other routine then does it mean that interrupts
are occuring?
