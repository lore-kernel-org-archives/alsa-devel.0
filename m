From: Alex Lee <alexlee188@gmail.com>
Subject: Re: USB Audio device syncpipe error
Date: Mon, 13 Sep 2010 14:42:40 +0000 (UTC)
Message-ID: <loom.20100913T163316-848@post.gmane.org>
References: <AANLkTinzHSVgsUocCMBTW=+A=b2qc6vzKuq7t9jzgojX@mail.gmail.com>	<AANLkTi=EXqFDPn+a1K+OeLA+G5pnh0yMt6nX2VA_wQDD@mail.gmail.com>	<4C8891D2.1020300@ladisch.de>	<AANLkTingHyn2wyJ50uH9GpjnTg_YsL6Q0gzDoVyArvgv@mail.gmail.com>
	<AANLkTimzCNquUNQapdo4afcwtBYYVHGPH9U-J1xXHqXE@mail.gmail.com>
	<4C89D7CC.3070605@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lo.gmane.org (lo.gmane.org [80.91.229.12])
	by alsa0.perex.cz (Postfix) with ESMTP id 8653624413
	for <alsa-devel@alsa-project.org>;
	Mon, 13 Sep 2010 16:42:53 +0200 (CEST)
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1OvAF6-0007JR-Mv
	for alsa-devel@alsa-project.org; Mon, 13 Sep 2010 16:42:48 +0200
Received: from 220.255.7.193 ([220.255.7.193])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Mon, 13 Sep 2010 16:42:48 +0200
Received: from alexlee188 by 220.255.7.193 with local (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Mon, 13 Sep 2010 16:42:48 +0200
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

Clemens Ladisch <clemens <at> ladisch.de> writes:

> 
> 6275 kson wrote:
> > Well I basically understand what is wrong.  Usbaudio is expecting the packet
> > size to be 4 and the value to be encoded as 16.16 because the device is
> > operating at high speed.  I made the change and my device now shows up
> > properly as an output device and playback works but the feedback polling
> > interval is incorrect.
> 
> What interval do you expect in this situation, and what interval do you


Hi kson,

bInterval in HS is in terms of uFrame, ie 128us.  In FS it is in Frame, ie 1ms.

Also, the feedback endpoint may be using bRefresh instead of bInterval to 
determine the
 interval to check the feedback sample rate.

I'm also implementing the async iso OUT with feedback using UAC1 at HS right
 now so I'm 
following your posts :-)

Alex
