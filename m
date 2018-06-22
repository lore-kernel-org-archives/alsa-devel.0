From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [PATCH 2/2] ALSA: ac97: add codecs devicetree
	binding
Date: Fri, 22 Jun 2018 12:41:14 +0200
Message-ID: <874lhvnlx1.fsf@belgarion.home>
References: <20180621154356.5438-1-robert.jarzmik@free.fr>
 <20180621154356.5438-2-robert.jarzmik@free.fr>
 <s5ha7rnditx.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.smtpout.orange.fr (smtp06.smtpout.orange.fr
 [80.12.242.128])
 by alsa0.perex.cz (Postfix) with ESMTP id 668E72670D7
 for <alsa-devel@alsa-project.org>; Fri, 22 Jun 2018 12:41:20 +0200 (CEST)
In-Reply-To: <s5ha7rnditx.wl-tiwai@suse.de> (Takashi Iwai's message of "Thu,
 21 Jun 2018 21:45:46 +0200")
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

Takashi Iwai <tiwai@suse.de> writes:

>> Special review query: review the "return of_node_get(node)", which
>> assumes that upon device removal, of_put_node(dev.of_node) will be
>> called...
>
> Is it really done automagically?  I couldn't spot it.
Neither could I ...

I based this on device_set_of_node_from_dev(), and the it "seemed" logical to me
that a device probed from devicetree would take a refcnt on the devicetree node.

As the "logical" conflicted with my search for the automagical of_node_get(), I
need the special review query.

Cheers.

-- 
Robert
