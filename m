From: Peter Heatwole <peter599@gotnet.net>
Subject: Re: some bits about cirrus 46xx: from LKML
Date: Sat, 16 Mar 2002 09:37:55 -0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020316173755.GE2891@porky>
References: <3C9330CF.3@tin.it>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Received: from mail.gotnet.net (mail.gotnet.net [207.173.88.4])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id SAA08375
	for <alsa-devel@alsa-project.org>; Sat, 16 Mar 2002 18:41:41 +0100
Received: from porky (unverified [66.81.80.103]) by mail.gotnet.net
 (Vircom SMTPRS 1.2.221) with ESMTP id <B0000449061@mail.gotnet.net> for <alsa-devel@alsa-project.org>;
 Sat, 16 Mar 2002 09:39:53 -0800
Content-Disposition: inline
In-Reply-To: <3C9330CF.3@tin.it>; from andrea.venturi@tin.it on Sat, Mar 16, 2002 at 03:47:27 -0800
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 2002.03.16 03:47 Andrea Venturi (personale) wrote:
> don't know if useful to anyone.. but it's a real pity to see the cirrus 
> dsp couldn't be exploited to its "real" power by lack of a single cirrus 
> people! :-(


    Just checked out the aforementioned code. It doesn't compile 
`flawlessly'
(hey, it's beta code), but it does in fact do what it says it does. There's
a mixer for the CS4294 codec, some S/PDIF hooks (though no output, it 
seems),
and the rear speakers do indeed follow the front output (using the
``enable_twocodecs=1" module parameter).
    I'm don't have very advanced knowledge of sound drivers, but am 
intenet on
learning. If anyone is willing and able to develop these drivers, I'm just
throwing my name out as willing to assist in any way.

    And if he's listening, a big thanks to Thomas Woller for releasing 
this.


-- Peter Heatwole
"Murphy was just a well known pessimist."

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
