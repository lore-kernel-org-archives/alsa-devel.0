From: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: [PATCH 10/10] wss_lib: use wss detection code
 instead of ad1848 one
Date: Thu, 24 Jul 2008 22:05:39 +0200
Message-ID: <4888E093.5000404@keyaccess.nl>
References: <20080718215126.7128a6f9.krzysztof.h1@poczta.fm>	<4883632A.8090106@keyaccess.nl>	<4887A28F.90506@keyaccess.nl>	<20080724072620.4197510c.krzysztof.h1@poczta.fm>	<4888B993.2040101@keyaccess.nl>
	<20080724204734.0ae77007.krzysztof.h1@poczta.fm>
	<4888D854.40509@keyaccess.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq1.tilbu1.nb.home.nl (smtpq1.tilbu1.nb.home.nl
	[213.51.146.200])
	by alsa0.perex.cz (Postfix) with ESMTP id 3A7D3103821
	for <alsa-devel@alsa-project.org>;
	Thu, 24 Jul 2008 22:03:19 +0200 (CEST)
In-Reply-To: <4888D854.40509@keyaccess.nl>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Krzysztof Helt <krzysztof.h1@poczta.fm>
Cc: Takashi Iwai <tiwai@suse.de>, Alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 24-07-08 21:30, Rene Herman wrote:

> I'm not surprised. The CS4232 part of your chip will advertise itself
>  with ID CSC0000 or CSC0100 in /sys/devices/pnp0/<foo>/id and you 
> probably have a CSC0010 or CSC0110 as one of the other devices in
> there. I noticed this before when debugging someone else's system on
> alsa-user a while ago. That latter ID is the CS4236 control port.
> These things should really just be driven as CS4236.
> 
> If you have this laptop for long enough, we'll get that going...

That's confused. The CSC0{0,1}10 is the CS4232 control port, the PNPBIOS 
driver just isn't using it. But yes, see the PNPID tables in there. From 
the device IDs you don't know cs4232 from cs4236.

Were you in fact planning on merging cs4236_lib as well? Then we can 
just do runtime switching.

Rene
