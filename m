From: Matthias Saou <matthias@rpmforge.net>
Subject: Re: alsa-utils-0.9.0rc4
Date: Wed, 23 Oct 2002 16:50:03 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20021023165003.7fa43afe.matthias@rpmforge.net>
References: <3DB6A244.9040604@t-online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <3DB6A244.9040604@t-online.de>
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

Once upon a time, Wolfgang wrote :

> I have a problem compiling alsa-utils-0.9.0rc4:
> 
> RedHat 8.0
> 
> ./configure
> 
> creating cache ./config.cache
> configure: error: can not find install-sh or install.sh in . ./.. ./../..
> 
> Any hint?

I see the same problem. In the tarball, there are links where scripts
should have been copied. To fix in rc5 too?

install-sh -> /usr/share/automake/install-sh
missing -> /usr/share/automake/missing
mkinstalldirs -> /usr/share/automake/mkinstalldirs

So compilation will work _only_ if you have automake installed.

Matthias

-- 
Clean custom Red Hat Linux rpm packages : http://freshrpms.net/
Red Hat Linux release 7.3 (Valhalla) running Linux kernel 2.4.18-10acpi
Load : 1.32 0.46 0.19


-------------------------------------------------------
This sf.net email is sponsored by: Influence the future 
of Java(TM) technology. Join the Java Community 
Process(SM) (JCP(SM)) program now. 
http://ads.sourceforge.net/cgi-bin/redirect.pl?sunm0002en
