From: Ricard Wanderlof <ricard.wanderlof@axis.com>
Subject: alsa-utils uses incorrect format for 24 bit audio?
Date: Tue, 5 Sep 2017 21:32:31 +0200
Message-ID: <alpine.DEB.2.11.1709052122100.24087@lnxricardw1.se.axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bes.se.axis.com (bes.se.axis.com [195.60.68.10])
 by alsa0.perex.cz (Postfix) with ESMTP id 0536826727D
 for <alsa-devel@alsa-project.org>; Tue,  5 Sep 2017 21:32:39 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by bes.se.axis.com (Postfix) with ESMTP id 738202E2F2
 for <alsa-devel@alsa-project.org>; Tue,  5 Sep 2017 21:32:38 +0200 (CEST)
Received: from bes.se.axis.com ([IPv6:::ffff:127.0.0.1])
 by localhost (bes.se.axis.com [::ffff:127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id sfhW1cKf3KSD for <alsa-devel@alsa-project.org>;
 Tue,  5 Sep 2017 21:32:37 +0200 (CEST)
Received: from boulder03.se.axis.com (boulder03.se.axis.com [10.0.8.17])
 by bes.se.axis.com (Postfix) with ESMTPS id 9A75B2E2EC
 for <alsa-devel@alsa-project.org>; Tue,  5 Sep 2017 21:32:37 +0200 (CEST)
Received: from boulder03.se.axis.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5A87C1E08A
 for <alsa-devel@alsa-project.org>; Tue,  5 Sep 2017 21:32:37 +0200 (CEST)
Received: from boulder03.se.axis.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4F78B1E089
 for <alsa-devel@alsa-project.org>; Tue,  5 Sep 2017 21:32:37 +0200 (CEST)
Received: from seth.se.axis.com (unknown [10.0.2.172])
 by boulder03.se.axis.com (Postfix) with ESMTP
 for <alsa-devel@alsa-project.org>; Tue,  5 Sep 2017 21:32:37 +0200 (CEST)
Received: from XBOX03.axis.com (xbox03.axis.com [10.0.5.17])
 by seth.se.axis.com (Postfix) with ESMTP id 43BB427BD
 for <alsa-devel@alsa-project.org>; Tue,  5 Sep 2017 21:32:37 +0200 (CEST)
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


When attempting to use arecord to capture audio from a 24 bit source, and =

create a 24-bit .wav file I ran into the problem that the resulting file =

does not seem valid. Looking closer at the contents, it appears that =

arecord writes the 32-bit S24_LE samples verbatim to the file, and sets =

the number of bits per sample specifier to 24 in the .wav header, at the =

same time as it sets the 'block align' to 4 which I suppose is logical, =

although normally the block align corresponds to the frame size (in bytes) =

for the sample size specified in the bits per sample specifier. =


A number of utilities and applications I tried refused to play the file =

back properly, including Audacity, VLC, sox and kwave, so I'm guessing the =

format written by arecord is not valid in this case. 24 bit audio as =

exported from Audacity for instance in reality corresponds to the ALSA =

S24_3LE format, i.e. the data is sent with no padding (resulting in a .wav =

'block align' specifier of 3 for a mono stream).

Is this a known problem with arecord/aplay, or is it the other =

applications which have been less than accurate when implementing .wav =

file standard?

/Ricard
-- =

Ricard Wolf Wanderl=F6f                           ricardw(at)axis.com
Axis Communications AB, Lund, Sweden            www.axis.com
Phone +46 46 272 2016                           Fax +46 46 13 61 30
