From: Guilhem Tardy <guilhem_tardy@yahoo.com>
Subject: Re: rates and frame-based formats
Date: Wed, 23 Oct 2002 11:26:14 -0700 (PDT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20021023182614.62923.qmail@web11504.mail.yahoo.com>
References: <Pine.LNX.4.33.0210231920300.5772-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.33.0210231920300.5772-100000@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

> This is very good question. We should make a decision. If we use 50Hz, we 
> can easily calculate frames per second, otherwise we have to translate 
> sampling rate to physical rate.. But it's the only good point which I see.

I am not sure how you'd translate between the two? To me, one option is to
define the number of samples per frame (which is 1 for all commonly used
formats), and then:
physical rate = sampling rate / samples per frame

Is the rate actually used for scheduling purposes? Because otherwise there's no
need for something like "physical rate".

> Also, the situation is very easy for GSM where the sampling rate is fixed, 
> but what about some variable rate compressions with different sampling 
> rate / physical rate ratio?

Although variable rate compressions can be an issue, all formats that I can
think of have a specific number of samples per frame (if you allow the fact
that MPEG-1 layer I, II and III are different formats).

Usually, a finite number of physical widths per frame translate into their
corresponding bit rates. But MPEG-1 layer III seems to be another beast by only
defining an average bit rate.

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
