From: Patrick Shirkey <pshirkey@boosthardware.com>
Subject: Re: Re: Alsa-devel digest, Vol 1 #1207 - 14 msgs
Date: Thu, 05 Jun 2003 04:44:25 +0900
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3EDE4C19.4050600@boosthardware.com>
References: <E19NYdu-0004A9-00@sc8-sf-list2.sourceforge.net>	 <200306041124.16908.n8gray@caltech.edu> <1054755927.10453.12.camel@Wizard.knechthome.com>
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
To: Mark Knecht <markknecht@attbi.com>
Cc: Alsa-Devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Mark Knecht wrote:
> 
> 
> Probably true, but I was told that using aplay would be automatic also,
> and it wasn't. I've had to associate a pcm.!default entity to get it to
> work, so something is not quite right. I continue to wonder if something
> similar is effecting the OSS part of this machine.
> 

Have you also symlinked /dev/dsp to /dev/adsp0 as that will allow oss 
apps to use the hw:0,1 channel?


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
