From: "Nobin Mathew" <nobin.mathew@gmail.com>
Subject: Mic and Line In Capture AC97 slots issue
Date: Thu, 10 May 2007 02:45:42 +0530
Message-ID: <8d6898730705091415s74685223r4c4409e87ff587c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nz-out-0506.google.com (nz-out-0506.google.com [64.233.162.226])
	by alsa0.perex.cz (Postfix) with ESMTP id 6952A244B9
	for <alsa-devel@alsa-project.org>;
	Wed,  9 May 2007 23:15:44 +0200 (CEST)
Received: by nz-out-0506.google.com with SMTP id l8so339856nzf
	for <alsa-devel@alsa-project.org>; Wed, 09 May 2007 14:15:43 -0700 (PDT)
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
Cc: linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

http://mailman.alsa-project.org/pipermail/alsa-devel/2007-May/000835.html
http://mailman.alsa-project.org/pipermail/alsa-devel/2007-May/000837.html

the overrun  issue was because my application was not fast enough.

I resolved that problem by disabling capture of AC-Link slot4 in my
ac97 controller.
So capture happens only in slot3.

According to ac97 spec Mic comes in Slot6 of AC-Link.

I am using wolfson wm9713 codec.

In this LineR and LineL are routed to LeftADC and RightADC.

And Mic1 (Mic A) is also coonected to LeftADC and RightADC.


So i am assuming that Mic 1 will come in Slot3 and Slot4.

But my application is taking only mono data, so XRUN will happen.


What is the correct configuration for this?
What should be the configuration if i want to capture both Line IN and Mic?
means AC-Link settings

Thanks
