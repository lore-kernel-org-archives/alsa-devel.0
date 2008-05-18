From: "Lee Revell" <rlrevell@joe-job.com>
Subject: Re: [patch] snd-pcsp: depend on CONFIG_EXPERIMENTAL
Date: Sun, 18 May 2008 01:57:05 -0400
Message-ID: <75b66ecd0805172257o765c94eeud0e2c94139f37753@mail.gmail.com>
References: <482E0734.7080003@aknet.ru>
	<20080517090517.GB3284@cs181133002.pp.htv.fi>
	<482EB747.6040103@aknet.ru> <482F015D.8030504@keyaccess.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rv-out-0708.google.com (rv-out-0708.google.com [209.85.198.243])
	by alsa0.perex.cz (Postfix) with ESMTP id 02DF824B6B
	for <alsa-devel@alsa-project.org>;
	Sun, 18 May 2008 07:57:06 +0200 (CEST)
Received: by rv-out-0708.google.com with SMTP id f25so686737rvb.32
	for <alsa-devel@alsa-project.org>; Sat, 17 May 2008 22:57:05 -0700 (PDT)
In-Reply-To: <482F015D.8030504@keyaccess.nl>
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
To: Rene Herman <rene.herman@keyaccess.nl>
Cc: Takashi Iwai <tiwai@suse.de>, Adrian Bunk <bunk@kernel.org>, Stas Sergeev <stsp@aknet.ru>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sat, May 17, 2008 at 12:01 PM, Rene Herman <rene.herman@keyaccess.nl> wrote:
> it might actually make some sense to reserve a
> #define SND_INDEX_PCSP MAXINT or some such so that this thing gets a
> stable index (and make sure people know to select it through its name
> like in "default:pcsp" and the like).

Or hardcode index 0, so the distros will have to fix any apps that
address cards by number, use the /dev/dsp API, or assume that output
to card 0 is a sane default...

Lee
