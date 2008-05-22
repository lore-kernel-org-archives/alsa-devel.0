From: Arthur Marsh <arthur.marsh@internode.on.net>
Subject: Re: [Alsa-user] Pc Speaker
Date: Fri, 23 May 2008 09:24:08 +0930
Message-ID: <483607A0.3000504@internode.on.net>
References: <20080513110322.030a5386.zoup@zoup.org>	<48296CFF.5000207@keyaccess.nl>	<20080513151425.448369e8.zoup@zoup.org>	<4829781E.6040909@keyaccess.nl>
	<483560B3.70204@internode.on.net> <4835DBA0.90401@keyaccess.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.internode.on.net (bld-mail10.adl2.internode.on.net
	[203.16.214.74]) by alsa0.perex.cz (Postfix) with ESMTP id 8472324468
	for <alsa-devel@alsa-project.org>;
	Fri, 23 May 2008 01:54:43 +0200 (CEST)
In-Reply-To: <4835DBA0.90401@keyaccess.nl>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Rene Herman <rene.herman@keyaccess.nl>
Cc: alsa-user@lists.sourceforge.net, ALSA devel <alsa-devel@alsa-project.org>, Armin ranjbar <zoup@zoup.org>
List-Id: alsa-devel@alsa-project.org

Rene Herman wrote, on 2008-05-23 06:16:
> On 22-05-08 14:01, Arthur Marsh wrote:
> 
>> under Debian unstable, by overwriting the unpacked Debian source tarball.
> 
> I'm afraid you lost me here. I have little clue about Debian.
> 
> Rene.

When one installs the "alsa-source" package on Debian and unpacks the 
resulting /usr/src/alsa-driver.tar.bz2 file, it ends up in a directory 
under /usr/src/modules.

Normally one would also have the kernel source unpacked into 
/usr/src/linux, then run:

make-kpkg --initrd linux-image modules-image

to compile a kernel and whatever modules packages were installed (e.g. ALSA)

I unpacked the Mercurial snapshot, then did a cp -r of the snapshot to 
the directory underneath /usr/src/modules where the alsa drivers were 
unpacked so that I could still use the Debian build process to compile 
the Mercurial snapshot of ALSA.

Arthur.
