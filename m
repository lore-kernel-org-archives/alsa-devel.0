From: Andreas Schwab <schwab@suse.de>
Subject: Re: [RFC 3/8] snd-aoa: add soundbus
Date: Fri, 02 Jun 2006 16:41:14 +0200
Message-ID: <jeu073aad1.fsf@sykes.suse.de>
References: <20060601115844.343214000@sipsolutions.net>
	<20060601115846.852128000@sipsolutions.net>
	<s5hu0734qay.wl%tiwai@suse.de>
	<1149257225.11092.22.camel@johannes.berg>
	<s5hslmn4p00.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from mx1.suse.de (mx1.suse.de [195.135.220.2])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 679BF156
	for <alsa-devel@alsa-project.org>;
	Fri,  2 Jun 2006 16:41:15 +0200 (MEST)
In-Reply-To: <s5hslmn4p00.wl%tiwai@suse.de> (Takashi Iwai's message of "Fri,
	02 Jun 2006 16:21:35 +0200")
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: linuxppc-dev@ozlabs.org, Johannes Berg <johannes@sipsolutions.net>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Takashi Iwai <tiwai@suse.de> writes:

> At Fri, 02 Jun 2006 16:07:05 +0200,
> Johannes Berg wrote:
>> =

>> On Fri, 2006-06-02 at 15:53 +0200, Takashi Iwai wrote:
>> > > +	if (strlen(sdev->modalias)) {
>> > > +		length =3D snprintf (buf, 34, "%s\n", sdev->modalias);
>> > =

>> > sizeof(sdev->modalias) + 2?  But still strange if modalias has no
>> > nul-end.
>> =

>> Hm, how would I handle that if modalias has no nul?
>
> Well, I'm not sure whether modalias is always nul-terminated.

If modalias is not nul-terminated then strlen will already fail.

> Otherwise (if not nul-terminated), I'd implement like:
>
> 	strlcpy(buf, sdev->modalias, sizeof(sdev->modalias) + 1);
> 	strcpy(buf, "\n");

strcat?

Andreas.

-- =

Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstra=DFe 5, 90409 N=FCrnberg, Germany
PGP key fingerprint =3D 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
