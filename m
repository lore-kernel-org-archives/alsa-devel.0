From: Orm Finnendahl <o.finnendahl@mh-freiburg.de>
Subject: Re: hda-intel missing mixer channels
Date: Mon, 14 Sep 2009 15:06:29 +0200
Message-ID: <20090914130629.GD23203@varese>
References: <20090912120413.GA28342@varese> <s5h63bllnjz.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.mh-freiburg.de (mail.mh-freiburg.de [193.197.131.2])
	by alsa0.perex.cz (Postfix) with ESMTP id AF4D924438
	for <alsa-devel@alsa-project.org>;
	Mon, 14 Sep 2009 18:50:37 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mail.mh-freiburg.de (Postfix) with ESMTP id 2190AF11C9
	for <alsa-devel@alsa-project.org>;
	Mon, 14 Sep 2009 18:50:37 +0200 (CEST)
Received: from inm.mh-freiburg.de (unknown [192.168.242.2])
	by mail.mh-freiburg.de (Postfix) with ESMTP id F2AE21A0001
	for <alsa-devel@alsa-project.org>;
	Mon, 14 Sep 2009 18:50:36 +0200 (CEST)
Received: from orm by grisey with local (masqmail 0.2.21) id
	1MnBGH-8P2-00 for <alsa-devel@alsa-project.org>; Mon, 14 Sep 2009
	15:06:29 +0200
Content-Disposition: inline
In-Reply-To: <s5h63bllnjz.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

 I got that solved with the (unrelated) mail today from Andrius
=A6tikonas, where he is mentioning the model parameter in
snd-hda-intel. Putting

options snd-hda-intel model=3Dbasic

into /etc/modprobe.d/alsa-base and restarting made all faders
reappear. Works like a charm now. Thanks for replying!

--
Orm

Related: sound, alsa, Lenovo Ideapad S10, mic input

Am Monday, den 14. September 2009 um 14:26:40 Uhr (+0200) schrieb Takashi I=
wai:
> What faders?
> =

> Anyway, try to use the latest version of alsa-driver.  Your version
> is pretty old, and no merit to debug.
