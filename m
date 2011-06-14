From: =?ISO-8859-1?Q?Aur=E9lien_Leblond?= <blablack@gmail.com>
Subject: Subject= @Daniel Mack: Send you a FTU
Date: Tue, 14 Jun 2011 10:17:05 +0100
Message-ID: <BANLkTinVHE6+pZnOG+zRuC_HSdJmoswf1Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vx0-f179.google.com (mail-vx0-f179.google.com
	[209.85.220.179])
	by alsa0.perex.cz (Postfix) with ESMTP id EFE2224611
	for <alsa-devel@alsa-project.org>;
	Tue, 14 Jun 2011 11:17:06 +0200 (CEST)
Received: by vxi40 with SMTP id 40so4828369vxi.38
	for <alsa-devel@alsa-project.org>; Tue, 14 Jun 2011 02:17:05 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: To=BANLkTinn8voTA8itkaP64xqzYDxFeJRqSQ@mail.gmail.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

>> I saw on the mailing that you a Felix have been doing a great deal of
>> work to provide better support for the M-Audio FastTrack Ultra.
>> I tested yesterday the new patch that provides mixer and the
>> possibility to change the internal routing of the soundcard... I can
>> finally use all the input/output to use external FX, that's very
>> handy!
>>
>> Anyway, on the M-Audio forum, Felix has been mentionning several times
>> that there were few bugs that needed to be fixed with this soundcard,
>> but that you needed to get your hand on one device to fix them (and
>> may be even improve things around its support in general).
>
>Quite frankly, I'm not fully aware about known issues with these
>devices that need attention. Could you summarize which problems are
>left to look at?

There are still the issue of samples dropping.

Tto reproduce it:
- Open Audacity and set it up to be using Jack.
- Click Generate -> Tone -> Ok.

"Normally" you should hear very regular pops...
