From: Tobin Davis <tdavis@dsl-only.net>
Subject: Re: Splitting up the HDA-INTEL modules
Date: Tue, 15 Jan 2008 13:23:52 -0800
Message-ID: <1200432232.27806.120.camel@razman.gruemaster.com>
References: <478CFD32.50405@harddisk.is-a-geek.org>
	<5f52f6d70801151120y76407dd4s4c876643ddc8ba95@mail.gmail.com>
	<76366b180801151206v74232379ufd318580feba8fb9@mail.gmail.com>
	<478D12D1.8030808@harddisk.is-a-geek.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from iron2.pdx.net (iron2.pdx.net [69.64.224.71])
	by alsa0.perex.cz (Postfix) with ESMTP id E1D05243CB
	for <alsa-devel@alsa-project.org>; Tue, 15 Jan 2008 22:24:24 +0100 (CET)
In-Reply-To: <478D12D1.8030808@harddisk.is-a-geek.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Marco Schuster <marco@harddisk.is-a-geek.org>
Cc: alsa-devel@alsa-project.org, Andrew Paprocki <andrew@ishiboo.com>
List-Id: alsa-devel@alsa-project.org

Actually, if this were done correctly, it would use the /sys file system
for configuration changes.  /proc should be read only space.

As it sits now, you should be able to change the model configuration by
typing "echo <model> /sys/module/snd_hda_intel/parameters/model", but I
don't think it's setup to dynamic changing yet.
The /proc/asound/card0/codec# file contains all of the connection
configurations for each codec NID.  With that and the model diagram from
most vendors, it would be easy to reconfigure on the fly.



On Tue, 2008-01-15 at 21:08 +0100, Marco Schuster wrote:

> Andrew Paprocki schrieb:
> > Could this all be done through a /proc interface? For example, a
> > /proc/asound/hda directory which contained files representing the
> > different connections in the chipset?
> /proc isn't constant, right?
> Marco
> 
> PS: Is it usual here to CC all people on the thread?
> 
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

-- 
Tobin Davis  


Memory should be the starting point of the present.
