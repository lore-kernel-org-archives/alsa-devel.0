From: ext-jukka.hynninen@vaisala.com
Subject: Re: ASoC WM8510 Mic PGA problem
Date: Tue, 7 Oct 2008 16:29:43 +0300
Message-ID: <B9D3C48C98930741A166756A50C44A610F17B55D@helx1.corp.vaisala.com>
References: <B9D3C48C98930741A166756A50C44A610F17B555@helx1.corp.vaisala.com>
	<20081003133936.GD26035@sirena.org.uk>
	<B9D3C48C98930741A166756A50C44A610F17B556@helx1.corp.vaisala.com>
	<20081006100522.GB14087@sirena.org.uk>
	<B9D3C48C98930741A166756A50C44A610F17B55A@helx1.corp.vaisala.com>
	<20081007121144.GA5119@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailgw.vaisala.com (mailgw.vaisala.com [192.81.123.24])
	by alsa0.perex.cz (Postfix) with ESMTP id 68660245A7
	for <alsa-devel@alsa-project.org>;
	Tue,  7 Oct 2008 15:29:58 +0200 (CEST)
Received: from helsrv02.vaisala.com (helsrv02.vaisala.com [192.81.123.16])
	by mailgw.vaisala.com (8.13.6/8.13.6) with SMTP id m97DTixg030915
	for <alsa-devel@alsa-project.org>; Tue, 7 Oct 2008 16:29:44 +0300
Content-class: urn:content-classes:message
In-Reply-To: <20081007121144.GA5119@rakim.wolfsonmicro.main>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: broonie@opensource.wolfsonmicro.com
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Quoting Mark Brown:

>> The control changes state when recording starts. Playback has no
effect
>> on it.
> Could you please give the patch below a spin?  I've not tested it but
I
> believe it may help.

Mic PGA still keeps turning off.

Anyway, I noticed an interesting point (applying the patch had no effect
on this):
The first recording on a freshly booted system seems to complete without
changing the status of Mic PGA control.


-Jukka
