From: Shaju Abraham <shaju@multitech.co.in>
Subject: Inserting modules on the run.
Date: Wed, 24 Jul 2002 20:19:34 +0530
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3D3EBE7E.58C9604D@multitech.co.in>
References: <E17XKRX-0007HC-00@usw-sf-list1.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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
To: Paul Davis <pbd@op.net>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi all,
         This is about OSS emulation by ALSA.   When I modprobe my sound
card,  I find that the snd-pcm-oss.o and mixer-oss.o modules are not there
in the modules list.

But when an OSS application is run, how does ALSA insert these two modules
on the fly?  Supposing I have manually inserted these two modules before
hand  and if ALSA again tries to insmod them, what will happen? could the
system crash 'cos of this?

Whenever ALSA is inserting the abv two modules on the run, it should be
possible for me to insert my own module along with the two mentioned abv,
isn't it?  Can u pls tell me where in the ALSA src code this piece of
action is happening and how to insert my own module on the run.

--shaju abraham



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
