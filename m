From: Lennart Poettering <mznyfn@0pointer.de>
Subject: Re: snd_pcm_rewind() weirdness
Date: Thu, 24 Apr 2008 02:38:57 +0200
Message-ID: <20080424003857.GA28425@tango.0pointer.de>
References: <20080419233738.GA18371@tango.0pointer.de>
	<Pine.LNX.4.61.0804210855520.7882@tm8103.perex-int.cz>
	<20080424003434.GA27865@tango.0pointer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tango.0pointer.de (tango.0pointer.de [85.214.72.216])
	by alsa0.perex.cz (Postfix) with ESMTP id 9BADD2475A
	for <alsa-devel@alsa-project.org>;
	Thu, 24 Apr 2008 02:38:57 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080424003434.GA27865@tango.0pointer.de>
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

On Thu, 24.04.08 02:34, Lennart Poettering (mznyfn@0pointer.de) wrote:

> > > Hey!
> > > 
> > > On ALSA 1.0.16 with the HDA driver I am experiencing some weird things
> > > with snd_pcm_rewind() which I think are the result of a kernel bug,
> > > but I am not sure.
> > 
> > What alsa-lib plugins are on path? It looks like a rate plugin issue. Post 
> > also snd_pcm_dump() output. Driver does not do any alignment.
> 
> It's front:0. I don't think the rate plugin is used. 

OK, I just checked this with using hw:0, i.e. without softvol in the
path. That seems to fix the problem, so I guess softvol is to blame.

BTW: any comment regarding http://mailman.alsa-project.org/pipermail/alsa-devel/2008-April/007354.html?

Lennart

-- 
Lennart Poettering                        Red Hat, Inc.
lennart [at] poettering [dot] net         ICQ# 11060553
http://0pointer.net/lennart/           GnuPG 0x1A015CC4
