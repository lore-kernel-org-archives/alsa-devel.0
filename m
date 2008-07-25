From: "Peter Dolding" <oiaohm@gmail.com>
Subject: alsa-lib has anyone ever looked at taking it cross
	platform?
Date: Fri, 25 Jul 2008 17:49:03 +1000
Message-ID: <e7d8f83e0807250049h60fabd30x295d739ee6f21e98@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rv-out-0708.google.com (rv-out-0708.google.com [209.85.198.251])
	by alsa0.perex.cz (Postfix) with ESMTP id A68B22445C
	for <alsa-devel@alsa-project.org>;
	Fri, 25 Jul 2008 09:49:04 +0200 (CEST)
Received: by rv-out-0708.google.com with SMTP id f25so2413006rvb.32
	for <alsa-devel@alsa-project.org>; Fri, 25 Jul 2008 00:49:03 -0700 (PDT)
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

This would kinda make logical sence.

Alsa-lib plugin system in theory should be able to take any kind sound
output under it.   Simplify development of all applications on top of
it.  If alsa was cross platform why would you use something else as a
middle body wrapper when you port.

Windows and Mac support could be done as plugins.

Or is there something that is in the alsa-lib that is a problem?

Its all about reducing distance between application and hardware and
reduce amount of coding.

Peter Dolding
