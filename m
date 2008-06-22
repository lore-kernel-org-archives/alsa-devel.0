From: Aryeh Leib Taurog <vim@aryehleib.com>
Subject: Nonblocking non-synchronized io plugin?
Date: Sun, 22 Jun 2008 06:04:54 +0300
Message-ID: <20080622030454.GD14300@tishbi32.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mxout-03.mxes.net (mxout-03.mxes.net [216.86.168.178])
	by alsa0.perex.cz (Postfix) with ESMTP id 3CF391039D6
	for <alsa-devel@alsa-project.org>;
	Sun, 22 Jun 2008 05:05:50 +0200 (CEST)
Received: from localhost (unknown [80.179.212.190])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by smtp.mxes.net (Postfix) with ESMTP id 6F4E323E4B8
	for <alsa-devel@alsa-project.org>; Sat, 21 Jun 2008 23:05:47 -0400 (EDT)
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

Hello,

    I am trying to develop an io plugin to route audio input/output to/from 
a network application I'm developing.  I'm working on openSUSE 10.2, which 
I think means I'm using ALSA 1.0.13rc2

I am running into two problems:

1. ALSA calls my transfer function with io->nonblock = 0 and seems to be 
   quite picky about the timing of the function.  I'm having trouble 
getting the timing correct, and it seems to be causing ALSA to stop/crash.  
Is there any way that I can get ALSA to handle the timing for me and call 
my transfer function with io->nonblock = 1 instead?

2. ALSA seems to require that the capture and playback transfers be 
   synchronized.  That seems like a simple enough expectation, but for some 
reason, I am having a hard time providing this.  I tried splitting the 
capture and playback up in .asoundrc as below, but it doesn't seem to help.  
(Actually I can't be sure, since it could just be a timing issue).  Is 
there a way to separate the capture from the playback so it won't require 
them to be synchronized?

Basically, I want the ioplug to have as much latitude as possible to just 
transfer the data and return as soon as it can.  I guess if the calls are 
non-blocking, then they also won't need to be syncronized.  Please correct 
me if I'm wrong.

.asoundrc:
-----------------------------
pcm.read {
    type myplug
}

pcm.write {
    type myplug
}

ctl.myapp {
    type myplug
}

pcm.myapp {
    type asym
    playback.pcm "write"
    capture.pcm "read"
}

pcm.!default myapp
------------------------------


Thanks very much
Please let me know if I need to clarify anything.

Aryeh Leib Taurog
