From: Martin Langer <martin-langer@gmx.de>
Subject: Re: RME installation problems
Date: Thu, 13 Feb 2003 12:08:51 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030213110851.GA3246@tuba.home>
References: <20030212183033.GD3093@finnendahl.de> <1045076338.1544.3.camel@lotte> <20030212191240.GA806@finnendahl.de> <1045078205.1545.29.camel@lotte> <20030212200740.GB806@finnendahl.de> <s5h8ywkmsrm.wl@alsa2.suse.de> <20030213104423.GB1331@finnendahl.de>
Reply-To: martin-langer@gmx.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <20030213104423.GB1331@finnendahl.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Orm Finnendahl <finnendahl@folkwang-hochschule.de>
Cc: alsa-devel@lists.sourceforge.net, tiwai@suse.de
List-Id: alsa-devel@alsa-project.org

On Thu, Feb 13, 2003 at 11:44:24AM +0100, Orm Finnendahl wrote:
> Hi Takashi,
> 
> Am Donnerstag, den 13. Februar 2003 um 10:31:09 Uhr (+0100) schrieb
> Takashi Iwai:
> 
> > > > 
> > > > ie add the 0xb revision.
> >
> > i don't see the mails on ML, so not 100% sure how to fix (although i
> > guess above mentioned to add the new revision in the check in
> > snd_rme9652_create()...) 
> 
> Yes. In the old driver it just checks for 0xa and 0x64. Just add a
> line to also check for 0xb.
> 

it's in hdsp, not rme9652!


martin


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
