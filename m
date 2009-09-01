From: Daniel Chen <seven.steps@gmail.com>
Subject: Re: [alsa-announce] ALSA 1.0.21 release
Date: Tue, 1 Sep 2009 12:32:44 -0400
Message-ID: <604760770909010932n68edcc3avbe94fabe649d7c9d@mail.gmail.com>
References: <4A9D4A56.8060603@davidfavor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f207.google.com (mail-fx0-f207.google.com
	[209.85.220.207])
	by alsa0.perex.cz (Postfix) with ESMTP id CDF1C243F3
	for <alsa-devel@alsa-project.org>;
	Tue,  1 Sep 2009 18:32:44 +0200 (CEST)
Received: by fxm3 with SMTP id 3so163784fxm.32
	for <alsa-devel@alsa-project.org>; Tue, 01 Sep 2009 09:32:44 -0700 (PDT)
In-Reply-To: <4A9D4A56.8060603@davidfavor.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: David Favor <david@davidfavor.com>
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Tue, Sep 1, 2009 at 12:22 PM, David Favor<david@davidfavor.com> wrote:
> Specifically I'm using Ubuntu Karmic (Kernel is 2.6.31-9) and I'm
> interested in testing all the X-Fi card driver fixes which are listed
> in the ALSA 1.0.21 release notes.

Download, extract, and compile alsa-driver-1.0.21.tar.bz2. Installing
it will remove the existing version. You'll need to use sudo
/sbin/alsa force-reload afterward, or reboot.

Karmic already carries significant fixes from alsa-lib-1.0.21.tar.bz2,
so you're okay on that front.

-Dan
