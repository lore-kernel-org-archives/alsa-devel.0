From: Nitin PAI <nitinmpai@gmail.com>
Subject: ASOC - Codecs : Renaming of spdif_tranceiver.c
Date: Wed, 7 Mar 2012 12:15:07 +0530
Message-ID: <CAJDSjBikNPj_EExz_XojUOT0c4ip8MG3kEf+dzbcW1s_73SbeA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-iy0-f179.google.com (mail-iy0-f179.google.com
	[209.85.210.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 72269103D2C
	for <alsa-devel@alsa-project.org>; Wed,  7 Mar 2012 07:45:08 +0100 (CET)
Received: by iakh37 with SMTP id h37so8743813iak.38
	for <alsa-devel@alsa-project.org>; Tue, 06 Mar 2012 22:45:07 -0800 (PST)
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
Cc: swarren@nvidia.com
List-Id: alsa-devel@alsa-project.org

Hi,

In my project I am feeling of need to have generic_codec.  This will
provide the required codec_dais for the usecases like

-HDMI/SPDIF where there is no codec involved.
-For audio over MOST, where CPLD/glue logic is used
-For complex audio DSPs connected which will be mostly programmed in the
user-space.
-SOC manufactures who would like to ship their drivers without having to
know what will be the final codec that will be present in the system.

Currently there is spdif_tranceiver.c which serves the purpose for spdif,
but using this for other usecases will create confusion while shipping the
code.

What is the best way to carry forward?

1) Use spdif_tranceiver.c for all the purpose.
disadvantage:  this will create more confusion while shipping.

2)Deprecate spdif_transciever.c and call it generic_codec. Change the dai
names and the function names.

3)Create another generic_codec.c and keep the spdif_transceiver.c and
deprecate the latter in next version.

4) Any other ideas ?

Thanks,
Nitin
