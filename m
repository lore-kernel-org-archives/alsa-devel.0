From: Daniel Chen <seven.steps@gmail.com>
Subject: Re: [PATCH] Ensure codec patch files are checked for
	the correct codec ID
Date: Wed, 2 Jun 2010 13:30:26 -0400
Message-ID: <AANLkTimXyy6ymauuzFiEKGiDdmQ-7y0liCT1dTIpf6eQ@mail.gmail.com>
References: <4C06729B.6050201@epost.diwic.se>
	<AANLkTinCaQtPG81MkTA2zE0AnYn7fdKN-Q6VsYX9sUBB@mail.gmail.com>
	<4C06896F.7040202@epost.diwic.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pv0-f179.google.com (mail-pv0-f179.google.com
	[74.125.83.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 154FA1037EE
	for <alsa-devel@alsa-project.org>;
	Wed,  2 Jun 2010 19:30:28 +0200 (CEST)
Received: by pva4 with SMTP id 4so459271pva.38
	for <alsa-devel@alsa-project.org>; Wed, 02 Jun 2010 10:30:27 -0700 (PDT)
In-Reply-To: <4C06896F.7040202@epost.diwic.se>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: David Henningsson <launchpad.web@epost.diwic.se>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, Jun 2, 2010 at 12:40 PM, David Henningsson
<launchpad.web@epost.diwic.se> wrote:
> In the individual case, maybe. However, assuming codec vendor and
> subsystem are correctly matched, a distro could make a long list of
> Codec SSID to model mappings, write down that in the patch file format,
> and supply that patch file. One could then add mappings as a minor
> distro update without having to recompile the kernel.

Excellent point, although the idea of maintaining a massive "firmware"
file is somewhat scary.

Best,
-Dan
