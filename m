From: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH 2/4] ASoC: soc-cache: Add support for
 standard register caching
Date: Sun, 24 Oct 2010 08:18:59 -0500
Message-ID: <AANLkTi=eWCO71FTj38rS4dehjo+DoLvSGQa6fXgqaaJq@mail.gmail.com>
References: <1287757702-9573-1-git-send-email-dp@opensource.wolfsonmicro.com>
	<1287757702-9573-3-git-send-email-dp@opensource.wolfsonmicro.com>
	<20101022160351.GE16521@opensource.wolfsonmicro.com>
	<1287858254.9010.7.camel@dplaptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1287858254.9010.7.camel@dplaptop>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com, Liam@alsa-project.org, Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Sat, Oct 23, 2010 at 1:24 PM, Dimitris Papastamos
<dp@opensource.wolfsonmicro.com> wrote:
> The only problem I see with the above code, is when
> codec_drv->reg_word_size > sizeof (unsigned int) but that can't really
> happen in practice.

I'm going to have to agree with Mark that this code is suspect.  I
understand everything you said, but it makes me nervous.  Unless this
code is in some kind of fast-path, I would prefer to see it rewritten
to avoid any assumption about the sizes of the types involved.

-- 
Timur Tabi
Linux kernel developer at Freescale
