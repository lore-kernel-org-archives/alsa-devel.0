From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH V2 2/3] add set_tdm_slot in tdm dai to
 define the relationship between audio channel and tdm slot
Date: Wed, 19 Aug 2009 12:34:01 +0100
Message-ID: <20090819113400.GC18285@rakim.wolfsonmicro.main>
References: <1250137511-24034-1-git-send-email-21cnbao@gmail.com>
	<20090817175010.GA19707@rakim.wolfsonmicro.main>
	<3c17e3570908171953l65c9d04i99ad6fa72b88d001@mail.gmail.com>
	<20090818131117.GA12512@rakim.wolfsonmicro.main>
	<3c17e3570908181834q6dd0e0c5n157697bd02836b35@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 6207E2434C
	for <alsa-devel@alsa-project.org>;
	Wed, 19 Aug 2009 13:34:04 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <3c17e3570908181834q6dd0e0c5n157697bd02836b35@mail.gmail.com>
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
Cc: uclinux-dist-devel@blackfin.uclinux.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, Aug 19, 2009 at 09:34:16AM +0800, Barry Song wrote:

> The timing is like the attached diagram, I think it's not I2S but like DSP.

Yup, that DSP mode with I2S like channel layout (does it also do TDM in
I2S mode by any chance?).  Could you submit a version of your patch
which uses the default TDM layout - an API to rewrite things is likely
to be a separate API?
