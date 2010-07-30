From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Driver for AK4555 codec
Date: Thu, 29 Jul 2010 23:59:51 -0700
Message-ID: <33CE47F6-34E9-4E47-A8F6-C1091C1708D2@opensource.wolfsonmicro.com>
References: <AANLkTimnYLEe-sK2_DcYQAGqVYd+JnsJaSpRfdKBbeEi@mail.gmail.com>
	<20100729184233.GA9469@sirena.org.uk>
	<AANLkTinWJT36u99_vxOqXOADRNBT9VMy_5mOsBLE1PLO@mail.gmail.com>
	(sfid-20100730_074556_543508_C034D218)
Mime-Version: 1.0 (iPad Mail 7B405)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 13AC8103826
	for <alsa-devel@alsa-project.org>;
	Fri, 30 Jul 2010 08:59:16 +0200 (CEST)
In-Reply-To: <AANLkTinWJT36u99_vxOqXOADRNBT9VMy_5mOsBLE1PLO@mail.gmail.com>
	(sfid-20100730_074556_543508_C034D218)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Yoran Brondsema <yoran.brondsema@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 29 Jul 2010, at 23:45, Yoran Brondsema <yoran.brondsema@gmail.com> wrote:

> On 29 July 2010 20:42, Mark Brown <broonie@opensource.wolfsonmicro.com> wrote:
> On Thu, Jul 29, 2010 at 09:18:43AM +0200, Yoran Brondsema wrote:

Don't drop CCs to the mailing lists; if nothing else advice is often useful to other people searching the mailing list archives.

> So my main question is whether I have to write this lpc3xxx-ak4555.c. It would be great if someone could clear me up on  this.

Yes, you'll have to write a driver for your machine. It says how the CODEC and CPU are wired up on your particular board - either component could also be used with another device, or another machine may have a different way of connecting the same components which requires a different setup.
