From: Dag Lem <dag@nimrod.no>
Subject: Re: [PATCH] Re: iec958 switch uneffective while
	playing ac3 stream
Date: 22 Apr 2007 13:01:30 +0200
Message-ID: <udabx0isfp.fsf@sid.nimrod.no>
References: <4548D24F.7080409@slagter.name> <s5hhcwj4u0s.wl%tiwai@suse.de>
	<loom.20070321T222449-537@post.gmane.org>
	<87648thdes.fsf@gandalf.hd.free.fr> <udejnhy14a.fsf@sid.nimrod.no>
	<ud8xdpxw1y.fsf@sid.nimrod.no> <874podj8rw.fsf@gandalf.hd.free.fr>
	<87zm65htl3.fsf@gandalf.hd.free.fr> <udvegss2jm.fsf@sid.nimrod.no>
	<87ircr7o8n.fsf@gandalf.hd.free.fr> <udbqijefbj.fsf@sid.nimrod.no>
	<87ps6z3wbn.fsf_-_@gandalf.hd.free.fr> <udmz21sosc.fsf@sid.nimrod.no>
	<87r6rbn7xp.fsf@gandalf.hd.free.fr> <udps6t7cz3.fsf@sid.nimrod.no>
	<87y7ler7ng.fsf@gandalf.hd.free.fr> <s5h7isvktie.wl%tiwai@suse.de>
	<kgitzvx6feb.fsf@komarr.grenoble.hp.com>
	<s5h4pnxinny.wl%tiwai@suse.de> <87k5wtjrev.fsf_-_@gandalf.hd.free.fr>
	<kgiwt0s4jpv.fsf@komarr.grenoble.hp.com>
	<udd52kqlhv.fsf@sid.nimrod.no> <s5hvegcdxun.wl%tiwai@suse.de>
	<udabxf9uvz.fsf@sid.nimrod.no> <s5htzvnz0jy.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nimrod.no (sid.nimrod.no [195.139.160.2])
	by alsa0.perex.cz (Postfix) with ESMTP id 5FFE5244BF
	for <alsa-devel@alsa-project.org>;
	Sun, 22 Apr 2007 13:01:36 +0200 (CEST)
In-Reply-To: <s5htzvnz0jy.wl%tiwai@suse.de>
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
Cc: Dominique Dumont <dominique.dumont@hp.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Takashi Iwai <tiwai@suse.de> writes:

[...]

> The fix is already in HG tree, so please test the latest HG version
> to confirm whether it's fixed.

I finally got around to test the code in the HG tree.

The S/PDIF output still works perfectly on the ALC882M. I ran PCM
tests using all available frame rates (44.1kHz, 48kHz, 96kHz, 192kHz).
I also tested AC3 (at 48kHz) and DTS (at 44.1kHz and 48kHz).

Good work! That goes for Dominique as well, of course :-)

The only fly in the ointment for the average user will be, I think,
that HDA-Intel.pcm.default is using dmix. This effectively cuts most
non-experts off from using anything but 48kHz, resulting in inferior
sound quality (and unavailability to play back 44.1KHz DTS over
S/PDIF) due to resampling.

Perhaps dmix could be configured with more than one destination frame
rate, so that resampling would only be used if absolutely necessary?
Just a thought.

-- 
Best regards,

Dag Lem
