From: Peter Hsiang <Peter.Hsiang@maxim-ic.com>
Subject: Re: synchronized block of register writes
Date: Wed, 6 Apr 2011 17:01:59 -0700
Message-ID: <B2150E1E4418E1438554A300EA5040E40DAC7749CD@ITSVLEX06.it.maxim-ic.internal>
References: <B2150E1E4418E1438554A300EA5040E40DAC77494E@ITSVLEX06.it.maxim-ic.internal>
	<20110406224851.GB5297@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from antispam01.maxim-ic.com (antispam01.maxim-ic.com
	[205.153.101.182])
	by alsa0.perex.cz (Postfix) with ESMTP id 1DDCF10389D
	for <alsa-devel@alsa-project.org>;
	Thu,  7 Apr 2011 02:03:09 +0200 (CEST)
In-Reply-To: <20110406224851.GB5297@opensource.wolfsonmicro.com>
Content-Language: en-US
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
Cc: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Lars-Peter Clausen <lars@metafoo.de>, Takashi Iwai <tiwai@suse.de>, Liam@alsa-project.org, Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Wed, Apr 06, Mark Brown wrote:
> On Wed, Apr 06, 2011 at 03:28:10PM -0700, Peter Hsiang wrote:
> 
> > Hi Mark and Everyone,
> 
> Fix your mailer to word wrap at 80 columns, I've reflowed your text.

Sorry about that.  The email client/server is too "smart."
It is already set to 80 columns.  Until I figure out a more 
permanent solution, I will add a [return] at the end of each line.
> 
> > When a codec driver control handling function needs to write a group
> > of registers without any other register of the same codec being
> > written to in parallel by ALSA, what is the best way to do this under
> > the snd-soc codec driver architecture?  In the current architecture,
> > does the driver's control handling function execute serially with
> > other ALSA automated activities?
> 
> The framework should be taking care of locking for you in most
> situations.  If you implement custom controls you will want to take the
> CODEC mutex while applying changes from them (most of the existing
> drivers are lax about this) and similarly for IRQs.

Ok thanks!
