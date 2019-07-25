From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2 3/3] iomap: fix Invalid License ID
Date: Thu, 25 Jul 2019 10:41:00 +0200 (CEST)
Message-ID: <alpine.DEB.2.21.1907251040380.1791@nanos.tec.linutronix.de>
References: <20190725075833.3481-1-yamada.masahiro@socionext.com> <20190725075833.3481-3-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190725075833.3481-3-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: linux-kernel@vger.kernel.org, linux-spdx@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, 25 Jul 2019, Masahiro Yamada wrote:

> Detected by:
> 
>   $ ./scripts/spdxcheck.py
>   fs/iomap/Makefile: 1:27 Invalid License ID: GPL-2.0-or-newer
> 
> Fixes: 1c230208f53d ("iomap: start moving code to fs/iomap/")
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
