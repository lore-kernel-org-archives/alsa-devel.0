From: Daniel Chen <seven.steps@gmail.com>
Subject: Re: [PATCH] Ensure codec patch files are checked for
	the correct codec ID
Date: Wed, 2 Jun 2010 12:03:07 -0400
Message-ID: <AANLkTinCaQtPG81MkTA2zE0AnYn7fdKN-Q6VsYX9sUBB@mail.gmail.com>
References: <4C06729B.6050201@epost.diwic.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pv0-f179.google.com (mail-pv0-f179.google.com
	[74.125.83.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 10ABB10380B
	for <alsa-devel@alsa-project.org>;
	Wed,  2 Jun 2010 18:03:08 +0200 (CEST)
Received: by pva4 with SMTP id 4so406967pva.38
	for <alsa-devel@alsa-project.org>; Wed, 02 Jun 2010 09:03:08 -0700 (PDT)
In-Reply-To: <4C06729B.6050201@epost.diwic.se>
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

On Wed, Jun 2, 2010 at 11:02 AM, David Henningsson
<launchpad.web@epost.diwic.se> wrote:
> This one just popped out when I read the source code - or is there a
> reason for parsing vendorid and subid without caring about the result?

Technically it matters little if the codec vendor_id and subsystem_id
have valid values, because you can override them anyway. Codec address
is the vital one.

Best,
-Dan
