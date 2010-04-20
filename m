From: The Source <thesourcehim@gmail.com>
Subject: [REGRESSION] SB X-Fi Notebook stopped working in 1.0.23
Date: Wed, 21 Apr 2010 00:17:12 +0400
Message-ID: <4BCE0BC8.3020201@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.157])
	by alsa0.perex.cz (Postfix) with ESMTP id 8EE382437A
	for <alsa-devel@alsa-project.org>;
	Tue, 20 Apr 2010 22:17:16 +0200 (CEST)
Received: by fg-out-1718.google.com with SMTP id e21so2624871fga.2
	for <alsa-devel@alsa-project.org>; Tue, 20 Apr 2010 13:17:15 -0700 (PDT)
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

This device works fine with 1.0.22.1 driver, but doesn't with 1.0.23. 
snd-usb-audio & Ko are loaded but to no good. alsamixer doesn't list the 
device and no device files in /dev/snd. Reverting back to 1.0.22.1 
solves the problem.
System: ASUS N51Vf laptop, OS: Fedora 12 2.6.31.12-174.2.3.fc12.x86_64
