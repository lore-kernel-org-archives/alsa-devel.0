From: "Ivica Bukvic" <ico@fuse.net>
Subject: [revisited] bug? with cs4205 and intel8x0 module
Date: Wed, 5 Mar 2003 09:52:49 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <000001c2e326$e48d40c0$aa1f830a@ICO>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
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
To: alsa-devel@lists.sourceforge.net
Cc: alsa-user@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi all, 

A while ago I posted this message, although mixed with some other false
assumptions of mine -- apologies for my ignorance( see:
http://www.mail-archive.com/alsa-devel@lists.sourceforge.net/msg05286.ht
ml thread) and then did the same thing just a couple days ago with the
whole output log as requested (see:
http://www.mail-archive.com/alsa-devel@lists.sourceforge.net/msg06824.ht
ml).

Basically, the problem remains -- that I can select the recordable audio
input from alsamixer without any problems, but I cannot do the same from
Kmix (KDE mixer), nor from the aumix. The second message contains all
the pertinent info (for instance I can select Line-input as my recording
source, but not the Mic-input).

Computer in question is Dell Inspiron 8200.

I was wondering if anyone who is familiar with amixer can tell me what
is wrong and why is Kmix refusing to offer those inputs as available
ones while Alsamixer is just fine with them? Is this a KDE problem or
Alsa problem (I thought it was KDE, but then the other Alsa soundcards
I've used work just fine under the Kmix, and then there is also aumix
which exhibits the same behavior as Kmix...)? All pertinent logs are
available in the second e-mail.

I would appreciate it if someone can help me track this issue down, as
well as explain to me where do the settings that determine available
mixer controls reside and how to edit them by hand?

Any help is greatly appreciated!

Ico



-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
