From: Paolo Losi <p.losi@hypersonic.it>
Subject: Event Based time synchronization with ALSA
Date: Mon, 17 Jan 2005 11:50:28 +0100
Message-ID: <41EB9874.4060407@hypersonic.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

Hi all,
	I'd like to develop a sip phone using alsa...

All the app is going to be event based (no_blocking io, poll).

One of the issues is how to read 20ms sample periods
to build an rtp packet

What I'd like to understand is if I can rely on interrupts (poll
read data available event) by HW in order to get accurate 50HZ
poll frequency or I must rely on poll timeout instead...

My goal is (as always :-) ) to reduce as much as I can latency...

In the case poll events would be enough what would be the
relevant sw_params api's?

	Thank you very much

	PL


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
