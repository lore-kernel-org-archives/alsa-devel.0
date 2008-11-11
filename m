From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH] ALSA SOC driver for s3c24xx with uda1341
Date: Tue, 11 Nov 2008 15:52:15 +0000
Message-ID: <20081111155215.GF7019@sirena.org.uk>
References: <12261302352402-git-send-email-chripell@gmail.com>
	<20081110220959.GH22835@trinity.fluff.org>
	<cabda6420811110614k73d97d4are33f5471044e86a4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 4E55C243B8
	for <alsa-devel@alsa-project.org>; Tue, 11 Nov 2008 16:52:17 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <cabda6420811110614k73d97d4are33f5471044e86a4@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: chri <chripell@gmail.com>
Cc: zdevai@gmail.com, alsa-devel@alsa-project.org, linux-arm-kernel@lists.arm.linux.org.uk, Ben Dooks <ben-linux@fluff.org>
List-Id: alsa-devel@alsa-project.org

On Tue, Nov 11, 2008 at 03:14:04PM +0100, chri wrote:
> On Mon, Nov 10, 2008 at 11:09 PM, Ben Dooks <ben-linux@fluff.org> wrote:

> > find somewhere for these to live that can be included without
> > resorting to knowing the directory layout.

> ack, I'll try include/sound

If they (you cut context so I'm not sure what exactly they are) are only
referenced within ASoC leave them in sound/soc/codecs which is idiomatic
for that.  Otherwise either include/sound or arch/arm depending on if
it's ARM/Samsung specific or not.

-- 
"You grabbed my hand and we fell into it, like a daydream - or a fever."
