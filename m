From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: ASoC:Question rate constraint between the dais
Date: Fri, 16 Mar 2012 21:00:12 +0100
Message-ID: <4F639BCC.2050703@metafoo.de>
References: <64362.10.252.27.21.1331805184.squirrel@linux.intel.com>	<20120315175310.GR3138@opensource.wolfsonmicro.com>	<CA+7tXijgsT3uitVa-=VLmKY2ubQpgff0hkKjA5jz6QCFp9_PiA@mail.gmail.com>
	<20120316192513.GJ3158@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailhost.informatik.uni-hamburg.de
	(mailhost.informatik.uni-hamburg.de [134.100.9.70])
	by alsa0.perex.cz (Postfix) with ESMTP id 4F76D243A2
	for <alsa-devel@alsa-project.org>; Fri, 16 Mar 2012 20:59:53 +0100 (CET)
In-Reply-To: <20120316192513.GJ3158@opensource.wolfsonmicro.com>
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
Cc: Ramesh Babu <ramesh.babu@linux.intel.com>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Trent Piepho <tpiepho@gmail.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On 03/16/2012 08:25 PM, Mark Brown wrote:
> On Thu, Mar 15, 2012 at 05:28:13PM -0400, Trent Piepho wrote:
> 
>> There is a race when the constraints change dynamically.  See the
>> fsl_ssi.c driver and the sample size constraint in synchronous mode.
> 
> This is just a limitation of the ALSA ABI - there's nothing we can do
> about it without changing the userspace interface so we just have to
> live with it and error out if an application ever manages to hit the
> race and pick something incompatible with other active streams (note
> that the symmetric rates support has a dev_warn() complaining about
> hitting the race).
> 

I think the real problem with this is, that currently a userspace application
will usually exit with an error when such a race occurs, while it should be
possible to just restart the enumeration process and try with another format.

So I'm wondering if we can make it easier for userspace to detect that the
constraints have changed and it may retry with other parameters? E.g. return a
special error code in such a case.

- Lars
