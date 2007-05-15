From: "Michel Benoit" <murpme@gmail.com>
Subject: Re: soft vol
Date: Tue, 15 May 2007 09:35:57 +0200
Message-ID: <c88e466f0705150035j73b6b59fpd95fbfc19dc6619b@mail.gmail.com>
References: <c88e466f0705110336l5596cf8fwc434b0f071f5ee15@mail.gmail.com>
	<s5hejlnid9b.wl%tiwai@suse.de>
	<c88e466f0705140122q40509106uaa997b88a86e49c4@mail.gmail.com>
	<s5hps53hkkj.wl%tiwai@suse.de>
	<c88e466f0705141317m1a1c2de6n663fa5d7fe36ee62@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nz-out-0506.google.com (nz-out-0506.google.com [64.233.162.239])
	by alsa0.perex.cz (Postfix) with ESMTP id EBE79247FC
	for <alsa-devel@alsa-project.org>;
	Tue, 15 May 2007 09:35:58 +0200 (CEST)
Received: by nz-out-0506.google.com with SMTP id l8so39966nzf
	for <alsa-devel@alsa-project.org>; Tue, 15 May 2007 00:35:57 -0700 (PDT)
In-Reply-To: <c88e466f0705141317m1a1c2de6n663fa5d7fe36ee62@mail.gmail.com>
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
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

FYI, I rebuilt alsa-lib, alsa-utils and the kernel from scratch with
buildroot using OABI instead of EABI and softvol works fine now.
Thanks for your help.

It seems that my kernel was built using EABI but that my userspace was
being built with OABI.

Michel
