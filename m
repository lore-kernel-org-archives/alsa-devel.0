From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: smart and automatic use of dmix and dsnoop - feature suggestion.
Date: Tue, 18 Nov 2003 02:30:57 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200311180730.hAI7Uvfx016560@oud.linuxaudiosystems.com>
References: <200311180655.02528.pwk.linuxfan@gmx.de>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Tue, 18 Nov 2003 06:51:43 +0100."
             <200311180655.02528.pwk.linuxfan@gmx.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Peter Kirk <pwk.linuxfan@gmx.de>
Cc: James Courtier-Dutton <James@superbug.demon.co.uk>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>> 5) I think that this sound mixing problem might be better served by
>> sound servers like jack.
>
>Hmmm,
>
>actualy I did have a very close look at jack, but the problem that I saw=20
>(correct me if Im wrong here), is the fact that jack only works well if the=
>=20
>applications are specificaly geard to work with it. To quote the FAQ:

this isn't an issue any more, in that ALSA supports output via JACK
itself. apps don't behave the way real JACK clients would, but the
sound is heard. i don't know if capture support works.

jack is not intended to be a general purpose solution though. although
i believe that its callback API is a better choice, things like
PortAudio offer that with or without JACK. jack's main offering is low
latency, sample synchronous execution. i guess if it really worked for
everybody, it would be great. chances are that it might be slightly
closer to working than dmix, but i don't really know (especially the
capture part). making connections is also difficult - it puts quite a
burden on the user.

--p


-------------------------------------------------------
This SF. Net email is sponsored by: GoToMyPC
GoToMyPC is the fast, easy and secure way to access your computer from
any Web browser or wireless device. Click here to Try it Free!
https://www.gotomypc.com/tr/OSDN/AW/Q4_2003/t/g22lp?Target=mm/g22lp.tmpl
