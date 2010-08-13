From: Daniel Chen <seven.steps@gmail.com>
Subject: Re: intel 8x0 ALSA driver in virtualbox - choppy sound
Date: Fri, 13 Aug 2010 13:07:23 -0400
Message-ID: <AANLkTimMopMesUzACpfNR6r4f8sLS4P2PpP1-qegcxhL@mail.gmail.com>
References: <AANLkTimduCOUeqdd=M6q7Qf6m55Q_8yn9EXQfROQJ4Gh@mail.gmail.com>
	<AANLkTi=DVX6iSTXzT3WMqYC_RViqbOWe7gFn+h6Kow8u@mail.gmail.com>
	<alpine.LNX.2.00.1008131718300.10278@eeebox2.perex-int.cz>
	<s5hfwyiv6nl.wl%tiwai@suse.de>
	<AANLkTimXcy26EkE4Og+rLrDV0+S3VqfkHjiZirgeX7w+@mail.gmail.com>
	<AANLkTi=CZUSggYNua7NfhyowCP++u-LU45cB-A47UtSy@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 91D27103899
	for <alsa-devel@alsa-project.org>;
	Fri, 13 Aug 2010 19:07:24 +0200 (CEST)
Received: by wwi17 with SMTP id 17so965535wwi.20
	for <alsa-devel@alsa-project.org>; Fri, 13 Aug 2010 10:07:24 -0700 (PDT)
In-Reply-To: <AANLkTi=CZUSggYNua7NfhyowCP++u-LU45cB-A47UtSy@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Lex F <archguest@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Aug 13, 2010 at 12:38 PM, Lex F <archguest@gmail.com> wrote:
> I believe it's direct ALSA, I have choppy output even with
> aplay /usr/share/sounds/alsa/*.wav

Make sure you aren't being routed through pulse; i.e., try:
aplay -Dplug:front /usr/share/sounds/alsa/*.wav
