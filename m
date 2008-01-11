From: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: PNP_DRIVER_RES_DISABLE breaks swsusp at least with
 snd_cs4236
Date: Fri, 11 Jan 2008 15:21:55 +0100
Message-ID: <47877B83.5040604@keyaccess.nl>
References: <200801092343.48726.linux@rainbow-software.org>	<47857A82.4050005@keyaccess.nl>	<Pine.LNX.4.61.0801100849290.30240@tm8103.perex-int.cz>	<4786C40B.8050005@keyaccess.nl>
	<20080111080141.75aaad5f@poseidon.drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq2.groni1.gr.home.nl (smtpq2.groni1.gr.home.nl
	[213.51.130.201])
	by alsa0.perex.cz (Postfix) with ESMTP id CD86124556
	for <alsa-devel@alsa-project.org>; Fri, 11 Jan 2008 15:24:59 +0100 (CET)
In-Reply-To: <20080111080141.75aaad5f@poseidon.drzeus.cx>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Pierre Ossman <drzeus@drzeus.cx>
Cc: Andrew Morton <akpm@osdl.org>, ALSA development <alsa-devel@alsa-project.org>, Ondrej Zary <linux@rainbow-software.org>, Takashi Iwai <tiwai@suse.de>, Linux Kernel <linux-kernel@vger.kernel.org>, Bjorn Helgaas <bjorn.helgaas@hp.com>
List-Id: alsa-devel@alsa-project.org

On 11-01-08 08:01, Pierre Ossman wrote:

> On Fri, 11 Jan 2008 02:19:07 +0100
> Rene Herman <rene.herman@keyaccess.nl> wrote:
> 
>> I see a PnP resume _consists_ of setting the resources so I can see the test 
>> implementation wise, but yes, conceptually it seems this test shouldn't be 
>> present. So just like the attached then?
>>
>> Pierre, what was the idea here? Added the other SOBs to the CC as well...
>>
> 
> You assume there was an idea? ;)
> 
> I don't remember why things were done the way they were. And I can't find
> any clues in the correspondence around the issue. So your guess is as
> good as mine.

Hrmpf. Well, okay. Ondrej -- I assume this patch fixes things?

Rene.
