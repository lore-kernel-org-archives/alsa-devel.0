From: Konstantin Kletschke <lists@ku-gbr.de>
Subject: Re: Re :  ice1724/Audiotrak Prodigy 7.1 HiFi
Date: Fri, 5 Jan 2007 11:13:13 +0100
Message-ID: <20070105101313.GA4503@anita.doom>
References: <20070102151108.GA10561@synertronixx3>
	<1167850413l.15450l.0l@zerox>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <1167850413l.15450l.0l@zerox>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Am 2007-01-03 22:53 +0400 schrieb Elie Morisse:

> This card is quite similar to the Hercules Fortissimo IV, take a look at this :
> https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1556

Indeed, this Fortissimo 4 looks almost identical. It looks so similair
that its driver could work with Audiotrak Prodigy 7.1 Hifi out of the
box :-)

Yesterday I started hacking applying the patch Julian provided in
http://thread.gmane.org/gmane.linux.alsa.devel/40350/focus=40350

The card gets detected and the module loads. In alsamixer one PCM mixer
appears which indeed makes playback volume louder or silent.

Yes, playback works. _BUT_ far too fast :-) Someone is misinterpreting
sampling rates so everythings sounds like Mickie Mouse :-)

How is the current status of
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1556#13327

I will test this approach since you point out your card works well with
it. Still I am trying to get used to alsa-driver infrastructure to get
to know what where to code :-)

Regards, Konsti


-- 
GPG KeyID EF62FCEF
Fingerprint: 13C9 B16B 9844 EC15 CC2E  A080 1E69 3FDA EF62 FCEF

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
