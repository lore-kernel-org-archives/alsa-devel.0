From: Will Wagner <will_wagner@carallon.com>
Subject: alsa-utils compile issues
Date: Wed, 28 Jan 2009 13:43:44 +0000
Message-ID: <49806110.6010502@carallon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from carallon.f9.co.uk (carallon.force9.co.uk [80.229.37.120])
	by alsa0.perex.cz (Postfix) with ESMTP id A252B10383C
	for <alsa-devel@alsa-project.org>; Wed, 28 Jan 2009 14:44:08 +0100 (CET)
Received: from [127.0.0.1] by carallon.f9.co.uk (MDaemon PRO v9.6.5)
	with ESMTP id md50000339307.msg
	for <alsa-devel@alsa-project.org>; Wed, 28 Jan 2009 13:43:38 +0000
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

Hi All,

I have configured alsa-lib 1.0.19 to remove the components I do not want for my embedded
arm target. I do this with the configure options:

	--disable-docs \
	--disable-aload \
	--disable-rawmidi \
	--disable-hwdep \
	--disable-seq \
	--disable-alisp \
	--disable-old-symbols \
	--disable-python \
  	--with-alsa-devdir=/dev \
	--with-pcm-plugins="copy linear adpcm rate plug dmix softvol" \
	--with-ctl-plugins="" \
	--with-versioned="no" \

This builds a much reduced in size alsa-lib

However when I then try to build alsa-utils this fails because amidi and seq will not
compile with the reduced alsa-lib

It seems to be there should be configure options in alsa-utils to disable more of its
components than just alsamixer and alsatest.

I have worked around this by just removing amidi and seq from the SUBDIRS variable in
Makefile.in but perhaps there is a better way of doing this?

Thanks,

Will


-- 
------------------------------------------------------------------------
Will Wagner                                     will_wagner@carallon.com
Development Manager                      Office Tel: +44 (0)20 7371 2032
Carallon Ltd, Studio G20, Shepherds Building, Rockley Rd, London W14 0DA
------------------------------------------------------------------------
