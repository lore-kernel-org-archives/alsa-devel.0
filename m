From: Patrick Shirkey <pshirkey@boosthardware.com>
Subject: Re: Inserting modules on the run.
Date: Thu, 25 Jul 2002 08:54:48 +0900
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3D3F3E48.70409@boosthardware.com>
References: <E17XKRX-0007HC-00@usw-sf-list1.sourceforge.net> <3D3EBE7E.58C9604D@multitech.co.in>
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
To: Shaju Abraham <shaju@multitech.co.in>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Shaju Abraham wrote:
> Hi all,
>          This is about OSS emulation by ALSA.   When I modprobe my sound
> card,  I find that the snd-pcm-oss.o and mixer-oss.o modules are not there
> in the modules list.
> 
> But when an OSS application is run, how does ALSA insert these two modules
> on the fly?  Supposing I have manually inserted these two modules before
> hand  and if ALSA again tries to insmod them, what will happen? could the
> system crash 'cos of this?
> 
> Whenever ALSA is inserting the abv two modules on the run, it should be
> possible for me to insert my own module along with the two mentioned abv,
> isn't it?  Can u pls tell me where in the ALSA src code this piece of
> action is happening and how to insert my own module on the run.
> 

You should use the /etc/modules.conf file

There is a lot of information on how to use this in the alsa-wiki and 
alsa howto.

see the documentation link on the alsa webpage.




> --shaju abraham
> 
> 
> 
> -------------------------------------------------------
> This sf.net email is sponsored by:ThinkGeek
> Welcome to geek heaven.
> http://thinkgeek.com/sf
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel
> 
> 



-- 
Patrick Shirkey - Boost Hardware Ltd.
For the discerning hardware connoisseur
Http://www.boosthardware.com
Http://www.boosthardware.com/LAU/guide/
========================================



-------------------------------------------------------
This sf.net email is sponsored by: Jabber - The world's fastest growing 
real-time communications platform! Don't just IM. Build it in! 
http://www.jabber.com/osdn/xim
