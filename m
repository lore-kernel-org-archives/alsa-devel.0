From: Patrick Shirkey <pshirkey@boosthardware.com>
Subject: Re: quattro multi plugin.
Date: Mon, 22 Jul 2002 20:21:25 +0900
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3D3BEAB5.9090508@boosthardware.com>
References: <Pine.LNX.4.33.0207211019300.755-100000@pnote.perex-int.cz> <3D3BD760.7060606@boosthardware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>, jackit-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Patrick Shirkey wrote:

> I will do some testing with ecasound and the native alsa drivers.
> 

Using both arecord and ecasound I can get two channels with Takashi's 
.asoundrc and 4 channels with my .asoundrc.

Both of them record two different mono streams. With my one the streams 
appear as 2 and 3 out of 4 in audacity. Stream 1 and 4 have a null 
signal. ie applying an amplification effect to the signal does nothing.

Wtih Takashis' the streams appear as 1 and 2 out of 2.

So we can still only record stereo streams and I have a funny feeling 
that the reason jack is locking is because stream 1 and 4 have no real 
signal.

If you want the soundfiles I will put them up.





-- 
Patrick Shirkey - Boost Hardware Ltd.
For the discerning hardware connoisseur
Http://www.boosthardware.com
Http://www.boosthardware.com/LAU/guide/
========================================



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
