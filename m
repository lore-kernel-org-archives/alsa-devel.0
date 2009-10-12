From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: dev_* output functions and ASoC codecs
Date: Mon, 12 Oct 2009 10:36:02 +0100
Message-ID: <20091012093601.GA22233@sirena.org.uk>
References: <8bd0f97a0910051718w5d97df8dr443917def9da9ac@mail.gmail.com>
	<20091006102033.GC27168@sirena.org.uk>
	<3c17e3570910111926u186586cdq2646d5aaade3121a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id E2C33103854
	for <alsa-devel@alsa-project.org>;
	Mon, 12 Oct 2009 11:36:02 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <3c17e3570910111926u186586cdq2646d5aaade3121a@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Barry Song <21cnbao@gmail.com>
Cc: "Cai, Cliff" <Cliff.Cai@analog.com>, alsa-devel@alsa-project.org, Mike Frysinger <vapier.adi@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Oct 12, 2009 at 10:26:09AM +0800, Barry Song wrote:

Please don't top post and please start new threads for new topics.

> We use many global variables in asoc now, except defining two/multi
> groups of global variables to fulfill two/multi codecs work at the
> same time in one system, is there any other way?

Could you be more specific about which variables you are talking about
here?  In general you should just use the struct device driver data or
a private data field in one of the ASoC structures for any per-device
data, in much the same way as you would do for any other system.
