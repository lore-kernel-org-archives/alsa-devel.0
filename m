From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Patch submission process
Date: Thu, 06 Oct 2011 10:55:51 +0200
Message-ID: <4E8D6D17.50004@ladisch.de>
References: <4E8C6332.2080902@canonical.com>	<20111005150753.GB13377@sirena.org.uk>
	<4E8D4EBE.6030703@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3.smtp.messagingengine.com (out3.smtp.messagingengine.com
	[66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id 88D8F103A65
	for <alsa-devel@alsa-project.org>;
	Thu,  6 Oct 2011 10:56:28 +0200 (CEST)
In-Reply-To: <4E8D4EBE.6030703@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: David Henningsson <david.henningsson@canonical.com>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On 10/06/2011 08:46 AM, David Henningsson wrote:
> On 10/05/2011 05:07 PM, Mark Brown wrote:
> > ... don't send your patch as an attachment.
>
> I find this hard to fulfil at times, in particular when I want to add
> something to the email that I don't want to be a part of the commit
> message. Is this possible with git send-email, and without sending the
> patch as an attachment?

Use "git send-email --annotate", and delimit the something from the
commit message with a scissors line (man git-am).


Regards,
Clemens
