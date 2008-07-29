From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Exposing control of my device
Date: Mon, 28 Jul 2008 22:29:41 -0400
Message-ID: <9e4733910807281929s10561ec9w3d6c411d742a3b7d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from qw-out-1920.google.com (qw-out-1920.google.com [74.125.92.148])
	by alsa0.perex.cz (Postfix) with ESMTP id D91C0247D1
	for <alsa-devel@alsa-project.org>;
	Tue, 29 Jul 2008 04:29:42 +0200 (CEST)
Received: by qw-out-1920.google.com with SMTP id 5so371734qwf.56
	for <alsa-devel@alsa-project.org>; Mon, 28 Jul 2008 19:29:41 -0700 (PDT)
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
To: ALSA-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

My device has 220 registers, some of these are quite long (32 bytes)
and I have split them up into multiple 32b pseudo registers.  That
results in about 300 registers for a TAS5504 and 450 for a TAS5508.

A large number of these registers are for BiQuads, DRC, loudness, etc.
They're not general purpose ALSA functions. What is an efficient way
to expose several hundred registers of this class? Making
snd_kcontrols for all of them seems pretty inefficient.

Is there some generic way to do register access from user space that I
haven't found yet? Or should I make two special snd_kcontrols, one for
read register and write register?

-- 
Jon Smirl
jonsmirl@gmail.com
