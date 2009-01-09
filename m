From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: PATCH: Cleanup duplicate code
Date: Fri, 9 Jan 2009 01:06:36 +0000
Message-ID: <20090109010633.GA29904@sirena.org.uk>
References: <49669C42.408@mnementh.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 226881037FC
	for <alsa-devel@alsa-project.org>; Fri,  9 Jan 2009 02:06:42 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <49669C42.408@mnementh.co.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Ian Molton <ian@mnementh.co.uk>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Jan 09, 2009 at 12:37:22AM +0000, Ian Molton wrote:

> I noticed this function has been copied, 'cookie cutter' style in a lot 
> of codec drivers.

This looks good but please also make it print out an error saying what
fails if it detects a problem.  None of the existing code does this but
we've caught several bugs in existing drivers by adding such checks to
as part of the bulk registration functions that were added already so
it'd be good to do.
