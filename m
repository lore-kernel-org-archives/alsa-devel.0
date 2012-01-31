From: public-hk <public-hk@ind.rwth-aachen.de>
Subject: Re: Some questions related to ALSA based duplex	audio
 processing
Date: Tue, 31 Jan 2012 12:07:56 +0100
Message-ID: <4F27CB8C.2050804@ind.rwth-aachen.de>
References: <4F259BD1.4030001@ind.rwth-aachen.de>
	<20120129203102.GA20883@linuxaudio.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mta-2.ms.rz.rwth-aachen.de (mta-2.ms.rz.RWTH-Aachen.DE
	[134.130.7.73]) by alsa0.perex.cz (Postfix) with ESMTP id 82421103A5B
	for <alsa-devel@alsa-project.org>; Tue, 31 Jan 2012 12:07:55 +0100 (CET)
Received: from ironport-out-1.rz.rwth-aachen.de ([134.130.5.186])
	by mta-2.ms.rz.RWTH-Aachen.de
	(Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008))
	with ESMTP id <0LYN006KQTL7GH10@mta-2.ms.rz.RWTH-Aachen.de> for
	alsa-devel@alsa-project.org; Tue, 31 Jan 2012 12:07:55 +0100 (CET)
Received: from mail.ind.rwth-aachen.de
	(mail.ind.RWTH-Aachen.DE [137.226.238.9])	by smarthost.rwth-aachen.de
	(8.14.4+Sun/8.13.8/1) with ESMTP id q0VB7tvk016443	for
	<alsa-devel@alsa-project.org>; Tue, 31 Jan 2012 12:07:55 +0100 (CET)
Received: from [137.226.198.65] (pontos.ind.RWTH-Aachen.DE [137.226.198.65])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)	by mail.ind.rwth-aachen.de (Postfix)
	with ESMTP id 0454216740BA	for <alsa-devel@alsa-project.org>; Tue,
	31 Jan 2012 12:07:55 +0100 (CET)
In-reply-to: <20120129203102.GA20883@linuxaudio.org>
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

thank you very much for this hint. I noticed that there are also some other
interesting publications on the referred webpage!

Best regards

HK

Am 29.01.2012 21:31, schrieb Fons Adriaensen:
> On Sun, Jan 29, 2012 at 08:19:45PM +0100, public-hk wrote:
>
>> I have just started to develop a duplex audio processing application
>> based on ALSA.
>> My development goals are - of course - maximum stability as well as
>> lowest possible delay (latency).
> Have a look at the zita-alsa-pcmi library. It probably does all
> you need - it takes care of the zillions of calls necessary to
> initialise mmap access, and provides/accepts floating point audio
> samples regardless of the soundcard's format. No documentation ATM
> but the examples should get you going. It's C++, but using on the
> class mechanism, no templates, dependency on C++ libriries etc.
>
> <http://kokkinizita.linuxaudio.org/linuxaudio/downloads>
>
