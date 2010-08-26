From: David Santamauro <david.santamauro@gmail.com>
Subject: Re: ice1712 and the delta 1010
Date: Thu, 26 Aug 2010 09:27:13 -0400
Message-ID: <20100826092713.3debd6c1@debussy>
References: <20100826065854.519ee1d3@debussy>
	<4C7665CC.5080302@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qy0-f172.google.com (mail-qy0-f172.google.com
	[209.85.216.172])
	by alsa0.perex.cz (Postfix) with ESMTP id 0D025103816
	for <alsa-devel@alsa-project.org>;
	Thu, 26 Aug 2010 15:30:29 +0200 (CEST)
Received: by qyk1 with SMTP id 1so6708497qyk.17
	for <alsa-devel@alsa-project.org>; Thu, 26 Aug 2010 06:30:29 -0700 (PDT)
In-Reply-To: <4C7665CC.5080302@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


Hi,

On Thu, 26 Aug 2010 15:02:04 +0200
Clemens Ladisch <clemens@ladisch.de> wrote:

> David Santamauro wrote:
> > Since upgrading my audio PC to 64-bit,
> 
> Hardware or software upgrade?

Both ... I should say the 32-bit linux test was done on different
hardware. The events were:

a) pc1, fedora 11 32-bit both maudio delta 1010 and 2496 coexist happily
b) pc2 new build to be a 64-bit machine
c) pulled delta 1010 out of pc1, inserted into pc2 -- noise
d) installed win7 64-bit in dual boot configuration on pc2, no noise
with delta 1010

> 
> > the delta 1010 analog inputs emit a constant 'hiss' -36 -30dB.
> > Analog outputs and digital ins and outs are fine. The delta 1010
> > from a hardware perspective is fine as I tested it on the same pc
> > hardware under windows7 64-bit.
> 
> In theory, this sounds like a driver bug.
> 
> > So far, I have tested it in a 32-bit fedora, 32-bit windows vista
> > and 64-bit windows7 all successfully. This problem arises only in
> > 64-bit fedora.
> 
> Does the 32-bit Linux use the same driver version?

To be honest, I'm not sure exactly how to check. They are the latest
versions of fedora 11 (32-bit) and fedora 12 (64-bit).
srcversion from a modinfo yields different results.

32-bit fedora 11
Linux beethoven 2.6.29.6-1.rt23.4.fc11.ccrma.i586.rt
srcversion:     F7E1C076BE18C5DFF723A6E


64-bit fedora 12
Linux debussy 2.6.31.12-1.rt21.1.fc12.ccrma.x86_64.rt
srcversion:     0B183929429B4C5102B7D09

> If yes, then it's possible that the 32-bit and 64-bit kernels
> configure the PC differently; for example, there might be noise on
> the power line due to a different kind of power management.

another interesting angle... I thought it might be power or some kind
of internal noise. How could I pursue that further?

David
