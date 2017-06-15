From: Ricard Wanderlof <ricard.wanderlof@axis.com>
Subject: Multiplexable codecs?
Date: Thu, 15 Jun 2017 17:46:40 +0200
Message-ID: <alpine.DEB.2.11.1706151738250.2393@lnxricardw1>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bes.se.axis.com (bes.se.axis.com [195.60.68.10])
 by alsa0.perex.cz (Postfix) with ESMTP id B03CD266819
 for <alsa-devel@alsa-project.org>; Thu, 15 Jun 2017 17:46:48 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by bes.se.axis.com (Postfix) with ESMTP id 6260F2E5E0
 for <alsa-devel@alsa-project.org>; Thu, 15 Jun 2017 17:46:46 +0200 (CEST)
Received: from bes.se.axis.com ([IPv6:::ffff:127.0.0.1])
 by localhost (bes.se.axis.com [::ffff:127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id gaQzkiDnXznr for <alsa-devel@alsa-project.org>;
 Thu, 15 Jun 2017 17:46:45 +0200 (CEST)
Received: from boulder03.se.axis.com (boulder03.se.axis.com [10.0.8.17])
 by bes.se.axis.com (Postfix) with ESMTPS id C6FAB2E5D3
 for <alsa-devel@alsa-project.org>; Thu, 15 Jun 2017 17:46:45 +0200 (CEST)
Received: from boulder03.se.axis.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B46FC1E076
 for <alsa-devel@alsa-project.org>; Thu, 15 Jun 2017 17:46:45 +0200 (CEST)
Received: from boulder03.se.axis.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A96961E060
 for <alsa-devel@alsa-project.org>; Thu, 15 Jun 2017 17:46:45 +0200 (CEST)
Received: from seth.se.axis.com (unknown [10.0.2.172])
 by boulder03.se.axis.com (Postfix) with ESMTP
 for <alsa-devel@alsa-project.org>; Thu, 15 Jun 2017 17:46:45 +0200 (CEST)
Received: from XBOX03.axis.com (xbox03.axis.com [10.0.5.17])
 by seth.se.axis.com (Postfix) with ESMTP id 9DAFBBB
 for <alsa-devel@alsa-project.org>; Thu, 15 Jun 2017 17:46:45 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


I have a usecase where there is a requirement to have two codecs which are =

multiplexed on the same I2S channel. (In fact one of the 'codecs' is =

actually a digital microphone, but it generates an I2S stream just the =

same).

In the ALSA SoC framework I know there is support for having separate =

codecs on the right and left channels, and also for having different =

codecs for playback and capture. But is there any way in the framework =

that two codecs can be toggled between at runtime? Normally a machine =

driver would configure a single codec which essentially is statically =

allocated. Of course the whole driver could be removed and another one =

loaded, but the thing here is that it is only for capture that the codecs =

are multiplexed, for playback it's always the same codec, and I don't want =

to disrupt playback just because a change is required on the capture side.

/Ricard
-- =

Ricard Wolf Wanderl=F6f                           ricardw(at)axis.com
Axis Communications AB, Lund, Sweden            www.axis.com
Phone +46 46 272 2016                           Fax +46 46 13 61 30
