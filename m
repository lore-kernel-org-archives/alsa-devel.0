From: Matthias Saou <matthias@rpmforge.net>
Subject: Re: Forward: Re: questions for alsa-devel
Date: Wed, 2 Oct 2002 19:25:41 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20021002192541.6e92b6a2.matthias@rpmforge.net>
References: <m27kh1djdd.fsf@vador.mandrakesoft.com>
	<20021002145420.6F590146FB@Cantor.suse.de>
	<s5hd6qskhmn.wl@alsa2.suse.de>
	<s5hbs6ckgm0.wl@alsa2.suse.de>
	<20021002174359.1d2395d3.matthias@rpmforge.net>
	<m2zntwn4gx.fsf@vador.mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <m2zntwn4gx.fsf@vador.mandrakesoft.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Once upon a time, Thierry wrote :

> since it must be rebuild for each kernel, we integrated in our kernel
> package (first as a separate tarball with configure/make/..., now we
> untar it under sound in kernel linux sources and apply a few patches
> to config.in so that there's one make to run)

Thanks for those precisions :-)
So I guess that in some ways, having nothing whatsoever related to ALSA in
Red Hat Linux does make things easier. The main concern is to then have
ALSA support in the applications, but most of my packages provide that with
their "--with alsa" rpmrebuild option.

All this will get so much easier once stable kernels used by Linux
distributions come with ALSA by default ;-)

Matthias

-- 
Clean custom Red Hat Linux rpm packages : http://freshrpms.net/
Red Hat Linux release 7.3 (Valhalla) running Linux kernel 2.4.18-10acpi
Load : 0.10 0.23 0.29


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
