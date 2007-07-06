From: joe+alsa@nahmias.net
Subject: Re: [HDA Intel/AD1984] Alsa 1.0.14 not working on
	ThinkPad T61
Date: Fri, 6 Jul 2007 16:53:07 +0000
Message-ID: <20070706165307.GA24074@nahmias.net>
References: <20070704173641.GA7087@nahmias.net> <s5hd4z76vhj.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dot.nahmias.net (dot.nahmias.net [64.71.168.40])
	by alsa0.perex.cz (Postfix) with ESMTP id 6FF981037F8
	for <alsa-devel@alsa-project.org>;
	Fri,  6 Jul 2007 18:53:08 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hd4z76vhj.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Jul 05, 2007 at 11:38:32AM +0200, Takashi Iwai wrote:
> At Wed, 4 Jul 2007 17:36:41 +0000,
> joe+alsa@nahmias.net wrote:
> > 
> > Hello,
> > 
> > I'm having trouble getting sound on my ThinkPad T61 working.  According
> > to the changelog for alsa-driver 1.0.14, support was added in that
> > version; however, no sound is coming out.
> 
> Try the latest ALSA HG version.  There are some bug fixes for AD1984
> since 1.0.14.

Thanks Takashi, latest HG seems to work for me.  Also fixes a kernel BUG
that was occuring with 1.0.14 when doing `alsactl store`.

> Takashi

--Joe
