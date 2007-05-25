From: "Nobin Mathew" <nobin.mathew@gmail.com>
Subject: [ALSA] ALSA Power Management,
	Drivers behaving unexpectedly after suspend/resume cycle
Date: Fri, 25 May 2007 11:27:10 +0530
Message-ID: <8d6898730705242257k6da2088fi80f0d4034ed78986@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nz-out-0506.google.com (nz-out-0506.google.com [64.233.162.231])
	by alsa0.perex.cz (Postfix) with ESMTP id 200DC243F7
	for <alsa-devel@alsa-project.org>;
	Fri, 25 May 2007 07:57:11 +0200 (CEST)
Received: by nz-out-0506.google.com with SMTP id i11so810458nzi
	for <alsa-devel@alsa-project.org>; Thu, 24 May 2007 22:57:10 -0700 (PDT)
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

I am implementing power management in my ALSA sound drivers. ALSA
drivers are not working properly after resume. All registers values
are proper and I am able to read back the codec register contents.

If I do a playback after resume then I am getting lots of "underrun".


After a reboot playback is working fine.

Is there any known issues with ALSA power  management?
Why Ubuntu and Redhat does ALSA modules removal before suspend and
insertion after resume?
