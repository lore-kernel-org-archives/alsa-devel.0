From: =?iso-8859-1?Q?J=F6rn?= Nettingsmeier <nettings@folkwang-hochschule.de>
Subject: header files problem in current cvs
Date: Thu, 07 Feb 2002 13:21:46 +0100
Message-ID: <3C62715A.DEB429AE@folkwang-hochschule.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

hello * !


./cvscompile in alsa-lib bails out with:

checking for alsa-driver package... not found or wrong version
configure: error: Install alsa-driver v0.9.0 package first...

config.log says it does not find sound/asound.h

after copying the headers to /usr/include/alsa by hand and setting
up a link from /usr/include/linux/sound it compiles.

i may be misunderstanding the new directory structure.

is 
cd alsa-driver && ./cvscompile && make install && cd ../alsa-lib &&
./cvscompile && make install ...
not going to work anymore ?

the build script has never worked for me. do i need to use it ?

regards,

jörn





-- 
Jörn Nettingsmeier     
home://Kurfürstenstr.49.45138.Essen.Germany      
phone://+49.201.491621
http://spunk.dnsalias.org
http://www.linuxdj.com/audio/lad/

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
