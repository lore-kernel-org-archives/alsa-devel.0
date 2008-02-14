From: Rainer Zimmermann <mail@lightshed.de>
Subject: Re: Maya44 revised patch
Date: Thu, 14 Feb 2008 18:05:52 +0100
Message-ID: <47B474F0.6050203@lightshed.de>
References: <47B37EE7.5000905@lightshed.de>	<s5hpruzycbo.wl%tiwai@suse.de>	<47B4340C.1030106@insite.cz>
	<s5hir0ryauz.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from server9.dnshoster.de (server9.dnshoster.de [213.202.245.57])
	by alsa0.perex.cz (Postfix) with ESMTP id 011872461B
	for <alsa-devel@alsa-project.org>; Thu, 14 Feb 2008 18:05:28 +0100 (CET)
Received: from fcf6a.f.ppp-pool.de ([195.4.207.106] helo=[192.168.178.10])
	by server9.dnshoster.de with esmtpa (Exim 4.68)
	(envelope-from <mail@lightshed.de>) id 1JPhWY-0007fo-I3
	for alsa-devel@alsa-project.org; Thu, 14 Feb 2008 18:05:26 +0100
In-Reply-To: <s5hir0ryauz.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org



Hi Takashi and Pavel,


Takashi Iwai wrote:
>> The constraint comes from the codec, the chip itself can handle 192kHz, =

>> e.g. the 192kHz SPDIF input works fine. Actually more of the ice1724 car=
ds
>> have this limit. If this issue is solved in a general way, it could be
>> implemented to other cards with 192kHz DACs/96kHz ADCs too.
> =

> Thanks for a quick information.  Then, yes, we should fix this issue in
> general.  The separate lists of rates for playback and capture would be
> required in the end...
> =


ok. Actually, as Pavel mentioned SPDIF, I guess there should be a third set=
 of
rates for SPDIF, to be used when the appropriate channel is switched to SPD=
IF.


>>> Anyway, we can limit this in a scenario like below: - disallow the rate
>>> over 96kHz if the capture stream is being opened - if the rate is set
>>> above 96kHz, the capture stream cannot be opened, returns -EBUSY or so.
>>> =


Yes, I was thinking of something along those lines. But 2 possible issues:

- maybe a stupid question, but couldn't there be some "backdoor"? E.g., cou=
ld a
playback stream change its rate to above 96kHz while a capture stream is op=
en?

- In the latter case, I think it should read: "if a playback stream is runn=
ing
at above 96kHz, the capture stream cannot be opened". Otherwise, e.g. areco=
rd
couldn't open the device if another app left the rate at 192kHz.

Are there other examples (non-ice17xx) how this is handled?


>>> BTW, is it supposed to be still highly experimental?  If the driver wor=
ks
>>> more or less stably with your device (and on the recent kernel), it'd be
>>> also good to put this to the upstream, i.e. in alsa-kernel tree instead
>>> of alsa-driver tree.

Yes, so far the driver is stable on my system (2.6.22) and on Piotr's, but I
would still consider it experimental. It still contains experimental code a=
nd
some experimental controls, and I guess there should be more testing, in
particular the MI/ODI/O and SPDIF part is still untested.
Well, your decision...


As for the vu-meters:

> Since the meaning of these read-only controls is clear only upon detailed
> study of the driver and Envy24 datasheet plus I encounter a lot of
> questins/complaints about them, I suggest to change their type from MIXER=
 to
> PCM. They would still be readily accessible from amixer or API.

No objection from my part, but could it break any app software? any other c=
omments?


-Rainer


-- =

Lightshed IT Services
L=F6fflerstr. 27, 22765 Hamburg, Germany * mail@lightshed.de * www.lightshe=
d.de
