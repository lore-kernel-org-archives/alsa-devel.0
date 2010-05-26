From: Arnaud Patard <apatard@mandriva.com>
Subject: Re: [patch 4/5] orion/kirkwood: Add i2s support
Date: Wed, 26 May 2010 10:25:34 +0200
Message-ID: <m34ohvgjcx.fsf@anduin.mandriva.com>
References: <20100525122236.841941526@mandriva.com>
	<20100525122341.443140710@mandriva.com>
	<alpine.LFD.2.00.1005252025210.24526@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.mandriva.com (mx1.moondrake.net [212.85.150.166])
	by alsa0.perex.cz (Postfix) with ESMTP id 692E124696
	for <alsa-devel@alsa-project.org>;
	Wed, 26 May 2010 10:25:30 +0200 (CEST)
In-Reply-To: <alpine.LFD.2.00.1005252025210.24526@xanadu.home> (Nicolas
	Pitre's message of "Tue, 25 May 2010 20:31:00 -0400 (EDT)")
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Nicolas Pitre <nico@fluxnic.net>
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, saeed@marvell.com, tbm@cyrius.com, linux-arm-kernel@lists.infradead.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

Nicolas Pitre <nico@fluxnic.net> writes:

Hi,

> On Tue, 25 May 2010, apatard@mandriva.com wrote:
>
>> This patch enables support for the i2s controller available on orion/kirkwood platforms
>> 
>> Signed-off-by: Arnaud Patard <apatard@mandriva.com>
>
> The actual Orion processor family has no I2S/audio support.  It would be 
> better if all the audio related stuff was renamed to "kirkwood" and 
> "KIRKWOOD_*" instead.

I've been told there was some orion with audio. As I've never looked at
the orion family in details, I assumed this is right and I've changed the
naming accordingly. I can change again but it would be nice to have an
agreement here. Who's/what's right ? orion can or can not have i2s audio ?


Arnaud
