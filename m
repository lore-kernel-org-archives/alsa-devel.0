From: Michael Leies <michael.leies@googlemail.com>
Subject: ALC883 features
Date: Thu, 28 May 2009 11:30:59 -0400
Message-ID: <6d18452c0905280830q6d2b0477ve5a549aadaf583ad@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gx0-f158.google.com (mail-gx0-f158.google.com
	[209.85.217.158])
	by alsa0.perex.cz (Postfix) with ESMTP id DC5291038CC
	for <alsa-devel@alsa-project.org>;
	Thu, 28 May 2009 17:31:05 +0200 (CEST)
Received: by gxk2 with SMTP id 2so10223894gxk.8
	for <alsa-devel@alsa-project.org>; Thu, 28 May 2009 08:31:04 -0700 (PDT)
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

I'm new here.

I just bought a new computer from Dell with a Realtek ALC1200 (883?).
 After messing with alsa configurations and looking into the driver
code a bit, I noted that a few features i'd like don't seem to be
supported by the current driver.

1) Use of all 10 channels, only 8 are wired out to the 7.1 pcm device
(forgive me if i lack the proper terminology for the moment).  From
the 883 datasheet, and comments in 1.0.20 code it seems the last 2
channels could be wired out as a separate PCM device.

2) Some more controls, specifically the ability to prevent the
headphone jack from automuting the speakers.  And if its possible to
wire out the missing two channels then perhaps some more controls for
the new channels.

I was wondering if there someone who might point me in the right
direction to get started with fixing up these things in the driver.

Are my ambitions realistic, or am I barking up the tree of having to
rewrite the whole HDA driver?

Thanks,
Michael
