From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] of/device: Replace struct of_device with
	struct of_platform
Date: Thu, 19 Aug 2010 15:32:32 -0600
Message-ID: <AANLkTi=12oe7hquDJ4NN_S=cFdfndfxxkOmzqPziD2CE@mail.gmail.com>
References: <20100801074831.1099.3318.stgit@angua>
	<AANLkTiny_N-UqzuVaftLj75e_b0PjsdHstH8ZKx5mw7O@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-iw0-f179.google.com (mail-iw0-f179.google.com
	[209.85.214.179])
	by alsa0.perex.cz (Postfix) with ESMTP id A3E7C243FA
	for <alsa-devel@alsa-project.org>;
	Thu, 19 Aug 2010 23:32:53 +0200 (CEST)
Received: by iwn4 with SMTP id 4so390156iwn.38
	for <alsa-devel@alsa-project.org>; Thu, 19 Aug 2010 14:32:52 -0700 (PDT)
In-Reply-To: <AANLkTiny_N-UqzuVaftLj75e_b0PjsdHstH8ZKx5mw7O@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@freescale.com>
Cc: sfr@canb.auug.org.au, monstr@monstr.eu, alsa-devel mailing list <alsa-devel@alsa-project.org>, microblaze-uclinux@itee.uq.edu.au, devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, benh@kernel.crashing.org, sparclinux@vger.kernel.org, davem@davemloft.net
List-Id: alsa-devel@alsa-project.org

On Thu, Aug 19, 2010 at 2:36 PM, Timur Tabi <timur@freescale.com> wrote:
> On Sun, Aug 1, 2010 at 2:57 AM, Grant Likely <grant.likely@secretlab.ca> =
wrote:
>
>> =A0sound/soc/fsl/mpc8610_hpcd.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0=
 =A04 +-
>
> This file is/was significantly rewritten for 2.6.37. =A0I posted a fix
> to the alsa mailing list, but it will conflict with your patch. =A0You
> might want to remove all changes to sound/soc/fsl from this commit.

This change is already in Linus' tree.

g.
