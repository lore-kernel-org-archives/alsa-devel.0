From: "Timur Tabi" <timur@freescale.com>
Subject: How to report error in _pointer function?
Date: Wed, 30 Jul 2008 10:56:31 -0500
Message-ID: <ed82fe3e0807300856q6c6daf99n224df8ae4bfe6954@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wr-out-0506.google.com (wr-out-0506.google.com [64.233.184.228])
	by alsa0.perex.cz (Postfix) with ESMTP id 4A47F24380
	for <alsa-devel@alsa-project.org>;
	Wed, 30 Jul 2008 17:56:33 +0200 (CEST)
Received: by wr-out-0506.google.com with SMTP id 36so67616wra.24
	for <alsa-devel@alsa-project.org>; Wed, 30 Jul 2008 08:56:32 -0700 (PDT)
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

In my driver, I can detect in the _pointer callback function whether
or not the DMA engine has actually started.  Sometimes, when I have a
programming error, the DMA will not start, so my _pointer function
calculates a crazy value for the current position.  The number it
returns causes ALSA to go haywire (see my post titled, "underrun!!!
(at least 1786051083.613 ms long)".

What is the best way to handle this?  Is there a way I can tell ALSA,
"hey, this is really screwed up, just abort playback and return an
error to the app"?

-- 
Timur Tabi
Linux kernel developer at Freescale
