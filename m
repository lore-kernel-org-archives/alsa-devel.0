From: "Tobias Urban" <TobiU@gmx.net>
Subject: restart after a snd_pcm_drop() call
Date: Thu, 20 Apr 2006 18:27:09 +0200 (MEST)
Message-ID: <18199.1145550429@www036.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hallo,

for several times I want to start, drop and - after a prepare call -
eventually restart my capture stream. Unfortunately I cannot get data after
the first snd_pcm_drop() call any more. The documentation tells me that this
function enters the SND_PCM_STATE_SETUP and a snd_pcm_prepare() seems to be
successful. However, a snd_pcm_wait(handle, -1) leads to a crash of the
program. If I leave out the wait() call, the program is going on but - as
mentioned above - nothing is captured any more.

It does not even work to loop the entire program including open, set
parameters, close etc.

If I understand the documentation properly I have done it all right. So is
this really a bug or do I just have to use a different function or maybe to
set a particular parameter.


Thank you for your answer!

-- 
Echte DSL-Flatrate dauerhaft für 0,- Euro*!
"Feel free" mit GMX DSL! http://www.gmx.net/de/go/dsl


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
