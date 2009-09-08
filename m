From: Lennart Poettering <mznyfn@0pointer.de>
Subject: Re: Is there a way to figure out if the clocks of
	two	snd_pcm_t's deviate? (snd_pcm_info_get_sync?)
Date: Wed, 9 Sep 2009 01:13:45 +0200
Message-ID: <20090908231344.GB32605@tango.0pointer.de>
References: <20090903230351.GA7493@tango.0pointer.de>
	<alpine.LNX.2.00.0909040831390.20533@eeebox2.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tango.0pointer.de (tango.0pointer.de [85.214.72.216])
	by alsa0.perex.cz (Postfix) with ESMTP id 11C4C2435D
	for <alsa-devel@alsa-project.org>;
	Wed,  9 Sep 2009 01:14:10 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.0909040831390.20533@eeebox2.perex-int.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Fri, 04.09.09 08:44, Jaroslav Kysela (perex@perex.cz) wrote:

> All standard soundcards have only one clock source, so if  
> snd_pcm_info_get_card() number matches, the streams will most probably  
> run in sync.

Hmm, does this also mean that SPDIF output and analog output of the
same sound card stay in sync on most cards?

> I would suggest to match card number as default for used streams and add  
> an user option to modify the stream word clock configuration for your 
> app.

OK, sounds good.

Lennart

-- 
Lennart Poettering                        Red Hat, Inc.
lennart [at] poettering [dot] net
http://0pointer.net/lennart/           GnuPG 0x1A015CC4
