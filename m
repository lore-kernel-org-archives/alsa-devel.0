From: "Robert Rozman" <rozman@fri.uni-lj.si>
Subject: Can I mix more sources when oss device is taken ?
Date: Sun, 4 Jul 2004 13:41:12 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <047701c461bb$cf03d510$ef4902c1@Lapitopi>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
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
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,

I'm using mythtv (great PVR gui app) and currently it seems like it's native
alsa support is broken (oss works ok). So I have to give up dmix access and
get exclusive access to sound device to mythtv only (through oss emulation
on dev/dsp).

But since I'd love to be able to access sound device also from other apps
(for speech synthesis, messages):
- I wonder if there is possibility to somehow mix other sounds coming from
dmix or native alsa interfaces to oss one
- how to easily check if oss device is taken (possibly with some CLI tool) ?
- are there any other possibilities for workaround ?

Thanks in advance,

Robert.



-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
