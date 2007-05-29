From: "Lorenz Kolb" <alsa-dev@lkmail.de>
Subject: Re: Reasonable sound hardware parameters?
Date: Tue, 29 May 2007 21:15:09 +0200
Message-ID: <000001c7a225$ae486c20$0ad94460$@de>
References: <000401c7a10e$71729fe0$5457dfa0$@de>
	<Pine.LNX.4.61.0705281419030.7894@tm8103.perex-int.cz>
	<001501c7a1d7$68709e00$3951da00$@de>
	<Pine.LNX.4.61.0705292011350.7894@tm8103.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from pm1.terions.de (pm1.terions.de [83.137.96.25])
	by alsa0.perex.cz (Postfix) with ESMTP id 0E777243D1
	for <alsa-devel@alsa-project.org>;
	Tue, 29 May 2007 21:15:15 +0200 (CEST)
In-Reply-To: <Pine.LNX.4.61.0705292011350.7894@tm8103.perex-int.cz>
Content-Language: de
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: 'Jaroslav Kysela' <perex@suse.cz>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, 29 May 2007 Jaroslav wrote:
> 
> Yes, I know about Linux flexibility, but I'm curious what's special in
> your hardware platform - or what was the reason to design a new
> platform
> (you mentioned that main CPU is not very powerful). Several PC based
> platforms exist with Geode or VIA processors which has enough I/Os
> integrated including AC97 sound and PCI slots for further expansion..
> Maybe size of final product or a special acceleration?
> 
> 						Jaroslav

Ok, now I got Your point. The project is all about being highly energy
efficient, flexible and provide massive parallelism (and we are not talking
about just 4 cores like in an Intel). Unfortunately size matters as well and
you'll guess it: it has to be cost efficient. Probably You know the word
"eierlegende Wollmilchsau" (dict.leo.org translates it with: "all-in-one
device suitable for every purpose" though the humor gets lost with that
translation), actually that's the goal.

Regards,

Lorenz
