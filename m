From: David Binderman <dcb314@hotmail.com>
Subject: sound/pci/au88x0/au88x0_core.c: many calls to memset
 with not-plausible size ?
Date: Mon, 2 May 2016 14:43:15 +0000
Message-ID: <DUB128-W77ABB1A6DDDC9A0AAA26119C790@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from DUB004-OMC1S2.hotmail.com (dub004-omc1s2.hotmail.com
 [157.55.0.201]) by alsa0.perex.cz (Postfix) with ESMTP id A0379260421
 for <alsa-devel@alsa-project.org>; Mon,  2 May 2016 16:43:16 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "perex@perex.cz" <perex@perex.cz>, "tiwai@suse.com" <tiwai@suse.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hello there,

sound/pci/au88x0/au88x0_core.c:2153:6: warning: =91memset=92 used with leng=
th equal to number of elements without multiplication by element size [-Wme=
mset-elt-size]

Source code is

=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 memset(stream->resou=
rces, 0,
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 sizeof(unsigned char) *
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 VORTEX_RESOURCE_LAST);

but

sound/pci/au88x0/au88x0.h:=A0=A0=A0 u32 resources[5];

Something like

=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 memset(stream->resources, =
0,
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 sizeof(stream->resources[0]) *
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 VORTEX_RESOURCE_LAST);

Some duplicates:

sound/pci/au88x0/au88x0_core.c:2163:7: warning: =91memset=92 used with leng=
th equal to number of elements without multiplication by element size [-Wme=
mset-elt-size]
sound/pci/au88x0/au88x0_core.c:2177:5: warning: =91memset=92 used with leng=
th equal to number of elements without multiplication by element size [-Wme=
mset-elt-size]
sound/pci/au88x0/au88x0_core.c:2292:5: warning: =91memset=92 used with leng=
th equal to number of elements without multiplication by element size [-Wme=
mset-elt-size]
sound/pci/au88x0/au88x0_core.c:2301:5: warning: =91memset=92 used with leng=
th equal to number of elements without multiplication by element size [-Wme=
mset-elt-size]

Regards

David Binderman

 		 	   		  =
