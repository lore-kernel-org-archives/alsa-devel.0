From: Kai Vehmanen <kai.vehmanen@wakkanet.fi>
Subject: Re: rc4 is out
Date: Wed, 23 Oct 2002 15:28:47 +0300 (EEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0210231527110.13314-100000@ecabase.localdomain>
References: <20021023140057.6ee7b1d8.mdeboer@iua.upf.es>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from ecabase.localdomain (cs78169135.pp.htv.fi [62.78.169.135])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id OAA04186
	for <alsa-devel@alsa-project.org>; Wed, 23 Oct 2002 14:30:32 +0200
In-Reply-To: <20021023140057.6ee7b1d8.mdeboer@iua.upf.es>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Maarten de Boer <mdeboer@iua.upf.es>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, 23 Oct 2002, Maarten de Boer wrote:

> I just installed alsa-driver-0.9.0rc4, but alas.... i get invalid parameter
> when modprobing...

Unload all rc3 modules, check your /etc/modules.conf (replace all 
instances of 'snd_xxx' with 'xxx' (but not 'snd-xxx'!), and try
modprobing snd-emu10k1 again.

-- 
 http://www.eca.cx
 Audio software for Linux!



-------------------------------------------------------
This sf.net emial is sponsored by: Influence the future 
of Java(TM) technology. Join the Java Community 
Process(SM) (JCP(SM)) program now. 
http://ads.sourceforge.net/cgi-bin/redirect.pl?sunm0002en
