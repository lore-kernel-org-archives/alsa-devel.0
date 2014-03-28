From: andoru <andoru.blah@gmail.com>
Subject: Re: Invalid PCM pointer with CMI8738 and pcm.c buffer
	underuns
Date: Fri, 28 Mar 2014 14:28:12 +0000 (UTC)
Message-ID: <loom.20140328T152008-235@post.gmane.org>
References: <loom.20140326T163743-253@post.gmane.org>
 <CAN8ccib45znh-JbH57EhfbPNQg_fginmX9Tbr=yKMmd4D=iygQ@mail.gmail.com>
 <CAN8cciZkGx5XBO+u0b7V9YN8VU_rz8ckL8B=6oBFJr+-Yg8cxw@mail.gmail.com>
 <CAN8cciYy4V4StjqRfPpgZ8JMEYZrvpJYCBjfZtNhcn_2enRx6g@mail.gmail.com>
 <loom.20140327T213645-260@post.gmane.org>
 <CAN8ccibOwd24r-qCrcnrZXaPy5We6dB=GccDyTR_qS-rPns1uw@mail.gmail.com>
 <5335360C.9060806@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from plane.gmane.org (plane.gmane.org [80.91.229.3])
 by alsa0.perex.cz (Postfix) with ESMTP id CA4902654D3
 for <alsa-devel@alsa-project.org>; Fri, 28 Mar 2014 15:28:39 +0100 (CET)
Received: from list by plane.gmane.org with local (Exim 4.69)
 (envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1WTXlu-00086E-GV
 for alsa-devel@alsa-project.org; Fri, 28 Mar 2014 15:28:38 +0100
Received: from cl-86-125-141-116.cablelink.mures.rdsnet.ro ([86.125.141.116])
 by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
 id 1AlnuQ-0007hv-00
 for <alsa-devel@alsa-project.org>; Fri, 28 Mar 2014 15:28:38 +0100
Received: from andoru.blah by cl-86-125-141-116.cablelink.mures.rdsnet.ro with
 local (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00
 for <alsa-devel@alsa-project.org>; Fri, 28 Mar 2014 15:28:38 +0100
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

> yes, you need define both playback and capture if you overwrite pcm.default
> since dmix does not support capture

I'm less concerned with the capture part of this card as I record audio
through the mic of the webcam anyway. But having added that, it hasn't
solved my previous problem with not being able to hear sounds from multiple
sources, and also I can't use alsamixer now.

> >>> Seem bug in adding channel map to iec958 instead of analog
> >>
> >> What does that mean?
> 
> Nothing relevant to this problem.
> 
> >> What should I do with those patches?
> 
> Nothing.

So I guess that means there aren't really any solutions to my bug? What
happens next? (sorry for all the annoying questions)
