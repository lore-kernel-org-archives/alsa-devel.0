From: Jaroslav Kysela <perex@perex.cz>
Subject: Packages 1.0.30 - release pending
Date: Sun, 11 Oct 2015 21:08:01 +0200
Message-ID: <561AB391.6030504@perex.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 by alsa0.perex.cz (Postfix) with ESMTP id 9B6012606E3
 for <alsa-devel@alsa-project.org>; Sun, 11 Oct 2015 21:08:01 +0200 (CEST)
Received: from server.perex-int.cz (server.perex-srv.cz [172.16.0.20])
 by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id 7F3B8149F03
 for <alsa-devel@alsa-project.org>; Sun, 11 Oct 2015 21:08:01 +0200 (CEST)
Received: from t510.perex-int.cz (localhost [127.0.0.1])
 by server.perex-int.cz (Perex's E-mail Delivery System) with ESMTP id
 55E16853B0
 for <alsa-devel@alsa-project.org>; Sun, 11 Oct 2015 21:08:01 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi all,

	I would like to release 1.0.30 version of all packages. Things to discuss:

1) tinycompress
   - do the release this library, too ?
   - versioning - follow the rule for all other ALSA packages
     (all packages have same version) ?

2) user-space versioning - change the numbering scheme ?

	Basically, there aren't major rewrites of API last years and it won't
probably happen quickly. Some APIs might be redesigned - simplified
(mostly the mixer stuff), but I would propose to go from 1.0.x to 1.x
numbering (starting with 1.1) and when a major rewrite of API will be
included, we may change the first (major) version number. The release
frequency is not high, so it won't hurt anything in my eyes. Comments,
objections ? This discussion may end with 1.1 release instead 1.0.30.

				Thanks,
					Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
