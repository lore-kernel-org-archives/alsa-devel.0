From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 3/3] ASoC: SAMSUNG: Match spdif
	source	clock id and asoc platform device
Date: Tue, 7 Dec 2010 11:19:46 +0000
Message-ID: <20101207111946.GB10722@sirena.org.uk>
References: <1291368453-30905-1-git-send-email-sw.youn@samsung.com>
	<1291369067-31429-1-git-send-email-sw.youn@samsung.com>
	<20101203114416.GG3182@sirena.org.uk>
	<AANLkTinw3+t=eVLRUiRhwPA2c_nZ7q7Kfm-QOBmsZLRT@mail.gmail.com>
	<20101206124611.GA1924@rakim.wolfsonmicro.main>
	<AANLkTimSDD7xie6CN-D9j_9u4taYy3anwvqQVdwmA1vm@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id A476510381A
	for <alsa-devel@alsa-project.org>; Tue,  7 Dec 2010 12:19:47 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <AANLkTimSDD7xie6CN-D9j_9u4taYy3anwvqQVdwmA1vm@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jassi Brar <jassisinghbrar@gmail.com>
Cc: alsa-devel@alsa-project.org, Seungwhan Youn <sw.youn@samsung.com>, jassi.brar@samsung.com, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Tue, Dec 07, 2010 at 11:10:22AM +0900, Jassi Brar wrote:
> On Mon, Dec 6, 2010 at 9:46 PM, Mark Brown

> > In order to do this you need to tell the clock framework about the ASoC
> > virtual device - once you're doing stuff like that you may as well just
> > fix the S/PDIF driver to let you do what you need.

> Assuming I understand you correctly, the problem still remains of having the
> S/PDIF driver to setup clock hierarchies -- which is the job of the
> board init code, IMHO.
> So until we have proper clock subsystem and board init code to handle
> such scenarios
> we have to do that in ASoC machine driver in such hackish way.

It may be that what's needed in the S/PDIF driver is to provide a way to
get the device for the S/PDIF controller so that the machine driver can
fiddle with it.  Actually, you can do that anyway as the device will be
associated with the DAI - the machine driver can just look at dai->dev
to get the struct device for the S/PDIF controller.
