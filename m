From: Manuel Jander <manuel.jander@mat.utfsm.cl>
Subject: OpenAL- ALSA advanced features hardware support update.
Date: Sun, 21 Dec 2003 23:24:00 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1072063439.1803.31.camel@localhost>
Reply-To: manuel.jander@mat.utfsm.cl
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
To: Alsa Devel list <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Hi,

I updated my ALSA- OpenAL interface proposal, taking into account some
suggestions i have received, and some further investigations, specially
on the side of OpenAL.

Take a look at:
http://galadriel.mat.utfsm.cl/~mjander/aureal/alsa/OpenAL-ALSA.txt

AFAIK, the linux OpenAL port was not designed taken any hardware support
into account. 

Things that go against my goals are:

- OpenAL only uses one single ALSA substream. There is no substream
management (must be added).
- OpenAL is not hardware mixing aware.
- OpenAL ALSA structs must be changed to integrate hardware context
data.

Things that are favorable:

- As far as i dug into OpenAL, it seems that all source buffer
processing is done in one single place (_alMixSources). Replacing this
call for hardware assisted sources seems feasible.


The same as for the first iteration of this proposal, please take some
minutes and give some comments/suggestions back. I need feedback.

Best Regards

-- 
Manuel Jander
mjander(at)users(dot)sourceforge(dot)net



-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
