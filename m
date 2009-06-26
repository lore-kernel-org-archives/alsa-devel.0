From: Baek Chang <baeksan@ccrma.stanford.edu>
Subject: routing audio stream to multiple devices
Date: Thu, 25 Jun 2009 18:46:10 -0700
Message-ID: <aceb60a00906251846v2f9607dcp8f89c4379f7bc097@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.244])
	by alsa0.perex.cz (Postfix) with ESMTP id 616F2245F2
	for <alsa-devel@alsa-project.org>;
	Fri, 26 Jun 2009 03:46:11 +0200 (CEST)
Received: by an-out-0708.google.com with SMTP id c37so665517anc.2
	for <alsa-devel@alsa-project.org>; Thu, 25 Jun 2009 18:46:10 -0700 (PDT)
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

I was wondering if it was possible to route a single audio stream to
multiple alsa devices or plugins?

For example, I am playing a song and want it to stream to both my sound card
at hw:0 and a bluetooth device, an alsa plugin.  Is this possible?  It seems
that configuring asound.conf only lets you route streams serially to a
single device at a time.  Any info would be greatly appreciated.

Thanks in advance
Baek

-- 
Baek Chang
baeksan@ccrma.stanford.edu
407-267-6701
