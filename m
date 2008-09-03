From: "Timur Tabi" <timur@freescale.com>
Subject: Re: snd-soc-cs4270: Convert to a new-style i2c driver
	(work in progress)
Date: Wed, 3 Sep 2008 16:27:58 -0500
Message-ID: <ed82fe3e0809031427i7ea0fd73s47d70699554e549@mail.gmail.com>
References: <20080831161843.227b31f3@hyperion.delvare>
	<ed82fe3e0808310928v18eed8bdh98faa6796a516142@mail.gmail.com>
	<20080831190928.2931b0ed@hyperion.delvare>
	<ed82fe3e0809031247t3085e409x3141f9712ad962a9@mail.gmail.com>
	<ed82fe3e0809031330s5036e9d0g1c2b3e73096f2a6@mail.gmail.com>
	<20080903224402.4d794c95@hyperion.delvare>
	<48BEFFF7.80903@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wr-out-0506.google.com (wr-out-0506.google.com [64.233.184.228])
	by alsa0.perex.cz (Postfix) with ESMTP id 2562F244E6
	for <alsa-devel@alsa-project.org>;
	Wed,  3 Sep 2008 23:27:59 +0200 (CEST)
Received: by wr-out-0506.google.com with SMTP id 36so2531312wra.24
	for <alsa-devel@alsa-project.org>; Wed, 03 Sep 2008 14:27:59 -0700 (PDT)
In-Reply-To: <48BEFFF7.80903@freescale.com>
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

On Wed, Sep 3, 2008 at 4:21 PM, Timur Tabi <timur@freescale.com> wrote:
> Can you give me specifics on how to use the unbind file?  I tried a few things,
> but none of them worked, and google isn't helpful either.

Never mind, I figured it out.  Sure enough, it works.  It probably
breaks ASoC, though.  I'm going to add support for it anyway, though.

-- 
Timur Tabi
Linux kernel developer at Freescale
