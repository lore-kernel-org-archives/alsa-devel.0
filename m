From: Guilhem Tardy <guilhem_tardy@yahoo.com>
Subject: rates and frame-based formats
Date: Wed, 23 Oct 2002 08:57:47 -0700 (PDT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20021023155747.15165.qmail@web11502.mail.yahoo.com>
References: <s5hfzux19ok.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hfzux19ok.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,

There are some frame-based formats defined in asound.h and pcm.h. For full-rate
GSM, frames are 260 bits every 20 ms. So my question is:
In such a case, should an application use (and the driver define) a rate of
50Hz, or the standard 8000Hz?

Thanks,
Guilhem.


__________________________________________________
Do you Yahoo!?
Y! Web Hosting - Let the expert host your web site
http://webhosting.yahoo.com/


-------------------------------------------------------
This sf.net email is sponsored by: Influence the future 
of Java(TM) technology. Join the Java Community 
Process(SM) (JCP(SM)) program now. 
http://ads.sourceforge.net/cgi-bin/redirect.pl?sunm0002en
