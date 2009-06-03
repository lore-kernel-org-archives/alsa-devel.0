From: Andrea Borgia <andrea@borgia.bo.it>
Subject: Re: [PATCH - quirk for USB Aureon cards 1/1] Add quirk
 to provide proper naming of the Terratec Aureon 5.1 MkII USB card
Date: Wed, 03 Jun 2009 21:57:21 +0200
Message-ID: <4A26D5A1.9010907@borgia.bo.it>
References: <4A22F13F.6090707@borgia.bo.it>
	<s5hprdofhj7.wl%tiwai@suse.de>	<4A2571D1.9070001@borgia.bo.it>
	<s5hprdlyh5q.wl%tiwai@suse.de>	<4A267D3A.6000808@borgia.bo.it>
	<s5hr5y1qpk1.wl%tiwai@suse.de>	<4A269DE6.7080107@borgia.bo.it>
	<s5hoct5qo8f.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from galactica.digitalpha.it
	(host200-236-149-62.serverdedicati.aruba.it [62.149.236.200])
	by alsa0.perex.cz (Postfix) with ESMTP id 6387F244A6
	for <alsa-devel@alsa-project.org>;
	Wed,  3 Jun 2009 21:57:24 +0200 (CEST)
In-Reply-To: <s5hoct5qo8f.wl%tiwai@suse.de>
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

Takashi Iwai ha scritto:


> Well, it's just an id string.  The only requirement is to be unique on
> the running system.

Although highly unlikely in this specific case, how about multiple
identical cards on the same host? Does it still hold true?


> If this name is unacceptable (e.g. it's the name of my ex, it's a
> patent infringement, or whatever reason), concatenate Aureon 5.1 and
> MkII to a single word, then you'll get a different one.
> Or, you could implement more codes to give a better id string with
> the API function recently added...

Where should I look for this super snazzy function? I'm curious, I
already know how to add a quirk, let's learn something new :-)


Andrea.
