From: Orm Finnendahl <finnendahl@folkwang-hochschule.de>
Subject: Re: RME installation problems
Date: Thu, 13 Feb 2003 11:44:24 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030213104423.GB1331@finnendahl.de>
References: <20030212183033.GD3093@finnendahl.de> <1045076338.1544.3.camel@lotte> <20030212191240.GA806@finnendahl.de> <1045078205.1545.29.camel@lotte> <20030212200740.GB806@finnendahl.de> <s5h8ywkmsrm.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <s5h8ywkmsrm.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

Am Donnerstag, den 13. Februar 2003 um 10:31:09 Uhr (+0100) schrieb
Takashi Iwai:

> > > 
> > > ie add the 0xb revision.
>
> i don't see the mails on ML, so not 100% sure how to fix (although i
> guess above mentioned to add the new revision in the check in
> snd_rme9652_create()...) 

Yes. In the old driver it just checks for 0xa and 0x64. Just add a
line to also check for 0xb.

> 
> could you send a patch?

Not right now. The computer is in Rotterdam and I'm in Berlin. It
crashed so I'm waiting for someone to arrive on location and restart
it. I don't have any Alsa stuff here at the moment. Let me know if you
still need it and I'll send it to you later.

--
Orm


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
