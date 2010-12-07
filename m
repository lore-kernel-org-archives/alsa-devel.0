From: Jassi Brar <jassisinghbrar@gmail.com>
Subject: Re: [PATCH 3/3] ASoC: SAMSUNG: Match spdif source
 clock id and asoc platform device
Date: Tue, 7 Dec 2010 11:10:22 +0900
Message-ID: <AANLkTimSDD7xie6CN-D9j_9u4taYy3anwvqQVdwmA1vm@mail.gmail.com>
References: <1291368453-30905-1-git-send-email-sw.youn@samsung.com>
	<1291369067-31429-1-git-send-email-sw.youn@samsung.com>
	<20101203114416.GG3182@sirena.org.uk>
	<AANLkTinw3+t=eVLRUiRhwPA2c_nZ7q7Kfm-QOBmsZLRT@mail.gmail.com>
	<20101206124611.GA1924@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51])
	by alsa0.perex.cz (Postfix) with ESMTP id C3CAA103827
	for <alsa-devel@alsa-project.org>; Tue,  7 Dec 2010 03:10:22 +0100 (CET)
Received: by fxm15 with SMTP id 15so9787725fxm.38
	for <alsa-devel@alsa-project.org>; Mon, 06 Dec 2010 18:10:22 -0800 (PST)
In-Reply-To: <20101206124611.GA1924@rakim.wolfsonmicro.main>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, lrg@slimlogic.co.uk, jassi.brar@samsung.com, Seungwhan Youn <sw.youn@samsung.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Dec 6, 2010 at 9:46 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Sun, Dec 05, 2010 at 12:40:01AM +0900, Jassi Brar wrote:

>> It's necessary evil ATM.
>> There is no access to SPDIF device in machine code and we need to
>> get/set the clock.
>> So the soc-audio is used as a place-holder.
>
> In order to do this you need to tell the clock framework about the ASoC
> virtual device - once you're doing stuff like that you may as well just
> fix the S/PDIF driver to let you do what you need.

Assuming I understand you correctly, the problem still remains of having the
S/PDIF driver to setup clock hierarchies -- which is the job of the
board init code, IMHO.
So until we have proper clock subsystem and board init code to handle
such scenarios
we have to do that in ASoC machine driver in such hackish way.
