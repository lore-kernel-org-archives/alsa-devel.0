From: Ricard Wanderlof <ricard.wanderlof@axis.com>
Subject: SSM2518 Device Tree support ?
Date: Thu, 13 Aug 2015 14:12:34 +0200
Message-ID: <alpine.DEB.2.02.1508131400010.27635@lnxricardw1.se.axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bastet.se.axis.com (bastet.se.axis.com [195.60.68.11])
 by alsa0.perex.cz (Postfix) with ESMTP id 45DC5261A03
 for <alsa-devel@alsa-project.org>; Thu, 13 Aug 2015 14:12:39 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by bastet.se.axis.com (Postfix) with ESMTP id D5A7F1818A
 for <alsa-devel@alsa-project.org>; Thu, 13 Aug 2015 14:12:35 +0200 (CEST)
Received: from bastet.se.axis.com ([IPv6:::ffff:127.0.0.1])
 by localhost (bastet.se.axis.com [::ffff:127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id j9s6MjlONOD6 for <alsa-devel@alsa-project.org>;
 Thu, 13 Aug 2015 14:12:35 +0200 (CEST)
Received: from boulder.se.axis.com (boulder.se.axis.com [10.0.2.104])
 by bastet.se.axis.com (Postfix) with ESMTP id 2664318166
 for <alsa-devel@alsa-project.org>; Thu, 13 Aug 2015 14:12:35 +0200 (CEST)
Received: from boulder.se.axis.com (localhost [127.0.0.1])
 by postfix.imss71 (Postfix) with ESMTP id 0F24B1400
 for <alsa-devel@alsa-project.org>; Thu, 13 Aug 2015 14:12:35 +0200 (CEST)
Received: from seth.se.axis.com (seth.se.axis.com [10.0.2.172])
 by boulder.se.axis.com (Postfix) with ESMTP id 03630F9D
 for <alsa-devel@alsa-project.org>; Thu, 13 Aug 2015 14:12:35 +0200 (CEST)
Received: from xmail2.se.axis.com (xmail2.se.axis.com [10.0.5.74])
 by seth.se.axis.com (Postfix) with ESMTP id 008B73E049
 for <alsa-devel@alsa-project.org>; Thu, 13 Aug 2015 14:12:35 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


We needed DT support in the SSM2518 codec driver, and I noticed that there =

is already a set of bindings specified in Documentation/devicetree, =

however, there doesn't seem to be any DT support in the driver itself. I =

don't know if this is the result of a missing commit ? =


Documentation/devicetree/bindings/sound/ssm2518.c seems to have been added =

in May 2013.

I've added rudimentary support for at least the compatible property so =

that the driver can be used in a system with DT configuration (sent as a =

separate email).

/Ricard
-- =

Ricard Wolf Wanderl=F6f                           ricardw(at)axis.com
Axis Communications AB, Lund, Sweden            www.axis.com
Phone +46 46 272 2016                           Fax +46 46 13 61 30
