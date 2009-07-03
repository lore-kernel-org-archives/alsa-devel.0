From: Kenneth Johansson <kenneth@southpole.se>
Subject: Re: [PATCH] Sample generation on big endian platforms
	was broken.
Date: Fri, 03 Jul 2009 19:04:20 +0200
Message-ID: <1246640660.31770.18.camel@localhost.localdomain>
References: <1246630771.7922.25.camel@localhost.localdomain>
	<s5hab3lj0fb.wl%tiwai@suse.de>
	<1246632695.7922.34.camel@localhost.localdomain>
	<s5h4ottizg8.wl%tiwai@suse.de>
	<1246633897.7922.39.camel@localhost.localdomain>
	<s5hws6phjk8.wl%tiwai@suse.de>  <s5hmy7lhiyl.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.southpole.se (mail.southpole.se [193.12.106.18])
	by alsa0.perex.cz (Postfix) with ESMTP id C623824963
	for <alsa-devel@alsa-project.org>;
	Fri,  3 Jul 2009 19:04:28 +0200 (CEST)
In-Reply-To: <s5hmy7lhiyl.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, 2009-07-03 at 17:41 +0200, Takashi Iwai wrote:

> ... and the code doesn't handle the case of 3 byte format, too.
> 
> 
> Takashi
> 

Soo ? there is a lot of formats this code can't generate. It's a test
program and I doubt anybody has ever tried to change the output format
since it has never worked for most formats.

but if you want to add support for 3 bytes then there is no way around
having two different storage methods one for BIG and one for LITTLE
endian machines.
