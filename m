From: "P. Christeas" <p_christ@hol.gr>
Subject: Re: DTMF recognition
Date: Fri, 26 Jul 2002 01:30:34 +0300
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200207252233.g6PMXxk24421@pfn1.pefnos>
References: <E17Xjod-0005Qf-00@usw-sf-list1.sourceforge.net> <E17Xjtn-0004Zg-00@bitone.upf.es> <20020725184120.B1870@siberia>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-7"
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20020725184120.B1870@siberia>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Tony Hardie-Bick <tonyhb@easynet.co.uk>, Maarten de Boer <mdeboer@iua.upf.es>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


> > wouldn't it be easier to check for zerocrossings?
>
> This would assume a perfect sine wave for both tones. The bad thing
> about zero crossing is that even the tiniest amount of noise
> completely ruins it, and then you're looking at second derivatives,
> which are also dependent upon signal quality. The great thing about
> dtmf, is you can find the signal even in truly bad cases.
>
> An alternative to an fft is parallel resonant filters, but you cannot
> then check non-dtmf frequencies to avoid false triggering.
>
> FFTW is the way to go.

I'm an engineer and such a problem had been a standard case for our studies.
In DTMF, you only want to check for a specific set of frequencies.
Say you have a signal 'f(t)', where t is the time. A frequency (tone) is a 
signal in the form of 'sin(a*t)'. To detect that tone, you only need to check
g(t) = f(t) * sin(a*t)
this is what fft does, but fft will do that for a very wide range of 
frequencies. Read any engineering maths, and you may find a good way of 
checking a signal against some known frequency.
Don't rely on zerocrossings, phase difference may ruin the results. The 
correlation (that's its name; the multiplication I explained) stuff has 
amazingly good results..


-------------------------------------------------------
This sf.net email is sponsored by: Jabber - The world's fastest growing 
real-time communications platform! Don't just IM. Build it in! 
http://www.jabber.com/osdn/xim
