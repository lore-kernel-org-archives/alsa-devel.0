From: =?ISO-8859-1?Q?Robert_Br=FCckmann?= <killerbob@musicalica.de>
Subject: Can't link multiple streams
Date: Mon, 10 Nov 2003 17:09:40 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3FAFB844.2060301@musicalica.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
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

I have 3 capture and 3 playback devices (all sample-synced via 
wordclock) which I want to sync via snd_pcm_link(). So I do the 
following calls:

snd_pcm_link(playback1,playback2);
snd_pcm_link(playback2,playback3);
snd_pcm_link(capture1,capture2);
snd_pcm_link(capture2,capture3);
snd_pcm_link(playback1,capture1);

This worked in an older version of ALSA without problems (I used 
0.9.0beta12), but since I upgraded to 0.9.7a, I can't link, the last 
link operation gives an error:

ALSA lib pcm.c:1148:(snd_pcm_link) SNDRV_PCM_IOCTL_LINK failed: 
Operation already in progress

How can I do the linking in current Alsa versions?

Thanks,
Robert



-------------------------------------------------------
This SF.Net email sponsored by: ApacheCon 2003,
16-19 November in Las Vegas. Learn firsthand the latest
developments in Apache, PHP, Perl, XML, Java, MySQL,
WebDAV, and more! http://www.apachecon.com/
