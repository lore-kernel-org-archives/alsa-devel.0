From: "Nobin Mathew" <nobin.mathew@gmail.com>
Subject: Power management state flow in ALSA
Date: Wed, 30 May 2007 11:52:31 +0530
Message-ID: <8d6898730705292322w2dbf2a2fu4761370c4cc7ea16@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.177])
	by alsa0.perex.cz (Postfix) with ESMTP id D5EEF24438
	for <alsa-devel@alsa-project.org>;
	Wed, 30 May 2007 08:22:32 +0200 (CEST)
Received: by wa-out-1112.google.com with SMTP id n7so1060852wag
	for <alsa-devel@alsa-project.org>; Tue, 29 May 2007 23:22:31 -0700 (PDT)
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
To: lg@opensource.wolfsonmicro.com, tiwai@suse.de
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

I am having a doubt regarding ALSA power management.

My understanding of APM suspend() is like this.

Freeze the ALSA apps

Call ALSA driver suspend ()

in the ALSA suspend() function it saves the current state of substream
and changes the state of substream to SUSPENDED.

My understanding of APM resume() is like this

Call ALSA driver resume ()

Activate the ALSA apps

In ALSA resume function it restores the saved state of substream.


So my question is when ALSA app will get to know the SUSPENDED state
of substream.???

I am using linux kernel 2.6.17
ALSA driver version 1.0.11rc4
ASoC patch version 0.12.4
