From: =?big5?B?IlRpZW4sICBDLkwuIC0gpdCp08KnIg==?= <cltien@cmedia.com.tw>
Subject: RE: [patch] patch_cm9880.c to support multi-channel
Date: Sun, 27 Mar 2005 23:19:02 +0800
Message-ID: <92C0412E07F63549B2A2F2345D3DB515F7D6D2@cm-msg-02.cmedia.com.tw>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="big5"
Content-Transfer-Encoding: quoted-printable
Received: from cm-msg-02.cmedia.com.tw (61-30-17-228.static.tfn.net.tw [61.30.17.228])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 2A4DC21E
	for <alsa-devel@alsa-project.org>; Sun, 27 Mar 2005 18:37:54 +0200 (MEST)
Content-Class: urn:content-classes:message
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

I got configuration info from Windows driver's .INI file, there are =
totally 28 configuration so I think it is impractical to use parameter =
to fits user's needs.

I want to add configuration for 6-stack first since most of the M/Bs =
have them.

Then I plan to add code to probe the jacks for multi-channel playback, =
so driver can find which pin for front/rear/side/LFE by itself without =
parameter help. The line-out/line-in/mic etc. should also can be =
detected without a fixed table.

Sincerely,
ChenLi Tien


-----Original Message-----
From:	Takashi Iwai [mailto:tiwai@suse.de]
Sent:	2005/3/24 [=ACP=B4=C1=A5|] =A4U=A4=C8 03:40
To:	Tien,  C.L. - =A5=D0=A9=D3=C2=A7
Cc:	alsa-devel@alsa-project.org
Subject:	Re: [Alsa-devel] [patch] patch_cm9880.c to support =
multi-channel
At Fri, 25 Mar 2005 01:53:06 +0800,
Tien, C.L. wrote:
>=20
> I also added controls in the allout_init array. I wonder what this
> model for because it is the same as basic_init except the line-in is
> used as output in allout_init.=20

It was coded so, just based on the example configuration described in=20
the datasheet of CMI9880, in case any hardware is implemented in that
way.  Surely we can clean up these models.

> I plan to add controls for 5/6 stacks ,  which lacks front panel but
> has rear 5/6 jacks. Any idea?=20

Go ahead, let's discuss together with the code :)


Takashi





-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
