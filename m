From: Christian Schumann <schumann@physik.uni-kl.de>
Subject: Re: hdsp driver broken for Multiface II Rev 35
Date: Tue, 15 Jan 2008 22:28:53 +0100
Message-ID: <20080115212853.GA13172@diller-5.physik.uni-kl.de>
References: <20080114022142.51d6ae44@pluto.noname>
	<s5hbq7ollj9.wl%tiwai@suse.de>
	<20080115204215.2dfb6544@pluto.noname>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailgw1.uni-kl.de (mailgw1.uni-kl.de [131.246.120.220])
	by alsa0.perex.cz (Postfix) with ESMTP id A643E24403
	for <alsa-devel@alsa-project.org>; Tue, 15 Jan 2008 22:28:56 +0100 (CET)
Received: from cartman.physik.uni-kl.de (cartman.physik.uni-kl.de
	[131.246.236.200])
	by mailgw1.uni-kl.de (8.13.8/8.13.8/Debian-3) with ESMTP id
	m0FLSsM0002593
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <alsa-devel@alsa-project.org>; Tue, 15 Jan 2008 22:28:55 +0100
Received: from diller-5.physik.uni-kl.de (diller-5.physik.uni-kl.de
	[131.246.236.224])
	by cartman.physik.uni-kl.de (8.13.8/8.13.8/Debian-3) with ESMTP id
	m0FLJbfl009396
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <alsa-devel@alsa-project.org>; Tue, 15 Jan 2008 22:19:38 +0100
Received: from diller-5.physik.uni-kl.de (localhost.localdomain [127.0.0.1])
	by diller-5.physik.uni-kl.de (8.13.8/8.13.8/Debian-3) with ESMTP id
	m0FLSrSC013189
	for <alsa-devel@alsa-project.org>; Tue, 15 Jan 2008 22:28:53 +0100
Received: (from schumann@localhost)
	by diller-5.physik.uni-kl.de (8.13.8/8.13.8/Submit) id m0FLSrMc013187
	for alsa-devel@alsa-project.org; Tue, 15 Jan 2008 22:28:53 +0100
Content-Disposition: inline
In-Reply-To: <20080115204215.2dfb6544@pluto.noname>
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

Hi Andreas,

On Tue, Jan 15, 2008 at 08:42:15PM +0100, Andreas Degert wrote:
> ok, here it is:
> 
> hdsp: make Multiface II work again
> 
> This device has io_type == 1 (Multiface) and firmware_rev > 0xa
> (fixes regression from changeset 5326)
> 
> Signed-off-by: Andreas Degert <ad@papyrus-gmbh.de>
> 
[..]

I was one of the Digiface users with problems with the new driver
revisions. Although I don't know to which tree to apply your patch, I
edited alsa-drver-1.0.15 by hand, and so far after a quick test I can
confirm that it's working with my Digiface. Thank you very much.

Best regards
Christian



-- 
------------------------------------------------------------------------
Dipl.-Phys. Christian Schumann   |Technische Universitaet Kaiserslautern
Mail: schumann@physik.uni-kl.de  |           Fachbereich Physik
Tel.: 0631/205-4842 (Office)     |     http://www.physik.uni-kl.de 
Tel.: 0631/205-4843 (Lab)        |
Fax.: 0631/205-3902              |    
Post: Erwin-Schroedinger-Strasse, D-67663 Kaiserslautern
-------------------------------------------------------------------------
