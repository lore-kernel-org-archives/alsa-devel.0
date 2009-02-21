From: Peter Stokes <linux@dadeos.co.uk>
Subject: [PATCH 0/2] Arcam AV Control Plugin Updates
Date: Sat, 21 Feb 2009 16:59:47 +0000
Message-ID: <200902211659.48009.linux@dadeos.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp3.freeserve.com (smtp3.wanadoo.co.uk [193.252.22.156])
	by alsa0.perex.cz (Postfix) with ESMTP id 9C53924583
	for <alsa-devel@alsa-project.org>; Sat, 21 Feb 2009 18:17:22 +0100 (CET)
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf3208.me.freeserve.com (SMTP Server) with ESMTP id C000A700008B
	for <alsa-devel@alsa-project.org>; Sat, 21 Feb 2009 18:17:21 +0100 (CET)
Received: from RedDwarf.dadeos.co.uk (unknown [91.109.223.150])
	by mwinf3208.me.freeserve.com (SMTP Server) with ESMTP id 837B17000087
	for <alsa-devel@alsa-project.org>; Sat, 21 Feb 2009 18:17:21 +0100 (CET)
Received: from tuscan.dadeos.co.uk (Tuscan.dadeos.co.uk [10.0.0.243])
	(authenticated bits=0)
	by RedDwarf.dadeos.co.uk (8.14.3/8.14.2) with ESMTP id n1LHHAJh026983
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <alsa-devel@alsa-project.org>; Sat, 21 Feb 2009 17:17:10 GMT
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
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

The following patches provide minor updates to the Arcam AV control plug-in.

 * [PATCH 1/2] Remove incorrect usage of the static SHM ID variable
 * [PATCH 2/2] Refactor control specifications to facilitate addition of "numid" optimisation

Takashi,

I attempted to follow the pattern of your recent commits regarding the "numid" optimisations for external control plug-ins. 
Hopefully I've provided the correct behavior. Something that am not sure about is whether I should be calling 
the "snd_ctl_elem_id_set_numid()" function from "ctl_arcam_av.c" "arcam_av_read_event()" either in addition or instead of 
the calls to the "snd_ctl_elem_id_set_name()" function?

Thanks

Peter
