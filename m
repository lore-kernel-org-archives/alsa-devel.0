From: Halim Sahin <halim.sahin@freenet.de>
Subject: more infos: Re: hda-intel: low volume with nvidia
	mcp7a hdmi
Date: Fri, 25 Sep 2009 06:33:27 +0000 (UTC)
Message-ID: <20090925063327.GA23001@halim>
References: <20090924190111.GA7812@halim>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lo.gmane.org (lo.gmane.org [80.91.229.12])
	by alsa0.perex.cz (Postfix) with ESMTP id 934731038C5
	for <alsa-devel@alsa-project.org>;
	Fri, 25 Sep 2009 08:34:07 +0200 (CEST)
Received: from list by lo.gmane.org with local (Exim 4.50) id 1Mr4NW-0006Rl-Pe
	for alsa-devel@alsa-project.org; Fri, 25 Sep 2009 08:34:02 +0200
Received: from pd9e3da29.dip.t-dialin.net ([217.227.218.41])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Fri, 25 Sep 2009 08:34:02 +0200
Received: from halim.sahin by pd9e3da29.dip.t-dialin.net with local (Gmexim
	0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Fri, 25 Sep 2009 08:34:02 +0200
Content-Disposition: inline
In-Reply-To: <20090924190111.GA7812@halim>
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

Hi,
head -n 1 /proc/asound/card0/codec* gives:

==> /proc/asound/card0/codec#0 <==
Codec: Realtek ALC662 rev1

==> /proc/asound/card0/codec#3 <==
Codec: Nvidia MCP7A HDMI

maybe this helps to understand the problem?

Regards
Halim

-- 
Halim Sahin
E-Mail:				
halim.sahin (at) t-online.de
