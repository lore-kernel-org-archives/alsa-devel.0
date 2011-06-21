From: Taylor Hutt <thutt@google.com>
Subject: Re: [PATCH] ASoC: codecs: Max98095: Fix logging of
	hardware revision.
Date: Tue, 21 Jun 2011 07:52:41 -0700
Message-ID: <BANLkTinfL8uSdCvrQYPJb1TQH3HSCu=wAPFZv-AcWRw1_jspXg@mail.gmail.com>
References: <1308596072-17158-1-git-send-email-thutt@chromium.org>
	<20110621002322.GE1905@opensource.wolfsonmicro.com>
	<B2150E1E4418E1438554A300EA5040E40DDEC16D42@ITSVLEX06.it.maxim-ic.internal>
	<20110621011038.GA4322@opensource.wolfsonmicro.com>
	<20110621115547.GD25032@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out.google.com (smtp-out.google.com [216.239.44.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 0833510396B
	for <alsa-devel@alsa-project.org>;
	Tue, 21 Jun 2011 16:52:46 +0200 (CEST)
Received: from hpaq6.eem.corp.google.com (hpaq6.eem.corp.google.com
	[172.25.149.6]) by smtp-out.google.com with ESMTP id p5LEqjKp013601
	for <alsa-devel@alsa-project.org>; Tue, 21 Jun 2011 07:52:45 -0700
Received: from pzk37 (pzk37.prod.google.com [10.243.19.165])
	by hpaq6.eem.corp.google.com with ESMTP id p5LEqgUS031059
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
	for <alsa-devel@alsa-project.org>; Tue, 21 Jun 2011 07:52:43 -0700
Received: by pzk37 with SMTP id 37so8764200pzk.1
	for <alsa-devel@alsa-project.org>; Tue, 21 Jun 2011 07:52:41 -0700 (PDT)
In-Reply-To: <20110621115547.GD25032@sirena.org.uk>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Peter Hsiang <Peter.Hsiang@maxim-ic.com>, Olof Johansson <olofj@chromium.org>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Tue, Jun 21, 2011 at 4:55 AM, Mark Brown <
broonie@opensource.wolfsonmicro.com> wrote:

> On Tue, Jun 21, 2011 at 02:10:39AM +0100, Mark Brown wrote:
> > On Mon, Jun 20, 2011 at 05:43:58PM -0700, Peter Hsiang wrote:
>
> > > I checked with hardware engineering and was told 0x40=RevA, 0x41=RevB..
>
> > > Would a raw value or the use of a 0x3F bit mask be more acceptable?
>
> > I don't mind (though it does seem like the high bit isn't part of the
> > actual data), it was just that it's a common error to assume that die
> > revisions and package revisions correspond directly.
>
> This means if you're OK with it I can apply the patch as-is, BTW.
>


Please let me know if you'd like me to continue splitting this patch into
two changes.

(Also, informationally, max98088.c also uses a constant instead of
ARRAY_SIZE in the same context.  I don't know if it suffers from the
same hardware revision output issue, as I don't have that hardware...)

thutt
-- 
There is no better hors d'oeuvres than bacon wrapped dates.
