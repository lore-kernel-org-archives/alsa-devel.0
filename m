From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: Re: speaker configuration
Date: Fri, 23 Jul 2004 02:40:17 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <41006C81.7090900@superbug.demon.co.uk>
References: <1090522504.29769.29.camel@shrek.bitfreak.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from anchor-post-32.mail.demon.net (anchor-post-32.mail.demon.net [194.217.242.90])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 1C412265
	for <alsa-devel@alsa-project.org>; Fri, 23 Jul 2004 03:40:18 +0200 (MEST)
In-Reply-To: <1090522504.29769.29.camel@shrek.bitfreak.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: "Ronald S. Bultje" <R.S.Bultje@students.uu.nl>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Ronald S. Bultje wrote:
> Hi,
> 
> if I setup a sound playback stream using N channels, how do I find out
> what the speaker configuration is? For example, my SB Audigy 2 NX
> supports (using hw: access) 2, 4, 6 and 8 channels. 2 is stereo, 8 is
> probably 7.1 (3 front, 2 side, 2 rear, 1 lfe), 6 is probably 5.1 (same
> as 7.1, without side). What is 4? If I open the card using plughw:, I
> get 1-32 channels. What does each of those mean? And related to this,
> what is the speaker's position order? In other words, if I send 8
> interleaved channelsamples of sound (1 soundsample) to my channels=8
> soundcard, on what speaker will the first, second, ... channelsample be
> played?
> 
> Thanks,
> 
> Ronald
> 

The general speaker order is:
Channel
0 - Front Left
1 - Front Right
2 - Rear Left
3 - Rear Right
4 - Center
5 - LFE
6 - Side Left
7 - Side Right

alsa provides nicer names.
For X open with device name Y.
X        Y
2.0      "plug:front"
4.0      "plug:surround40"
5.1      "plug:surround51"
7.1      "plug:surround71"




-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
