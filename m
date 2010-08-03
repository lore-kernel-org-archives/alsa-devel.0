From: Pavel Hofman <pavel.hofman@ivitera.com>
Subject: Rates/formats available upstream from the plug plugin
Date: Tue, 03 Aug 2010 15:13:10 +0200
Message-ID: <4C5815E6.9010803@ivitera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cable.insite.cz (upc-plzen.insite.cz [84.242.100.8])
	by alsa0.perex.cz (Postfix) with ESMTP id 1E2BD24466
	for <alsa-devel@alsa-project.org>;
	Tue,  3 Aug 2010 15:13:14 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by cable.insite.cz (Postfix) with ESMTP id 992B6A3D8131D
	for <alsa-devel@alsa-project.org>;
	Tue,  3 Aug 2010 15:13:11 +0200 (CEST)
Received: from cable.insite.cz ([127.0.0.1])
	by localhost (server.insite.cz [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nPK9f64tAQoy for <alsa-devel@alsa-project.org>;
	Tue,  3 Aug 2010 15:13:11 +0200 (CEST)
Received: from [192.168.1.20] (sara.insite.cz [192.168.1.20])
	by cable.insite.cz (Postfix) with ESMTP id 74B39A3D8131C
	for <alsa-devel@alsa-project.org>;
	Tue,  3 Aug 2010 15:13:11 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi,

mplayer checks hw_params for availability of the current format
http://mplayer-ww.git.sourceforge.net/git/gitweb.cgi?p=mplayer-ww/mplayer-ww;a=blob;f=libao2/ao_alsa.c;h=57f0bd07cb5ec300d327682a0b5209ba9dc10e30;hb=09ab9f6346aaf15d20792ca3df761a45fe46d83d#l514
. If the check fails, it uses 16bits as fixed default.

Now if we define the card to be plughw:0, the check still fails for
formats unsupported directly by the card. Which in fact is incorrect
since the plug plugin takes care of most formats known. The same holds
for sample rates.

IMO either the plug plugin should reconfigure hw_params for upstream
use, or mplayer should use a different API call for checking parameters
of the actual alsa device (not just the hardware itself, as defined by
its alsa driver) - which one?

Thanks a lot,

Pavel.
