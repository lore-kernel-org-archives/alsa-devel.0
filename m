From: Patrick Shirkey <pshirkey@boosthardware.com>
Subject: Re: Please help!
Date: Mon, 09 Jun 2003 01:50:39 +0900
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3EE3695F.1020905@boosthardware.com>
References: <200306071423.10875.azidog@nyc.rr.com>
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
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jacek Blizinski <azidog@nyc.rr.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Jacek Blizinski wrote:
> I'm using a Mandrake 9.1 box with an Intel (intel8x0) card and KDE as my 
> desktop environment. Thanks for any help you can provide!
> 
> Problems:
> 1. Doesnt do alsactl restore on startup
> 2. On Flash, games and other apps, the sound lags about 2-3 seconds in any WM.
> 

> Here are my KDE sound server options:
> __ARTS TAB__
> Start aRts server on KDE startup
> Run soundserver with realtime priority
> Autosuspend if idle for 60 secs
> 
> __SOUND I/O TAB__
> Enable full duplex operation
> Sound quality: 16 bits (high)
> Audio buffer size: 232 milliseconds (10 fragments with 4096 bytes)
> 


Change the latency setting (4096). Try 1024 or 512.

-- 
Patrick Shirkey - Boost Hardware Ltd.
Http://www.boosthardware.com
Http://www.djcj.org - The Linux Audio Users guide
========================================

Being on stage with the band in front of crowds shouting, "Get off! No! 
We want normal music!", I think that was more like acting than anything 
I've ever done.

Goldie, 8 Nov, 2002
The Scotsman



-------------------------------------------------------
This SF.net email is sponsored by:  Etnus, makers of TotalView, The best
thread debugger on the planet. Designed with thread debugging features
you've never dreamed of, try TotalView 6 free at www.etnus.com.
