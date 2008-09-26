From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: ALSA:ATMEL: common arch for audio via ssc(patch
	3/3: adding directories)
Date: Fri, 26 Sep 2008 13:50:36 +0100
Message-ID: <20080926125035.GB15493@sirena.org.uk>
References: <48DCAA3A.8030209@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 71AEB10381B
	for <alsa-devel@alsa-project.org>;
	Fri, 26 Sep 2008 14:50:37 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <48DCAA3A.8030209@atmel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Sedji Gaouaou <sedji.gaouaou@atmel.com>
Cc: alsa-devel@alsa-project.org, Haavard Skinnemoen <haavard.skinnemoen@atmel.com>, Geoffrey Wossum <geoffrey@pager.net>, Frank Mandarino <fmandarino@endrelia.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Sep 26, 2008 at 11:24:10AM +0200, Sedji Gaouaou wrote:
> This last patch contains the board specific files.
> I have not changed playpaq_wm8510.c, and I did few changes on 
> eti_b1_wm8731.c.

It'd be better to submit this as two separate patches, one making the
modifications to eti_b1_wm8731.c and another doing the simple code move
(in either order).  This would make it easier to review the changes -
due to the file move they're not really visible in the current patch.

It'd also be good to see acks from Frank and Geoffrey since I can't test
any of this.

Thanks for doing this work - it looks good, unifying the support for the
AT91 and AVR32 platforms is a substantial win and it's good to see Atmel
contributing this support.
