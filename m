From: Bo Forslund <bo.forslund@abc.se>
Subject: alsa-conf doesn't compile
Date: 03 Feb 2003 23:14:05 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1044310446.7486.5.camel@li.mine.nu>
Mime-Version: 1.0
Content-Type: text/plain
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
List-Id: alsa-devel@alsa-project.org



Hello!

latest cvs version of alsa-conf doesn't compile. I get messages like
below. Do I neet to install something alsa depends on?

Thanks BF


 

g++ -DHAVE_CONFIG_H -I. -I. -I. -I./newt    -g -Wall -ftemplate-depth-20
-c Def.cc
In file included from Value.hh:26,
                 from Def.hh:27,
                 from Def.cc:22:
Ptr.hh:181: friend declaration requires class-key, i.e. `friend class
CPtr<T>'
In file included from Def.hh:27,
                 from Def.cc:22:
Value.hh:67: parse error before `<' token
Value.hh:70: parse error before `&' token
Value.hh:72: non-member function `const Field* search(const String&)'
cannot have `const' method qualifier

Do 



-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
