From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RFC PATCH] HDA: Generic input jack handling
Date: Fri, 7 Oct 2011 12:52:49 +0100
Message-ID: <20111007115249.GJ19080@opensource.wolfsonmicro.com>
References: <4E8EE75A.3050809@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id E5D01103B61
	for <alsa-devel@alsa-project.org>;
	Fri,  7 Oct 2011 13:52:50 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4E8EE75A.3050809@canonical.com>
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

On Fri, Oct 07, 2011 at 01:49:46PM +0200, David Henningsson wrote:

> 3) Todo for realtek parser is to clean up all other calls to 
> snd_input_jack_report so that jacks are not reported twice.

FWIW this is relatively minor as duplicate reports are silently eaten by
the core (it makes drivers a lot simpler).
