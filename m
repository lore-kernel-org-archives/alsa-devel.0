From: Lex F <archguest@gmail.com>
Subject: Re: intel 8x0 ALSA driver in virtualbox - choppy sound
Date: Fri, 13 Aug 2010 21:25:00 +0100
Message-ID: <AANLkTim1XGs+XbkZ9K+6cDEx02Tp2TpBoWyE0p9MGr2J@mail.gmail.com>
References: <AANLkTimduCOUeqdd=M6q7Qf6m55Q_8yn9EXQfROQJ4Gh@mail.gmail.com>
	<AANLkTi=DVX6iSTXzT3WMqYC_RViqbOWe7gFn+h6Kow8u@mail.gmail.com>
	<alpine.LNX.2.00.1008131718300.10278@eeebox2.perex-int.cz>
	<s5hfwyiv6nl.wl%tiwai@suse.de>
	<AANLkTimXcy26EkE4Og+rLrDV0+S3VqfkHjiZirgeX7w+@mail.gmail.com>
	<AANLkTi=CZUSggYNua7NfhyowCP++u-LU45cB-A47UtSy@mail.gmail.com>
	<AANLkTimMopMesUzACpfNR6r4f8sLS4P2PpP1-qegcxhL@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 81F191038C8
	for <alsa-devel@alsa-project.org>;
	Fri, 13 Aug 2010 22:25:01 +0200 (CEST)
Received: by wwi17 with SMTP id 17so1166745wwi.20
	for <alsa-devel@alsa-project.org>; Fri, 13 Aug 2010 13:25:01 -0700 (PDT)
In-Reply-To: <AANLkTimMopMesUzACpfNR6r4f8sLS4P2PpP1-qegcxhL@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Chen <seven.steps@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 13 August 2010 18:07, Daniel Chen <seven.steps@gmail.com> wrote:
> On Fri, Aug 13, 2010 at 12:38 PM, Lex F <archguest@gmail.com> wrote:
>> I believe it's direct ALSA, I have choppy output even with
>> aplay /usr/share/sounds/alsa/*.wav
>
> Make sure you aren't being routed through pulse; i.e., try:
> aplay -Dplug:front /usr/share/sounds/alsa/*.wav
>

I am perfectly sure it is not being routed through pulse as I do not
have pulse installed. I run arch linux and I know pretty much every
package on my system :)

For the sake of experiment, I run the command as you suggested and it
did not make any difference.

I have just booted the kernel with sound debug on, will see what it tells.
