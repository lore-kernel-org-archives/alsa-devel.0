From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: ASoC: pxa2xx-i2s
Date: Wed, 21 Jan 2009 13:23:14 +0000
Message-ID: <20090121132313.GA29953@sirena.org.uk>
References: <4975E030.5080905@acdstar.com> <4975F160.8040001@gmail.com>
	<4976042B.6060604@acdstar.com> <49764F15.6080008@acdstar.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 00613243C3
	for <alsa-devel@alsa-project.org>; Wed, 21 Jan 2009 14:23:15 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <49764F15.6080008@acdstar.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Brian Rhodes <bgr@acdstar.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Jan 20, 2009 at 04:24:21PM -0600, Brian Rhodes wrote:

> This method also works, and does not affect the the other stream.  The 
> difference for me really seems to be that when DREC is set and DRPL is 
> cleared when i2s is enabled it will occasionally never start.  I cannot 

Without checking the datasheet for the chip this looks broadly
reasonable to me.

> recreate the issue by with the original code if I initialize SACR1 to 
> set DREC in startup and do not reset it in hw_params.  It is possible 
> the problem is with the codec.  TLV320dac2x.

What is the clock master in your system?

> hours.  Nothing in the i2s controller documentation mentions the 
> possibility of anything in the hardware disabling replay, so I am 
> confused what is happening here.

If chip documentation were always complete and accurate the world would
be a much better place :)
