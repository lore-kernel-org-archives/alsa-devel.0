From: Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Subject: snd-seq: change in module dependencies?
Date: 01 Apr 2003 11:09:36 -0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1049224176.18536.20.camel@cmn37.Stanford.EDU>
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
To: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

I have noticed a change in the behavior of the snd-seq module. It no
longer seems to be loaded automatically (this started to happen around
0.9.1 or so). I had to change the alsasound script to load it explicitly
for things to work as before. 

If I do not do that a program that needs it (for example kaconnect) will
just exit with an error ("open /dev/snd/seq failed: No such file or
directory"). Am I missing something?

-- Fernando




-------------------------------------------------------
This SF.net email is sponsored by: ValueWeb: 
Dedicated Hosting for just $79/mo with 500 GB of bandwidth! 
No other company gives more support or power for your dedicated server
http://click.atdmt.com/AFF/go/sdnxxaff00300020aff/direct/01/
