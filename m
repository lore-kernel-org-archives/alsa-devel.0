From: Daniel Drake <dsd@laptop.org>
Subject: Microphone bias
Date: Mon, 13 Jul 2009 09:50:45 +0100
Message-ID: <1247475045.1759.5.camel@polyethylene>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ey-out-2122.google.com (ey-out-2122.google.com [74.125.78.24])
	by alsa0.perex.cz (Postfix) with ESMTP id ED3582435B
	for <alsa-devel@alsa-project.org>;
	Mon, 13 Jul 2009 10:50:48 +0200 (CEST)
Received: by ey-out-2122.google.com with SMTP id 22so456739eye.47
	for <alsa-devel@alsa-project.org>; Mon, 13 Jul 2009 01:50:48 -0700 (PDT)
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

I'm working on CX20582 HDA support for OLPC.

We have a choice of 50% or 80% microphone bias on the 2 microphone ports
(one inbuilt, one socket for external devices). Any suggestions on which
one we should pick or how to decide?

We can't hear any difference between the 2 settings..should we choose
50% for potential power savings?

Daniel
