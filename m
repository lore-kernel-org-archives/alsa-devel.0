From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: SND-SOC - how to test drivers ?
Date: Wed, 1 Dec 2010 10:30:23 +0000
Message-ID: <20101201103022.GA5688@sirena.org.uk>
References: <AANLkTikE9aF38vg9WkYAVWTSXY23E7qxkQRyfsBJas6Y@mail.gmail.com>
	<AANLkTimT0aoTP+MghUvvRru83hCyCG_ALKxbvOBOcQTW@mail.gmail.com>
	<AANLkTi=SLNeQ5mEFKztB9cmDh3AUVz0fYOB6LGKzf6nL@mail.gmail.com>
	<AANLkTikBz5t-hUxQYfF6Q_hwyO50hxgxfhhF-FaoAjT4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id B77E81039F7
	for <alsa-devel@alsa-project.org>; Wed,  1 Dec 2010 11:30:24 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <AANLkTikBz5t-hUxQYfF6Q_hwyO50hxgxfhhF-FaoAjT4@mail.gmail.com>
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
Cc: alsa-devel@alsa-project.org, Vaclav Peroutka <vaclavpe@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Dec 01, 2010 at 08:34:48AM +0900, Jassi Brar wrote:

> Please make sure you use the same I2S device (indexed) in ASoC machine
> driver as your board init file adds to the platform.

For debugging stuff like this look at the files in debugfs for ASoC and
also #define DEBUG at the top of soc-core.c to get a bunch of trace
showing what's being registered and waited for.
