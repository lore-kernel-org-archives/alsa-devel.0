From: Thierry Vignaud <tvignaud@mandriva.com>
Subject: Re: compilation faillure
Date: Fri, 31 Aug 2007 15:32:06 +0200
Message-ID: <m2veavhlt5.fsf@vador.mandriva.com>
References: <Pine.LNX.4.61.0708311112510.10136@tm8103.perex-int.cz>
	<m2lkbrj3gd.fsf@vador.mandriva.com>
	<Pine.LNX.4.61.0708311452050.7587@tm8103.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from office.mandriva.com (office-abk.mandriva.com [84.55.162.90])
	by alsa0.perex.cz (Postfix) with ESMTP id 733BE1039A0
	for <alsa-devel@alsa-project.org>;
	Fri, 31 Aug 2007 15:32:07 +0200 (CEST)
In-Reply-To: <Pine.LNX.4.61.0708311452050.7587@tm8103.perex-int.cz> (Jaroslav
	Kysela's message of "Fri\, 31 Aug 2007 15\:24\:43 +0200 \(CEST\)")
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@suse.cz>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Jaroslav Kysela <perex@suse.cz> writes:

> Oops, configure script does not detected location of python C header files. 
> Fixed in HG.
> 
> You may disable building of python code with --disable-python and wait for 
> 1.0.15rc2.

--disable-python has no effect
--disable-python &  --enable-python breaks at the exact same point...
