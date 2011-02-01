From: Vincent Meserette <vmeserette@aldebaran-robotics.com>
Subject: issue with AD1989A HDA codec and alsamixer
Date: Tue, 1 Feb 2011 15:57:29 +0100
Message-ID: <AANLkTin8tsrNrcoYaPvQz0uO=OtD-tow1Ds0i8WTJyh7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
	[209.85.215.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 78E17103948
	for <alsa-devel@alsa-project.org>; Tue,  1 Feb 2011 15:57:30 +0100 (CET)
Received: by eyg24 with SMTP id 24so2972727eyg.38
	for <alsa-devel@alsa-project.org>; Tue, 01 Feb 2011 06:57:30 -0800 (PST)
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

Hi all,

I am working on a system which includes a connexant AD1989A HDA codec
connected to a ATOM processor.
I have four microphones connected to the B and C ports of this codec.
If I change one of the 3 capture gains present in the alsamixer
(Capture, Capture 1 or Capture 3), I can't have any more signal on the
B and C ports
It seems to be due to the fact that ALSA breaks (for example for the
Capture gain) the link between the ADC selector 0 and ADC_0 widgets of
the codec, what can be easily seen with codecgraph.

Have you ever had this kind of problem?
Do you know how can I resolve it ?

Many thanks for your asnwers and best regards

Vincent
