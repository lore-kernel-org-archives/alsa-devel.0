From: Kai Vehmanen <kai.vehmanen@wakkanet.fi>
Subject: Re: documentation - yeah right!
Date: Wed, 21 May 2003 20:36:09 +0300 (EEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0305212030450.19955-100000@ecabase.localdomain>
References: <20030521131643.A24752@loki.cs.umass.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20030521131643.A24752@loki.cs.umass.edu>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Richard Cochran <cochran@cs.umass.edu>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Wed, 21 May 2003, Richard Cochran wrote:

> If you want generic mixing, then you must sacrifice latency. The most
> efficient mixer can be achieved if the app handles the channels
> itself.

That's just not true. Both ALSA's dmix (which is really very
very clever) and JACK provide generic mixing without increasing 
latency.

> Also, regarding latency, can someone point to any benchmarks/studies
> contrasting OSS drivers with the corresponding Alsa drivers?

Gladly, see:

http://dkc.mse.jhu.edu/~karlmac/publications/latency-icmc2001.pdf

In addition there're some notes about JACK (then known as
LAAGA). They tested OSS, but only once, as, directly 
quoting the paper:
""Only one test was done under Linux using the OSS (Open Sound System)
(www.opensound.com/oss.html) because of a lack of
reliable support for full duplex with the test system
hardware.""

-- 
 http://www.eca.cx
 Audio software for Linux!



-------------------------------------------------------
This SF.net email is sponsored by: ObjectStore.
If flattening out C++ or Java code to make your application fit in a
relational database is painful, don't do it! Check out ObjectStore.
Now part of Progress Software. http://www.objectstore.net/sourceforge
