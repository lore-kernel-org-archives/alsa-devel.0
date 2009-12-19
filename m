From: Belisko Marek <marek.belisko@gmail.com>
Subject: No device for DAI omap-eac-dai error
Date: Sat, 19 Dec 2009 17:51:59 +0100
Message-ID: <e7c6a05e0912190851q273555beg2f1ed415a8c9399f@mail.gmail.com>
References: <e7c6a05e0912180618h771b9b7fl9d197d500bc534c1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-iw0-f172.google.com (mail-iw0-f172.google.com
	[209.85.223.172])
	by alsa0.perex.cz (Postfix) with ESMTP id C46F62414D
	for <alsa-devel@alsa-project.org>; Sat, 19 Dec 2009 17:52:00 +0100 (CET)
Received: by iwn2 with SMTP id 2so32335iwn.16
	for <alsa-devel@alsa-project.org>; Sat, 19 Dec 2009 08:52:00 -0800 (PST)
In-Reply-To: <e7c6a05e0912180618h771b9b7fl9d197d500bc534c1@mail.gmail.com>
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
List-Id: alsa-devel@alsa-project.org

Hi,

I'm writing new omap dai (for EAC codec base omap's).
My code is based on existing omap-mcbsp.c code basically.

After loadingof module I got error which appear in init function when
call snd_soc_register_dai().

I browse for code but can't figure out where dai->dev should be set to
don't get error message and init dai properly.

Thanks for any suggestions

Marek
