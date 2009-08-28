From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH V2 2/3] add set_tdm_slot in tdm dai to
 define the relationship between audio channel and tdm slot
Date: Fri, 28 Aug 2009 13:42:21 +0100
Message-ID: <1251463341.5039.28.camel@finisterre.sirena.org.uk>
References: <1250137511-24034-1-git-send-email-21cnbao@gmail.com>
	<20090817175010.GA19707@rakim.wolfsonmicro.main>
	<3c17e3570908171953l65c9d04i99ad6fa72b88d001@mail.gmail.com>
	<20090818131117.GA12512@rakim.wolfsonmicro.main>
	<3c17e3570908181834q6dd0e0c5n157697bd02836b35@mail.gmail.com>
	<20090819113400.GC18285@rakim.wolfsonmicro.main>
	<3c17e3570908191937h53f5bcf0mb9c753b94402e3f5@mail.gmail.com>
	(sfid-20090820_033751_624635_5CC9C0EB)
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id B280824364
	for <alsa-devel@alsa-project.org>;
	Fri, 28 Aug 2009 15:51:37 +0200 (CEST)
In-Reply-To: <3c17e3570908191937h53f5bcf0mb9c753b94402e3f5@mail.gmail.com>
	(sfid-20090820_033751_624635_5CC9C0EB)
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

On Thu, 2009-08-20 at 10:37 +0800, Barry Song wrote:
> On Wed, Aug 19, 2009 at 7:34 PM, Mark
> Brown<broonie@opensource.wolfsonmicro.com> wrote:

> > Yup, that DSP mode with I2S like channel layout (does it also do TDM in
> > I2S mode by any chance?).  Could you submit a version of your patch
> > which uses the default TDM layout - an API to rewrite things is likely
> > to be a separate API?

> I don't know what is your exact meaning.  Do you mean I send a patch
> whose tdm slot is not changed, then send a patch which change the tdm
> slot?

Send a patch that allows selection of the active slots without rewriting

Although thinking about it I'm not sure if the driver is actually
implementing TDM or not - does the CPU actually get configured to stop
driving the data line during an inactive slot (so something else can
drive it) or is it simply sending zeros on those slots?
