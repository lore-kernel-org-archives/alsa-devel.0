From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: how to set the volumn of line input and how to
 capture data from it ?
Date: Fri, 27 Feb 2004 12:24:58 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0402271223280.13003-100000@studcom.urz.uni-halle.de>
References: <81409C6755E1D5118B8700D0B7889D3A0279E774@exchhz01.viatech.com.cn>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <81409C6755E1D5118B8700D0B7889D3A0279E774@exchhz01.viatech.com.cn>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: "Jiang Jiang (HangZhou)" <JiangJiang@viatech.com.cn>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Jiang Jiang (HangZhou) wrote:
> I find that I can use alsamixer to adjust the volumn of line
> input. But how can I set the volumn of line input by program?

See the source of the amixer utility.

> And how to capture data from line input?

See the source of the arecord utility.

> What's more, where can I find the explaniation of every item which
> alsamixer lists ?

The items in alsamixer depend on the hardware.  What sound card do you
have?


HTH
Clemens




-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
