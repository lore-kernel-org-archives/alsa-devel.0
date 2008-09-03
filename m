From: "Timur Tabi" <timur@freescale.com>
Subject: Re: snd-soc-cs4270: Convert to a new-style i2c driver
	(work in progress)
Date: Wed, 3 Sep 2008 14:47:27 -0500
Message-ID: <ed82fe3e0809031247t3085e409x3141f9712ad962a9@mail.gmail.com>
References: <20080831161843.227b31f3@hyperion.delvare>
	<ed82fe3e0808310928v18eed8bdh98faa6796a516142@mail.gmail.com>
	<20080831190928.2931b0ed@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wr-out-0506.google.com (wr-out-0506.google.com [64.233.184.235])
	by alsa0.perex.cz (Postfix) with ESMTP id 08BFD244E0
	for <alsa-devel@alsa-project.org>;
	Wed,  3 Sep 2008 21:47:28 +0200 (CEST)
Received: by wr-out-0506.google.com with SMTP id 36so2489807wra.24
	for <alsa-devel@alsa-project.org>; Wed, 03 Sep 2008 12:47:27 -0700 (PDT)
In-Reply-To: <20080831190928.2931b0ed@hyperion.delvare>
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
To: Jean Delvare <khali@linux-fr.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sun, Aug 31, 2008 at 12:09 PM, Jean Delvare <khali@linux-fr.org> wrote:

> * Your driver now lacks a remove method. Unless I miss something, if
> the snd-soc-cs4270 driver is unloaded, you will leave dangling
> resources behind (codec->reg_cache in particular.)

I'm working on a fix for this, but there's something you need to know.
 I don't think ASoC V1 modules can be unloaded.  The drivers have
hard-coded cross-dependencies.  The codec driver doesn't have this
problem, but in general it's not really possible to select ASoC
drivers as modules in Kconfig anyway.  The "tristate" I mentioned is
misleading.

-- 
Timur Tabi
Linux kernel developer at Freescale
