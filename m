From: andoru <andoru.blah@gmail.com>
Subject: Re:
	=?utf-8?q?Invalid_PCM_pointer_with_CMI8738_and_pcm?=
	=?utf-8?q?=2Ec_buffer=09underuns?=
Date: Thu, 27 Mar 2014 20:44:37 +0000 (UTC)
Message-ID: <loom.20140327T213645-260@post.gmane.org>
References: <loom.20140326T163743-253@post.gmane.org>
 <CAN8ccib45znh-JbH57EhfbPNQg_fginmX9Tbr=yKMmd4D=iygQ@mail.gmail.com>
 <CAN8cciZkGx5XBO+u0b7V9YN8VU_rz8ckL8B=6oBFJr+-Yg8cxw@mail.gmail.com>
 <CAN8cciYy4V4StjqRfPpgZ8JMEYZrvpJYCBjfZtNhcn_2enRx6g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from plane.gmane.org (plane.gmane.org [80.91.229.3])
 by alsa0.perex.cz (Postfix) with ESMTP id 37190265486
 for <alsa-devel@alsa-project.org>; Thu, 27 Mar 2014 21:45:07 +0100 (CET)
Received: from list by plane.gmane.org with local (Exim 4.69)
 (envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1WTHAc-0001Xm-2T
 for alsa-devel@alsa-project.org; Thu, 27 Mar 2014 21:45:02 +0100
Received: from cl-86-125-141-178.cablelink.mures.rdsnet.ro ([86.125.141.178])
 by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
 id 1AlnuQ-0007hv-00
 for <alsa-devel@alsa-project.org>; Thu, 27 Mar 2014 21:45:02 +0100
Received: from andoru.blah by cl-86-125-141-178.cablelink.mures.rdsnet.ro with
 local (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00
 for <alsa-devel@alsa-project.org>; Thu, 27 Mar 2014 21:45:02 +0100
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

> Seem cannot read valid value from register within three trials
> 
> state.CMI8738 {
> control.1 {
> 
> [...]
> 
> Seem bug in adding channel map to iec958 instead of analog

What does that mean? What should I do with those patches?
Should I apply them and try to compile the latest ALSA version?

> 
> pcm.!default {
>     type plug
>     slave.pcm "dmixer"
> }
> 
> You need asym plugin for playback and capture when overwrite pcm.default
> 

Should I change my /etc/asound.conf like in the examples here?
http://alsa.opensrc.org/Asym
