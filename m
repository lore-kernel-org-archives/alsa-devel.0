From: Patrick Shirkey <pshirkey@boosthardware.com>
Subject: Re: new alsa docs.
Date: Fri, 09 Aug 2002 16:31:30 +0900
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3D536FD2.1030307@boosthardware.com>
References: <Pine.LNX.4.44.0208061855490.23759-100000@yme.mo.himolde.no> <3D52949C.6030706@boosthardware.com> <3D53606D.3020201@mindcom.fi> <3D5366C4.9050101@boosthardware.com>
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
Cc: ALSA Development <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

To make the module options complete I need someone to send me the output of

     modinfo $(modprobe -l snd-*) | cat > modules

when run on PPC and an ARM and a computer with old PnP cards/slots.

Run it as root user. It will write a file called modules to the 
directory you run it from.

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
