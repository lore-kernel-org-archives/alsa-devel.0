From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: ALSA AUDIOj support for PXA320
Date: Thu, 30 Sep 2010 17:50:23 +0100
Message-ID: <20100930165023.GC9431@sirena.org.uk>
References: <AANLkTinW0wQoeP3gm5bCZBJ27pJd5ubZ3S5Kq_Kaf6Cd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id CE9821037FF
	for <alsa-devel@alsa-project.org>;
	Thu, 30 Sep 2010 18:50:23 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <AANLkTinW0wQoeP3gm5bCZBJ27pJd5ubZ3S5Kq_Kaf6Cd@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Sayiram K N <sayiram.kothuri@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Sep 30, 2010 at 02:34:12PM +0530, Sayiram K N wrote:

>  I am using PXA320 where it has ALSA . but  for Linux 2.6.29 there is no
> support for PXA320. can i get a patch to support PXA320 .
> thanks in advance

The 2.6.29 kernel is extremely old.  Support for PXA3xx SSP and AC'97
controllers has been present in the kernel for quite some time (indeed,
the AC'97 part appears to have already been present in 2.6.29).
