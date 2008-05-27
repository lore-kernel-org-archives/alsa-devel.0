From: "kunal@singhkunal.com" <kunal@singhkunal.com>
Subject: bandwidth issue with usb-audio in alsa
Date: Tue, 27 May 2008 00:23:18 -0400
Message-ID: <380-22008522742318173@M2W010.mail2web.com>
Reply-To: kunal@singhkunal.com
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from xsmtp08.mail2web.com (xsmtp08.mail2web.com [168.144.250.208])
	by alsa0.perex.cz (Postfix) with ESMTP id 08B0C248F2
	for <alsa-devel@alsa-project.org>;
	Tue, 27 May 2008 06:23:20 +0200 (CEST)
Received: from [168.144.108.10] (helo=M2W010.mail2web.com)
	by xsmtp08.mail2web.com with smtp (Exim 4.63)
	(envelope-from <kunal@singhkunal.com>) id 1K0qiU-0003WF-85
	for alsa-devel@alsa-project.org; Tue, 27 May 2008 00:23:19 -0400
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

  My Platform
 -------------
  I am trying to stream audio data from a USB-device (an iPod) to my
arm-based embedded device (running kernel 2.6.23). The USB-device confirms
to usb digital audio (subclass - streaming) class. The endpoint buffer size
196 bytes and transfer period is 1 msec. So, I should be reading data every
msec.

  Problem
  -----------
  I am facing some bandwidth issues. The data is not being captured fast
enough.

  I notice that once one set of URBs are captured (one set equal to
MAX_URBS), there is a significant delay in capturing the next set of URBs. =


     I have set MAX_URBS equal to 32.
     When I connect a USB-Analyzer and analyze the timings, I can see that
32 URBs are captured at a interval of 1 msec each. After that there is a
break of around 250 msec. And then again 32 URBs captured in sequence.

      If I change the MAX_URBs to any other value N, N URBs get captured at
interval of 1 msec each, and then there is a break.

      Can some one suggest a way to improve this problem. Is there some
configuration or parameter which I can change, so that URBs get submitted
fast enough? May be as soon as the old one has retired.

Thanks and Regards,
Kunal
www.singhkunal.com
  =


--------------------------------------------------------------------
mail2web.com =96 What can On Demand Business Solutions do for you?
http://link.mail2web.com/Business/SharePoint
