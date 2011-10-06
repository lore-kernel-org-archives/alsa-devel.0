From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Patch submission process (was: [PATCH] Add "Line
 In" input jack constants)
Date: Thu, 6 Oct 2011 11:00:37 +0100
Message-ID: <20111006100037.GA14518@opensource.wolfsonmicro.com>
References: <4E8C6332.2080902@canonical.com>
	<20111005150753.GB13377@sirena.org.uk>
	<4E8D4EBE.6030703@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 4C7FE24570
	for <alsa-devel@alsa-project.org>;
	Thu,  6 Oct 2011 12:00:39 +0200 (CEST)
Content-Disposition: inline
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
Cc: Takashi Iwai <tiwai@suse.de>, ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Thu, Oct 06, 2011 at 08:46:22AM +0200, David Henningsson wrote:
> On 10/05/2011 05:07 PM, Mark Brown wrote:
> >but please follow the patch submission process in SubmittingPatches - in
> >particular, don't send your patch as an attachment.

> I find this hard to fulfil at times, in particular when I want to
> add something to the email that I don't want to be a part of the
> commit message. Is this possible with git send-email, and without
> sending the patch as an attachment?

The relevant section of SubmittingPatches is:

|  - A marker line containing simply "---".
|
|   - Any additional comments not suitable for the changelog.
|
|   - The actual patch (diff output).

You can edit the patch after running format-patch, or use --annotate
with send-mail.
