From: Carlo Wood <carlo@alinoe.com>
Subject: two bugs in alsa-utils tar related to buildrpm
Date: Mon, 29 Apr 2002 15:56:47 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020429155647.A18071@alinoe.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.alinoe.com (node1500a.a2000.nl [24.132.80.10])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with SMTP id PAA18448
	for <alsa-devel@alsa-project.org>; Mon, 29 Apr 2002 15:57:01 +0200
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The alsa-utils-0.9.0rc1.tar.bz2 on the ftp sites
is missing acconfig.h (needed for 'make dist').

'make dist' is needed by buildrpm.

./configure
make
make install

works thus for the tar,

but

./configure
cd utils
./buildrpm

doesn't work for the released tar.

I could generate acconfig.h myself by running
cvscompile, but:

The newer automake (I use 1.5) uses $(AMTAR)
and not $(TAR), breaking 'make dist'.

-- 
Carlo Wood <carlo@alinoe.com>

_______________________________________________________________

Have big pipes? SourceForge.net is looking for download mirrors. We supply
the hardware. You get the recognition. Email Us: bandwidth@sourceforge.net
