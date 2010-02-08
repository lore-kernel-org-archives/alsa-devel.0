From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: DMA interrupt not getting triggered(nailed the
 problem need solution)
Date: Mon, 8 Feb 2010 14:42:35 +0000
Message-ID: <20100208144235.GB18148@rakim.wolfsonmicro.main>
References: <5781224.897561265631357494.JavaMail.weblogic@epml09>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 266981037EA
	for <alsa-devel@alsa-project.org>; Mon,  8 Feb 2010 15:42:38 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <5781224.897561265631357494.JavaMail.weblogic@epml09>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ANISH KUMAR <anish.singh@samsung.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, jassi brar <jassisinghbrar@gmail.com>, "ben-linux@fluff.org" <ben-linux@fluff.org>, "JaroslavKyselaperex@perex.cz" <JaroslavKyselaperex@perex.cz>
List-Id: alsa-devel@alsa-project.org

On Mon, Feb 08, 2010 at 12:15:57PM +0000, ANISH KUMAR wrote:
> > If the initial hardware state happens to result in LRCLK being where the
>  >lrsync() function is trying to get it then the driver will start up, but
>  >the misclocking of the configuration will result in ALSA detecting an
>  >error which will eventually result in a restart of the audio stream.

> From the lrsync function i know that it is just trying to check whether a particular
> bit is set or not.So according to my understanding this lrsync function will timeout if the 
> clock itself is not coming.

Right, if you check the datasheet for the part you'll see that this bit
reports the state of the LRSYNC clock.  This means that it is possible
that the pin may read back the expected logic level for whatever reason
even if things aren't being clocked properly - for example, there may be
a very slow clock present.

> Please forgive for not understanding your reply.
> But i am not able to understand "where the lrsync() function is trying to get-FROM YOUR REPLY"??
> And misclocking of the configuration??Please explain this term(googling didn't help much).

Your machine driver will have set up the clocks for the audio subsystem
in a way that doesn't work in your hardware.  You need to understand how
the audio subsystem is connected together on your hardware and make sure
your machine driver is setting up something appropriate.  Without
knowing about the specific hardware it's hard to say anything definite.

In general if the CODEC has a crystal attached directly to it then the
CODEC should be the clock master on the digital audio interface, which
tends to make life easier for things like this.
