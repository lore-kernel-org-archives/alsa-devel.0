From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: ALSA processor usage is too high
Date: Fri, 5 Nov 2010 18:51:04 +0000
Message-ID: <20101105185103.GB29680@sirena.org.uk>
References: <AANLkTik-sb1OihaDhNgptH44gQ4__E+ozxhSKpA9GdSK@mail.gmail.com>
	<4CD41528.1060600@ladisch.de>
	<AANLkTinXm2G1y477xRTc_QjXuEZ_nyAqGWuSkq32KGe2@mail.gmail.com>
	<4CD445BD.3020501@ladisch.de>
	<AANLkTi=kMF=_1u40yTtvA=oSpyyQn=nEF_JHY_NskiAw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id D45BF1039B5
	for <alsa-devel@alsa-project.org>; Fri,  5 Nov 2010 19:51:04 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <AANLkTi=kMF=_1u40yTtvA=oSpyyQn=nEF_JHY_NskiAw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Adam Rosenberg <adam@alcorn.com>
Cc: alsa-devel@alsa-project.org, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

On Fri, Nov 05, 2010 at 02:45:41PM -0400, Adam Rosenberg wrote:

> I am not sure how to interpret this, but I told aplay to play for 3
> minutes from /dev/zero and here are the results:
> root:/> time aplay -d 180 -D hw -t raw -f dat /dev/zero
> Playing raw data '/dev/zero' : Signed 16 bit Little Endian, Rate 48000
> Hz, Stereo
> real    3m 0.10s

This means that the application ran for 3m 0.1s...

> user    0m 0.22s

...during this time it spent 220ms in the actual application

> sys     0m 8.48s

...and 8.48s in kernel mode.
