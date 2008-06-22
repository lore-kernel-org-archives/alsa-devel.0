From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: [PATCH] alsa: add annotations to bitwise
	type	snd_pcm_hw_param_t
Date: Sun, 22 Jun 2008 08:50:40 +0100
Message-ID: <20080622075040.GR28946@ZenIV.linux.org.uk>
References: <1213821913.2125.21.camel@brick>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [195.92.253.2])
	by alsa0.perex.cz (Postfix) with ESMTP id 8517924683
	for <alsa-devel@alsa-project.org>;
	Sun, 22 Jun 2008 09:50:41 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1213821913.2125.21.camel@brick>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Harvey Harrison <harvey.harrison@gmail.com>
Cc: alsa-devel@alsa-project.org, Alexander Viro <viro@ftp.linux.org.uk>
List-Id: alsa-devel@alsa-project.org

On Wed, Jun 18, 2008 at 01:45:13PM -0700, Harvey Harrison wrote:
> Fully half of all alsa sparse warnings are from snd_pcm_hw_param_t degrading
> to integer type, this goes a long way towards eliminating them.

FWIW, *all* this stuff is not bitwise at all.  For crying out loud, half
of these types are routinely used as array indices and loop variables...

If anything, we want a different set of allowed operations - subtraction
between elements of type (yielding integer), addition/subtraction of
integer types not bigger than ours (yielding our type), comparisons,
assignments (=, +=, -=, passing to function as argument, return from
function, initializers) and second/third arguments in ?:.  With 0 *not*
being allowed as a constant of such type.

It's not bitwise; we may use the same infrastructure in sparse, but it
should be a separate class of types (__attribute__((affine))).

dma_addr_t is another candidate for the same treatment, but there we'll
need helpers for conversions to hw-acceptable form (dma_to_le32(), etc.)
and gradual conversion of drivers.

ALSA ones and pm mess are absolutely straightforward cases, though.
