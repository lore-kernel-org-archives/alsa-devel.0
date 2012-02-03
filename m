From: Viktar Palstsiuk <viktar.palstsiuk@promwad.com>
Subject: TDM bus support in Linux Kernel
Date: Fri, 3 Feb 2012 11:59:10 +0300
Message-ID: <CAKa7sPRgROFY2RfeVW0G_1EWzWXakuWu50tGQ2QuzrvEimU3FQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Cc: Michail Kurachkin <michail.kurachkin@promwad.com>, Ivan Kuten <ivan.kuten@promwad.com>
List-Id: alsa-devel@alsa-project.org

Hello,

We are designing custom hardware board where processor is connected
with analog telephony
SLIC via TDM bus.
During investigation of Linux kernel we did not find any corresponding TDM code.
So decided to write a new TDM subsystem in drivers/tdm (like SPI).
The subsystem consists of tdm_core.c which implements TDM bus routines,
e.g. tdm_register_board_info(), tdm_add_device(),
tdm_controller_register() etc, and
someplatform_tdm.c which implements platform specific TDM contoller.

Any suggestion if we have chosen right direction and our approach
conforms Linux kernel architecture?
May be there were already some preliminary work for this?

-- 
Best regards,
Viktar Palstsiuk
