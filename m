From: Adrian Pardini <pardo.bsso@gmail.com>
Subject: Re: compile problems
Date: Mon, 27 Jun 2011 11:27:42 -0300
Message-ID: <BANLkTim-W1S7Gv1EKDSga8ScxhiVaicy=Q@mail.gmail.com>
References: <4E088113.6040500@digital-pipe.com>
	<BANLkTi=mDwbo59wT5tAhmV0K60f6+TT2BQ@mail.gmail.com>
	<4E088C15.3030608@digital-pipe.com>
	<BANLkTikPDJ3UQgoaPniBEei3pkVQT=b0hw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vx0-f179.google.com (mail-vx0-f179.google.com
	[209.85.220.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 1D8B4243A9
	for <alsa-devel@alsa-project.org>;
	Mon, 27 Jun 2011 16:27:42 +0200 (CEST)
Received: by vxb40 with SMTP id 40so3768800vxb.38
	for <alsa-devel@alsa-project.org>; Mon, 27 Jun 2011 07:27:42 -0700 (PDT)
In-Reply-To: <BANLkTikPDJ3UQgoaPniBEei3pkVQT=b0hw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: David Henderson <dhenderson@digital-pipe.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 27/06/2011, Adrian Pardini <pardo.bsso@gmail.com> wrote:
[...]
> Also you may have to set the
> LDFLAGS environment variable to point to where your libraries are
> being installed under /opt


--with-alsa-prefix looks more suitable. Maybe
--with-alsa-prefix=opt/staging/alsa/var/ is all you need.

-- 
Adrian.
http://ovejafm.com
http://elesquinazotango.com.ar
http://www.elarteylatecnologia.com.ar
