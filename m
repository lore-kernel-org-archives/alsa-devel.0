From: Giuliano Pochini <pochini@shiny.it>
Subject: How to lock the sample rate ?
Date: Sat, 6 Mar 2004 11:54:26 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040306115426.6b48eaaf.pochini@shiny.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org



On the Echoaudio cards the sample rate is a global setting, so I need a way
to prevent an app to change the rate if someone else already set it (the
card han several devices/subdevices). I was thinking to put a simple
"if (IsAudioOpen()) rate_min=rate_max=current_rate;" in pcm_open callback,
but this solution is racy. Also what am I supposed to do about external
clock ? I can't read its value and it teoretically can change at any moment.


--
Giuliano.



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
