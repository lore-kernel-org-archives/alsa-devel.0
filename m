From: Robert Hancock <hancockrwd@gmail.com>
Subject: ice1724 SPDIF buffer size?
Date: Wed, 07 Oct 2009 00:01:33 -0600
Message-ID: <4ACC2EBD.2010108@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yx0-f178.google.com (mail-yx0-f178.google.com
	[209.85.210.178])
	by alsa0.perex.cz (Postfix) with ESMTP id 983F724438
	for <alsa-devel@alsa-project.org>;
	Wed,  7 Oct 2009 08:01:37 +0200 (CEST)
Received: by yxe8 with SMTP id 8so5273266yxe.17
	for <alsa-devel@alsa-project.org>; Tue, 06 Oct 2009 23:01:35 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Alsa-Devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

I noticed that in the ice1724 driver, we set a default and maximum 
preallocated buffer size of 256K for the "professional" stream, but only 
64K for the SPDIF and independent stereo pair streams, even though the 
hardware supports 256K for all streams. Is there any reason why we can't 
use 256K for all of them?

I made this change here and it seems to work fine (for SPDIF at least, 
haven't tested stereo). From a power and CPU usage perspective, it makes 
sense to allow as big a buffer as possible for when latency isn't critical..
