From: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Subject: Re: hdspmixer broken for 96khz
Date: Sun, 3 Apr 2011 10:16:06 +0200
Message-ID: <20110403081606.GG28811@ltw.loris.tv>
References: <in74oi$qce$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ltw.loris.tv (ltw.loris.tv [85.14.220.160])
	by alsa0.perex.cz (Postfix) with ESMTP id 2A36F24386
	for <alsa-devel@alsa-project.org>;
	Sun,  3 Apr 2011 10:16:32 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <in74oi$qce$1@dough.gmane.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Tim Blechmann <tim@klingt.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sat, Apr 02, 2011 at 02:28:02PM +0200, Tim Blechmann wrote:

Hi!

> the updated hdspmixer doesn't work for 96khz any more. the 44.1/48 khz
> versions are drawn correctly, the 88.2/96 khz version hides all
> controls, so just the menu is visible.

I've seen "both", a *working* hdspmixer at 96k and all hidden controls.
The latter could be caused by wrongly initialized or restored presets.

Can you try to activate the controls in the View menu again? Maybe even
the shortcuts work: I for Input section, P for Playback and O for
Output.


Cheers

-- 
mail: adi@thur.de  	http://adi.thur.de	PGP/GPG: key via keyserver

The trouble with being punctual is that nobody's there to appreciate it.
                -- Franklin P. Jones
