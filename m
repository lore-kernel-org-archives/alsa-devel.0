From: Robert Siemer <Robert.Siemer@gmx.de>
Subject: Re: How to send data trough rawmidi ?
Date: Sat, 06 Apr 2002 16:43:55 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020406164355T.siemer@panorama.hadiko.de>
References: <20020406155349.D522@pengouin.univ-valenciennes.fr>
Reply-To: Robert Siemer <siemer@panorama.hadiko.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Received: from mailgate.rz.uni-karlsruhe.de (exim@mailgate.rz.uni-karlsruhe.de [129.13.64.97])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id QAA25216
	for <alsa-devel@alsa-project.org>; Sat, 6 Apr 2002 16:44:00 +0200
Received: from panorama.hadiko.de (hadii309.hadiko.uni-karlsruhe.de [172.20.44.69])
	by nce2.hadiko.de (8.11.3/8.11.3) with SMTP id g36Ehvx04150
	for <alsa-devel@alsa-project.org>; Sat, 6 Apr 2002 16:43:57 +0200 (MET DST)
In-Reply-To: <20020406155349.D522@pengouin.univ-valenciennes.fr>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: charles.fleche@meletu.univ-valenciennes.fr
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Re!

From: Charles Fl=E8che <charles.fleche@meletu.univ-valenciennes.fr>

> So, this is my problem: I don't know how to send sysex through
> rawmidi!!

I'm not into midi, so I cant help you here. But I see with one eye on
your program that you don't check for errors at all.

> Another small question : how can I force a pause in a program? Is =

> there a function like [delay(10);] who make a pause of 10
> miliseconds in a execution ?

Look for nanosleep() in the info pages of the glibc documentation.
sleep() is also available, but can onle handle whole seconds.


Bye,
	Robert
