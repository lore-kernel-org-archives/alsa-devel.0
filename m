From: Matthew Bucknall <matthew.bucknall@gmail.com>
Subject: Non-I2C/SPI ASoC codec
Date: Thu, 3 Jul 2014 12:14:07 +0100
Message-ID: <CAOr_jfL+fMBVi82RaLBAcnygNFhVXPoRoyFMGTp4HOEZecSyMA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ob0-f173.google.com (mail-ob0-f173.google.com
 [209.85.214.173])
 by alsa0.perex.cz (Postfix) with ESMTP id 546592654BC
 for <alsa-devel@alsa-project.org>; Thu,  3 Jul 2014 13:14:09 +0200 (CEST)
Received: by mail-ob0-f173.google.com with SMTP id va2so47055obc.32
 for <alsa-devel@alsa-project.org>; Thu, 03 Jul 2014 04:14:08 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

I'm trying to get audio support for a custom ARM board to work and have
written codec and machine drivers - The platform driver already existed
(atmel_ssc_dai). The codec I am supporting is extremely simple and has no
SPI/I2C interface for configuration and just accepts fixed format/fixed
rate I2S.

Previously, when I've gotten ASoC support for another board working, the
codec it used (TLV320AIC32) had an I2C interface. Declaring I2C_BOARD_INFO
for this in my board file seemed sufficient to get the machine driver to
probe and initialize. For this new board, I have no SPI/I2C device to
declare in the board file and its associated machine driver is not probing.
All I get from the kernel is 'No soundcards found.'

My driver modules are getting compiled and are linked statically. What do I
need to do to get the machine driver going?

Matt.
