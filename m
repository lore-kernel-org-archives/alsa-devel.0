From: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Subject: Re: Has hdspmixer been dropped from alsa-tools?
Date: Thu, 12 May 2011 09:40:48 +0200
Message-ID: <20110512074048.GP24348@ltw.loris.tv>
References: <BANLkTi=1hPEDb3foK=zmF4en+DOQuxV1dw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ltw.loris.tv (ltw.loris.tv [85.14.220.160])
	by alsa0.perex.cz (Postfix) with ESMTP id 0BC1D24341
	for <alsa-devel@alsa-project.org>;
	Thu, 12 May 2011 09:41:03 +0200 (CEST)
Received: from localhost (ltw.loris.tv [127.0.0.1])
	by ltw.loris.tv (Postfix) with ESMTP id 2BCE9500054
	for <alsa-devel@alsa-project.org>;
	Thu, 12 May 2011 09:41:02 +0200 (CEST)
Received: from ltw.loris.tv ([127.0.0.1])
	by localhost (ltw.loris.tv [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id kuipekSmOGHb for <alsa-devel@alsa-project.org>;
	Thu, 12 May 2011 09:40:48 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <BANLkTi=1hPEDb3foK=zmF4en+DOQuxV1dw@mail.gmail.com>
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

On Thu, May 12, 2011 at 05:57:21AM +0200, Lars Zobbe wrote:

> Hi.

Hi!

> Just upgraded to ubuntu 11.04 and went through the usual process with
> getting HDSP 9632 to work.
> Everything seems to be fine, modules loaded and stuff. But I can't find the
> hdspmixer.

Since when do we provide end-user support on a development mailinglist?

Go and file a bug report against alsa-tools-gui to include hdspmixer.



> Normally it's included in the alsa-tools and alsa-tools-gui packages. And
> actually the mixer GUI does get an entry in the menu. But there is no
> command for it to execute. It is supposed to run hdspmixer - but it's not
> there.

   http://packages.ubuntu.com/natty/amd64/alsa-tools-gui/filelist

It's no longer there. OTOH, Debian has it, so it's clearly an Ubuntu
bug:

   http://packages.debian.org/sid/amd64/alsa-tools-gui/filelist


Here, only

   http://git.alsa-project.org/?p=alsa-tools.git;a=summary

matters. ;)



HTH

-- 
mail: adi@thur.de  	http://adi.thur.de	PGP/GPG: key via keyserver
