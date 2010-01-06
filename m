From: Daniel Chen <seven.steps@gmail.com>
Subject: Re: Sound still not working after 1.0.22.1 update
Date: Wed, 6 Jan 2010 09:27:23 -0500
Message-ID: <604760771001060627w5fc87d01qc6a80d51ff978c63@mail.gmail.com>
References: <SNT124-DS137905233B6014ED26C0F9FE720@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-px0-f173.google.com (mail-px0-f173.google.com
	[209.85.216.173])
	by alsa0.perex.cz (Postfix) with ESMTP id 894E7103826
	for <alsa-devel@alsa-project.org>; Wed,  6 Jan 2010 15:27:24 +0100 (CET)
Received: by pxi3 with SMTP id 3so11961594pxi.16
	for <alsa-devel@alsa-project.org>; Wed, 06 Jan 2010 06:27:23 -0800 (PST)
In-Reply-To: <SNT124-DS137905233B6014ED26C0F9FE720@phx.gbl>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Grandja <oracle_sod@hotmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, Jan 6, 2010 at 7:14 AM, Daniel Grandja <oracle_sod@hotmail.com> wrote:
> I have managed to Download / Compile / Install the upgrade, but still no

>From your alsa-info output, you didn't actually install the newer
1.0.22.1 in a preferred path. See modinfo snd-hda-intel|grep ^file
