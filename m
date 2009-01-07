From: "Cliff Cai" <cliffcai.sh@gmail.com>
Subject: alsa-lib-1.0.18 doesn't build with option
	'--with-softfloat'
Date: Wed, 7 Jan 2009 17:02:40 +0800
Message-ID: <da1989290901070102k41904cf1pbcb10b228a692ec@mail.gmail.com>
References: <da1989290901060152t2ce35849i1da6872552a07754@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from po-out-1718.google.com (po-out-1718.google.com [72.14.252.152])
	by alsa0.perex.cz (Postfix) with ESMTP id 568CE1037EB
	for <Alsa-devel@alsa-project.org>; Wed,  7 Jan 2009 10:02:42 +0100 (CET)
Received: by po-out-1718.google.com with SMTP id y22so6598944pof.2
	for <Alsa-devel@alsa-project.org>; Wed, 07 Jan 2009 01:02:41 -0800 (PST)
In-Reply-To: <da1989290901060152t2ce35849i1da6872552a07754@mail.gmail.com>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi all,

I'm trying to build the latest release alsa-lib-1.0.18 on Blackfin
with option  '--with-softfloat',
but it failed with message:

libtool: install: warning: remember to run `libtool --finish
/usr/lib/alsa-lib/smixer'
../src/.libs/libasound.so: undefined reference to `_sqrtf'
../src/.libs/libasound.so: undefined reference to `_exp'
../src/.libs/libasound.so: undefined reference to `_log'
../src/.libs/libasound.so: undefined reference to `_sqrt'
../src/.libs/libasound.so: undefined reference to `_fmod'
../src/.libs/libasound.so: undefined reference to `_floor'

Since I've selected --with-softfloat, '-lm' should be excluded from
ALSA_DEPLIBS.
but some source files still depend on libm, such as
.../pcm/pcm_ladspa.c;.../mixer/ simple_none.c
.../alisp/alisp.c.These there files cause undefined reference as above.


Best Regards

Cliff
