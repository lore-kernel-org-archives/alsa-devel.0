From: Klaus Schulz <kls.schlz@googlemail.com>
Subject: EMU 0404USB: Odd sample rate shown during playback.
Date: Fri, 5 Jun 2009 22:53:02 +0200
Message-ID: <d9690f190906051353o23c9b0ffg1c41291b60f62c6a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qy0-f171.google.com (mail-qy0-f171.google.com
	[209.85.221.171])
	by alsa0.perex.cz (Postfix) with ESMTP id 54B6F24413
	for <alsa-devel@alsa-project.org>;
	Fri,  5 Jun 2009 22:53:04 +0200 (CEST)
Received: by qyk1 with SMTP id 1so2611999qyk.16
	for <alsa-devel@alsa-project.org>; Fri, 05 Jun 2009 13:53:02 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel mailing list <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi there.

The EMU 0404 is running in async USB mode as you know. When looking at the
stream parameters  during playback the sample rate shown is always slightly
below 44100 -- something
like 44098 is shown.

As you write in the driver,  the 0404 is returning number of samples per
packet instead of the number of samples per microframes. Has this something
to do with
it?

Question: Are we looking at  a wrong output  or is the samplerate really
lower than 44100?

THX
Klaus
