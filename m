From: Lee Revell <rlrevell@joe-job.com>
Subject: alsa-conf cvscompile fails with 'friend declaration requires
 class-key'
Date: Sun, 25 Jul 2004 14:57:26 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1090781846.14951.42.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Here is what happens when cvscompile runs make in alsa-conf:

make  all-recursive
make[1]: Entering directory `/home/rlrevell/cvs/alsa/alsa-conf'
Making all in newt
make[2]: Entering directory `/home/rlrevell/cvs/alsa/alsa-conf/newt'
make[2]: Nothing to be done for `all'.
make[2]: Leaving directory `/home/rlrevell/cvs/alsa/alsa-conf/newt'
make[2]: Entering directory `/home/rlrevell/cvs/alsa/alsa-conf'
if g++ -DHAVE_CONFIG_H -I. -I. -I. -I./newt    -g -Wall -ftemplate-depth-20 -MT Def.o -MD -MP -MF ".deps/Def.Tpo" \
  -c -o Def.o `test -f 'Def.cc' || echo './'`Def.cc; \
then mv -f ".deps/Def.Tpo" ".deps/Def.Po"; \
else rm -f ".deps/Def.Tpo"; exit 1; \
fi
In file included from Value.hh:26,
                 from Def.hh:27,
                 from Def.cc:22:
Ptr.hh:181: error: friend declaration requires class-key, i.e. `friend class 
   CPtr<T>'
In file included from Def.hh:27,
                 from Def.cc:22:
Value.hh:67: error: parse error before `<' token
Value.hh:70: error: parse error before `&' token
etc.

This is on Debian unstable.

Lee





-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
