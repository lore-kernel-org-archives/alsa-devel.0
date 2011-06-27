From: Adrian Pardini <pardo.bsso@gmail.com>
Subject: Re: compile problems
Date: Mon, 27 Jun 2011 10:35:32 -0300
Message-ID: <BANLkTi=mDwbo59wT5tAhmV0K60f6+TT2BQ@mail.gmail.com>
References: <4E088113.6040500@digital-pipe.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
	[209.85.212.51]) by alsa0.perex.cz (Postfix) with ESMTP id 2181D2417D
	for <alsa-devel@alsa-project.org>;
	Mon, 27 Jun 2011 15:35:52 +0200 (CEST)
Received: by vws20 with SMTP id 20so3748850vws.38
	for <alsa-devel@alsa-project.org>; Mon, 27 Jun 2011 06:35:35 -0700 (PDT)
In-Reply-To: <4E088113.6040500@digital-pipe.com>
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

On 27/06/2011, David Henderson <dhenderson@digital-pipe.com> wrote:
[...]
> checking for libasound headers version>= 1.0.16... not present.
> configure: error: Sufficiently new version of libasound not
> found.
>
>
> Seeing as how this is a staging directory and not
> the actual place the package is being installed to, I'm having the afore
> mentioned problem because the alsa-utils package is looking under /...
> for the header files instead of the /opt/staging/alsa/... directory.  Is
> there a compile-time parameter that I can use so that alsa-utils looks
> in the staging directory for the header files - just during the compile
> phase?

Hi Dave, try giving --with-alsa-inc-prefix=/opt/staging/alsa to the
configure script.


-- 
Adrian.
http://ovejafm.com
http://elesquinazotango.com.ar
http://www.elarteylatecnologia.com.ar
