From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: Access of 2 RME Multifaces
Date: Mon, 12 Apr 2004 08:46:54 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200404121246.i3CCkt6M019899@dhin.linuxaudiosystems.com>
References: <20040412114457.GA1511@finnendahl.de>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Mon, 12 Apr 2004 13:44:58 +0200."
             <20040412114457.GA1511@finnendahl.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Orm Finnendahl <finnendahl@folkwang-hochschule.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>hope this is the right list to post: I installed to RME Pci Cards with
>a Multiface each. Running hdsploader finds and initializes both and
>hdspmixer can also get used with both cards using the card select
>buttons for card1 and card2. However after startup of jack, I only see
>18 alsa_pcm in and out ports instead of 36.

what ALSA device did you tell JACK to use?

>Can someone point me to some infos regarding where and how to
>configure that? I guess it has to be done somewhere in alsa, but I
>might be wrong...

~/.asoundrc

google for "alsa multi"

--p



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
