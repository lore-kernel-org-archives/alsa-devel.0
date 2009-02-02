From: Herton Ronaldo Krzesinski <herton@mandriva.com.br>
Subject: Re: [Fwd: HP DV4 1155 SE - No Sound through
	speakers...]
Date: Mon, 2 Feb 2009 17:48:32 -0200
Message-ID: <200902021748.33859.herton@mandriva.com.br>
References: <4983FE7A.1040201@wanadoo.fr>
	<200902021620.52104.herton@mandriva.com.br>
	<b71cdde20902021119v48c1c6cdo8a6983f8e165102a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from perninha.conectiva.com.br (perninha.conectiva.com.br
	[200.140.247.100])
	by alsa0.perex.cz (Postfix) with ESMTP id 5935B243BC
	for <alsa-devel@alsa-project.org>; Mon,  2 Feb 2009 20:48:21 +0100 (CET)
In-Reply-To: <b71cdde20902021119v48c1c6cdo8a6983f8e165102a@mail.gmail.com>
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
To: Tim Barnette <tim.barnette@gmail.com>
Cc: alsa-devel@alsa-project.org, Jean-Pierre =?iso-8859-15?q?Andr=E9?= <jean-pierre.andre@wanadoo.fr>
List-Id: alsa-devel@alsa-project.org

Em Segunda-feira 02 Fevereiro 2009, =E0s 17:19:13, Tim Barnette escreveu:
> Herton, I downloaded the patches. What do I do with them?  Will these
> address MSI PCI enable and config mentioned in your email?

You can try/apply them and build with 2.6.28.2 kernel. It'll not set =

enable_msi=3D1 by default as the subvendor/subdevice ids are not on the lis=
t =

(103c:30fb), just add them to sound/pci/hda/hda_intel.c at msi_list
(see sound-alsa-hda-add-msi-quirk-list.patch) and make sure CONFIG_PCI_MSI =
is =

enabled on kernel config, or just load snd-hda-intel with option enable_msi=
=3D1 =

(and in this case you don't need to apply msi patch). But test before witho=
ut =

enabling msi, it may be not needed.

>
> Thank You,
> Tim Barnette

--
[]'s
Herton
