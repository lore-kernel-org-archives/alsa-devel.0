From: Matthias Saou <matthias@rpmforge.net>
Subject: Re: Release method?
Date: Wed, 23 Oct 2002 18:57:54 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20021023185754.574fcbb8.matthias@rpmforge.net>
References: <20021023170553.3511839f.matthias@rpmforge.net>
	<s5helah18iq.wl@alsa2.suse.de>
	<20021023175446.7acdf7eb.matthias@rpmforge.net>
	<s5hadl515hj.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hadl515hj.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Once upon a time, Takashi wrote :

> no, as you can see in the 0.5.x series, the sub-version number will be
> (hopefully) increased at each release once after 0.9.0 is out.
> again, the current sitatuion is excpetional.
> 
> my understanding of rc-version is exactly what you suggested -- it's
> nothing but the test-release tarball before the official tarball.
> (please don't take the example of 0.9.0rcX here.  i mean, ideally.)
> 
> so, in this matter, 1.0-rcX _should_ come later on, but they must not
> survive long like 0.9.0rcX, and they are not for normal (end-)users.
> the people who don't understand what the suffix means should use the
> version only with numbers.

I get your point. So we both seem to agree that the current situation is
rather annoying, but it wasn't supposed to be :-)
I really don't mind the "rcX" or "preX" versions, but these should never be
widely released, advertised nor packaged, and a good example would be the
Linux kernel itself, where version numbers are clear, although "hidden" to
the end users there are all those pre-patches underlying ;-)

I guess we just should hope that from now on branching and releases will be
done at the right time to always provide users with a recent recommended
version, comprehensively numbered with no "rc", "beta" or whatever tag in
it.

Cheers,
Matthias

-- 
Clean custom Red Hat Linux rpm packages : http://freshrpms.net/
Red Hat Linux release 7.3 (Valhalla) running Linux kernel 2.4.18-10acpi
Load : 0.16 0.16 0.17


-------------------------------------------------------
This sf.net email is sponsored by: Influence the future 
of Java(TM) technology. Join the Java Community 
Process(SM) (JCP(SM)) program now. 
http://ads.sourceforge.net/cgi-bin/redirect.pl?sunm0002en
