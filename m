From: Nitin PAI <nitinmpai@gmail.com>
Subject: ASOC - Codecs : Renaming of spdif_tranceiver.c
Date: Wed, 7 Mar 2012 17:48:33 +0530
Message-ID: <CAJDSjBjmDLvMgyw1y=QkMPu7rJBRZzSZje+P7-hdBugxpj3YxQ@mail.gmail.com>
References: <CAJDSjBikNPj_EExz_XojUOT0c4ip8MG3kEf+dzbcW1s_73SbeA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yw0-f51.google.com (mail-yw0-f51.google.com
	[209.85.213.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 26ACA1045E2
	for <alsa-devel@alsa-project.org>; Wed,  7 Mar 2012 13:18:35 +0100 (CET)
Received: by yhnn12 with SMTP id n12so2903193yhn.38
	for <alsa-devel@alsa-project.org>; Wed, 07 Mar 2012 04:18:34 -0800 (PST)
In-Reply-To: <CAJDSjBikNPj_EExz_XojUOT0c4ip8MG3kEf+dzbcW1s_73SbeA@mail.gmail.com>
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
Cc: lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

CCing the maintainers to get attention.

---------- Forwarded message ----------
From: Nitin PAI <nitinmpai@gmail.com>
Date: Wed, Mar 7, 2012 at 12:15 PM
Subject: ASOC - Codecs : Renaming of spdif_tranceiver.c
To: alsa-devel@alsa-project.org
Cc: swarren@nvidia.com


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



-- =

=93Karmanya vadhikaraste ma phaleshu kadachana Ma karma-phala-hetur bhu ma =
te
sango stav karmani=94           -  Krishna
