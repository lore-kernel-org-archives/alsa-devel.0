From: Haojian Zhuang <haojian.zhuang@gmail.com>
Subject: question on dapm_reg_event()
Date: Mon, 4 Jan 2010 21:10:27 -0500
Message-ID: <771cded01001041810n490145ednefccea066eaf271a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-px0-f173.google.com (mail-px0-f173.google.com
	[209.85.216.173])
	by alsa0.perex.cz (Postfix) with ESMTP id 1E1C81037F7
	for <alsa-devel@alsa-project.org>; Tue,  5 Jan 2010 03:10:28 +0100 (CET)
Received: by pxi3 with SMTP id 3so10495419pxi.16
	for <alsa-devel@alsa-project.org>; Mon, 04 Jan 2010 18:10:28 -0800 (PST)
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

Hi all,

I just have a question on dapm code. In dapm_reg_event(), -(w->reg +
1) is input parameter of snd_soc_update_bits(). Why we need to use
negative value as input parameter at here? Why do we not use w->reg at
here?

Thanks
Haojian
