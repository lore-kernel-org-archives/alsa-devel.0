From: Friedrich Ewaldt <friedrich.ewaldt@gmx.de>
Subject: Re: errors in symlinks in alsa-oss rc1 with mandrake
 9.0
Date: Tue, 17 Dec 2002 11:18:41 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3DFEFA01.10600@gmx.de>
References: <3DFCBF9A.2090108@iriXx.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <3DFCBF9A.2090108@iriXx.org>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: m@iriXx.org
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Hi!

Exactly the same problem for me.
./configure fails for alsa-oss-0.9.0rc1 (extracted from 
alsa-oss-0.9.0rc1.tar.bz2) because /usr/share/automake doesn't exist. 
(There's only a /usr/share/automake-1.4 directory in my mandrake 9.0 
installation).

here's part of 'ls -l alsa-oss-0.9.0rc1' output after extracting from 
the tarball:
[...]
lrwxrwxrwx    1 root     root           30 Dez 17 11:02 install-sh -> 
/usr/share/automake/install-sh
lrwxrwxrwx    1 root     root           27 Dez 17 11:02 missing -> 
/usr/share/automake/missing
lrwxrwxrwx    1 root     root           33 Dez 17 11:02 mkinstalldirs -> 
/usr/share/automake/mkins
These 3 links are pointing to a path that doesn't exist.

Building from cvs using './cvscompile' works fine.

btw: What do I need this alsa-oss package for? I didn't miss any 
functionality up to now without it, i.e I can cat wav files to /dev/dsp, ...


iriXx wrote:

> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> hi all
> just a note to say i had to modify the symlinks to 'missing',
> 'mkinstalldirs' and 'install-sh' to get alsa-oss-0.9.0rc1 to install
> under mandrake 9.0.
>
> it seems that from 9.0 mandrake puts automake in /usr/share/automake-1.4
> rather than /usr/share/automake. i dont know if anyone wants to add a
> detection for this to the config script?
>
> bw
> m~
> - --
> iriXx
>




-------------------------------------------------------
This sf.net email is sponsored by:
With Great Power, Comes Great Responsibility 
Learn to use your power at OSDN's High Performance Computing Channel
http://hpc.devchannel.org/
