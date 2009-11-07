From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 6/7] S3C64XX PCM: Defined PCM controller
 platform devices
Date: Sat, 7 Nov 2009 12:14:29 +0000
Message-ID: <20091107121427.GB3228@sirena.org.uk>
References: <1257384907-18338-1-git-send-email-jassi.brar@samsung.com>
	<20091106165406.GG4938@sirena.org.uk>
	<1b68c6790911061921o39e2609fwa7112f21ff916216@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id EE5091037FB
	for <alsa-devel@alsa-project.org>; Sat,  7 Nov 2009 13:14:34 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1b68c6790911061921o39e2609fwa7112f21ff916216@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: jassi brar <jassisinghbrar@gmail.com>
Cc: alsa-devel@alsa-project.org, Jassi Brar <jassi.brar@samsung.com>, ben-linux@fluff.org
List-Id: alsa-devel@alsa-project.org

On Sat, Nov 07, 2009 at 12:21:43PM +0900, jassi brar wrote:
> On Sat, Nov 7, 2009 at 1:54 AM, Mark Brown

> > Might be good to call the devices "samsung-pcm" rather than "s3c-pcm" or
> > whatever the decision is on a common prefix to cope with the s5p CPUs.

> Well, pcm_<version> wud be even better.
> with 'samsung-pcm' we run out of a good option if the newer SoCs come with
> different version of the PCM Controller.

That'd be fine as well, though I don't see a problem with omitting the
version just now and then adding a second file with a version appended
if a second version does crop up.
