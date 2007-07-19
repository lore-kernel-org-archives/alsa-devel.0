From: Tobin Davis <tdavis@dsl-only.net>
Subject: Re: The users view of an audio card
Date: Thu, 19 Jul 2007 10:52:19 -0700
Message-ID: <1184867539.4826.10.camel@razman.gruemaster.com>
References: <200707191812.55106.david.webb@noc.soton.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from iron2.pdx.net (iron2.pdx.net [69.64.224.71])
	by alsa0.perex.cz (Postfix) with ESMTP id A86A72433C
	for <alsa-devel@alsa-project.org>;
	Thu, 19 Jul 2007 19:52:26 +0200 (CEST)
In-Reply-To: <200707191812.55106.david.webb@noc.soton.ac.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: David Webb <david.webb@noc.soton.ac.uk>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, 2007-07-19 at 18:12 +0100, David Webb wrote:

> (2.2a  Where can an AD'97 manual be found? - I could not find one on
> the intel 
> site) 

The AC'97 PRM is here:
http://download.intel.com/design/chipsets/manuals/30701701.pdf
The Intel HD Audio PRM is here:
http://download.intel.com/design/chipsets/manuals/30234903.pdf

Both are specs for onboard codec buses.  More recent chipsets utilize
the HD Audio bus specification, as it gives superior output capabilities
and supports more devices (like modems and other vendor defined codecs).
One of the main improvements over the AC'97 spec is the uniform
programming interface (which is one of the problems you seem to be
running into).

Beyond that, others will need to interject more answers to your
questions.

-- 
Tobin Davis  


In every non-trivial program there is at least one bug.
