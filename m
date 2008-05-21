From: Eliot Blennerhassett <linux@audioscience.com>
Subject: Re: HG -> GIT migration
Date: Wed, 21 May 2008 14:30:06 +1200
Message-ID: <200805211430.06653.linux@audioscience.com>
References: <Pine.LNX.4.61.0805201314190.1798@tm8103-a.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp4.clear.net.nz (smtp4.clear.net.nz [203.97.37.64])
	by alsa0.perex.cz (Postfix) with ESMTP id 6C0CB2441C
	for <alsa-devel@alsa-project.org>;
	Wed, 21 May 2008 04:29:57 +0200 (CEST)
Received: from zaphod.local
	(121-72-250-62.cable.telstraclear.net [121.72.250.62])
	by smtp4.clear.net.nz (CLEAR Net Mail)
	with ESMTP id <0K170086M5KR2V10@smtp4.clear.net.nz> for
	alsa-devel@alsa-project.org; Wed, 21 May 2008 14:29:16 +1200 (NZST)
In-reply-to: <Pine.LNX.4.61.0805201314190.1798@tm8103-a.perex-int.cz>
Content-disposition: inline
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

On Tuesday 20 May 2008 23:21:13 Jaroslav Kysela wrote:
> Hi all,
>
> 	I finished migration from HG to GIT. All repositories are
> converted and we have one "new" repository - alsa-kernel.git which is full
> Linux 2.6 GIT tree. The old HG alsa-kernel repository was renamed to
> alsa-kmirror 

Hi Jaroslav,

can you clarify what one should do to be able to build latest GIT head.

Should I expect the following to work? (as it used to work with Hg)

$ git clone git://git.alsa-project.org/alsa-kmirror.git alsa-kmirror  
$ git clone git://git.alsa-project.org/alsa-driver.git alsa-driver  
$ cd alsa-driver
$ ALSAKERNELDIR=../alsa-kmirror/ ./gitcompile --with-debug=full   

anyway I get this error

  CC [M]  /home/eliot/src/alsagit/alsa-driver/i2c/other/pt2258.o
make[4]: *** No rule to make target 
`/home/eliot/src/alsagit/alsa-driver/i2c/other/tea575x-tuner.o', needed by 
`/home/eliot/src/alsagit/alsa-driver/i2c/other/snd-ak4117.o'.  Stop.

regards

Eliot
