From: Abramo Bagnara <abramo.bagnara@tin.it>
Subject: Re: DMIX and capture stream
Date: Wed, 07 Jan 2004 13:45:05 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3FFBFF51.1030002@tin.it>
References: <Pine.LNX.4.58.0401051113381.8705@tomservo.workpc.tds.net>	<200401051741.i05HfCXl007120@dhin.linuxaudiosystems.com>	<s5h1xqe2rjp.wl@alsa2.suse.de>	<Pine.LNX.4.58.0401061105040.8705@tomservo.workpc.tds.net>	<20040106223828.39d2c233.mista.tapas@gmx.net> <s5hvfno10r5.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hvfno10r5.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Florian Schmidt <mista.tapas@gmx.net>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:

> as written in my previous mail, it was a quick hack.  and there is a
> better approach.

I'd prefer the following approach:

pcmp.duplex {
	type dmix
	...
}

pcmc.duplex {
	type dsnoop
	...
}

with the following policy:
- if capture is specified pcmc and pcm are searched in this order
- if playback is specified pcmp and pcm are searched in this order

This would solve also the annoying problem of pcm that are valid only 
for one direction and should not be used (or browsed) for the other.


-- 
Abramo Bagnara                       mailto:abramo.bagnara@tin.it

Opera Unica                          Phone: +39.0546.656023
Via Emilia Interna, 140
48014 Castel Bolognese (RA) - Italy



-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
