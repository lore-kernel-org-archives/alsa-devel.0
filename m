From: Tony Hardie-Bick <tonyhb@easynet.co.uk>
Subject: Re: DTMF recognition
Date: Thu, 25 Jul 2002 18:41:20 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020725184120.B1870@siberia>
References: <E17Xjod-0005Qf-00@usw-sf-list1.sourceforge.net> <E17Xjtn-0004Zg-00@bitone.upf.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <E17Xjtn-0004Zg-00@bitone.upf.es>; from mdeboer@iua.upf.es on Thu, Jul 25, 2002 at 04:47:27PM +0200
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Maarten de Boer <mdeboer@iua.upf.es>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

> wouldn't it be easier to check for zerocrossings?

This would assume a perfect sine wave for both tones. The bad thing
about zero crossing is that even the tiniest amount of noise
completely ruins it, and then you're looking at second derivatives,
which are also dependent upon signal quality. The great thing about
dtmf, is you can find the signal even in truly bad cases.

An alternative to an fft is parallel resonant filters, but you cannot
then check non-dtmf frequencies to avoid false triggering. 

FFTW is the way to go.

Tony


-------------------------------------------------------
This sf.net email is sponsored by: Jabber - The world's fastest growing 
real-time communications platform! Don't just IM. Build it in! 
http://www.jabber.com/osdn/xim
