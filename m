From: Manuel Jander <manuel.jander@mat.utfsm.cl>
Subject: ALSA - 3D api interaction (OpenAL?)
Date: Mon, 01 Sep 2003 14:19:22 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1062440362.835.1.camel@localhost>
Reply-To: mjander@mat.utfsm.cl
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
To: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Hi,

This may sound crazy, but i'm reverse engineering the A3d engine of the
Aureal Vortex Cards. The hardware interface is pretty simple, and i
guess that at least some filtering and reflection rendering can be done
in hardware with the information i was able to gather until now.

The hardest part in my opinion is the userland API. I looked at some A3D
examples, and i really liked that API a lot. Its just like OpenGL, but
its audio instead of light what you get. Is there any effort to
integrate 3D capabilities into the ALSA scheme ? any extended feature
IOCTL, or somewhat like that ? I only know about the creative labs
OpenAL implementation, but AFAIK, thats just a tweaked OSS driver, aand
its not designed to be used with other soundcards that are not made by
Crippled Labs. Any comments ?

Best Regards

Manuel Jander



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
