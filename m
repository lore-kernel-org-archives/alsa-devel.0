From: Farhan Husain <russoue@gmail.com>
Subject: Need help about ALSA
Date: Sat, 9 Oct 2004 14:11:45 +0600
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3df32b6d041009011138c5ba8b@mail.gmail.com>
Reply-To: Farhan Husain <russoue@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

I tried to run a very simple capture program with ALSA. But the following line:

snd_pcm_open(&capture_handle, "plughw:0,0", SND_PCM_STREAM_CAPTURE, 0)

returns error:

"No such file or directory"

Can anybody help me about that? I installed the "alsa-lib-1.0.6" and
faced no problem during installation. Do I have to install any special
driver for soundcard? I haven't installed anything for soundcard.

__________________
Farhan


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
