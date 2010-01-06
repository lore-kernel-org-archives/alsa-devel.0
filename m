From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: question on dapm_reg_event()
Date: Wed, 6 Jan 2010 14:53:22 +0000
Message-ID: <20100106145321.GC5783@sirena.org.uk>
References: <771cded01001041810n490145ednefccea066eaf271a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id E8ABB10381A
	for <alsa-devel@alsa-project.org>; Wed,  6 Jan 2010 15:53:22 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <771cded01001041810n490145ednefccea066eaf271a@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Haojian Zhuang <haojian.zhuang@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, Jan 04, 2010 at 09:10:27PM -0500, Haojian Zhuang wrote:

> I just have a question on dapm code. In dapm_reg_event(), -(w->reg +
> 1) is input parameter of snd_soc_update_bits(). Why we need to use
> negative value as input parameter at here? Why do we not use w->reg at
> here?

Hrm, no, that's not at all clear to me either.  CCing Jarkko who
contributed the register write control originally.
